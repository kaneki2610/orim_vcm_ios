import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/config/enum_packages/enum_filter_type.dart';
import 'package:orim/config/enum_packages/map.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/entities/category/category.dart';
import 'package:orim/entities/modal_map/area_response.dart';
import 'package:orim/model/area/area_model.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/observer/create_issue.dart';
import 'package:orim/pages/attachments_picker/attachments_picker_page.dart';
import 'package:orim/pages/send_complain/modal/modal_info/modal_info.dart';
import 'package:orim/pages/send_complain/send_complain_page.dart';
import 'package:orim/pages/send_complain/send_complain_view.dart';
import 'package:orim/pages/show_full_gallery/show_full_meida.dart';
import 'package:orim/utils/gallery_storage/attachement.dart';
import 'package:orim/utils/gallery_storage/gallery_storage.dart';
import 'package:orim/utils/geocoder_utils.dart';
import 'package:orim/utils/permission.dart';
import 'package:orim/utils/progress_dialog_loading.dart';
import 'package:orim/utils/task_runner.dart';
import 'package:orim/viewmodel/category.dart';
import 'package:orim/viewmodel/issue.dart';
import 'package:orim/viewmodel/location.dart';
import 'package:orim/viewmodel/resident_info.dart';
import 'package:orim/viewmodel/user_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart' as PM;
import 'package:provider/provider.dart';

import 'modal/modal_fields/modal_field.dart';
import 'modal/modal_map/modal_map.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class SendComplainBloc extends BaseBloc {
  SendComplainBloc({
    @required BuildContext context,
    @required SendComplainView view,
    @required this.arguments,
  })  : attachments = [],
        super(context: context) {
    this.view = view;
    _attachmentsSubject.value = attachments;
    position.value = EnumMap.locationDefault;
  }

  final SendComplainArguments arguments;
  SendComplainView view;
  LocationViewModel _locationViewModel;
  CategoryViewModel _categoryViewModel;
  UserInfoViewModel _userInfoViewModel;
  ResidentInfoViewModel _residentInfoViewModel;
  CreateIssueObserver _createIssueObServer;

  GalleryStorage _galleryStorage;
  IssueViewModel _issueViewModel;
  ProgressDialogLoading _progressDialogLoading;

  TextEditingController contentController = TextEditingController();
  FocusNode contentFocusNode = FocusNode();
  BehaviorSubject<String> _contentSubject = BehaviorSubject();

  Stream<String> get contentStream => _contentSubject.stream;

  BehaviorSubject<LatLng> position = BehaviorSubject();

  Stream<LatLng> get positionObserver => position.stream;
  final MarkerId markerId = MarkerId('myMarker');
  Completer<GoogleMapController> _controller = Completer();

  List<Marker> markers = [];
  BehaviorSubject<List<Marker>> _markerSubject = BehaviorSubject();

  Stream<List<Marker>> get markerObserver => _markerSubject.stream;

  String locationName = '';
  BehaviorSubject<String> _locationSubject = BehaviorSubject();

  Stream<String> get locationObserver => _locationSubject.stream;

  CategoryData _categorySelected;
  BehaviorSubject<CategoryData> _categorySubject = BehaviorSubject();

  Stream<CategoryData> get categoryObserver => _categorySubject.stream;

  List<Attachment> attachments;
  BehaviorSubject<List<Attachment>> _attachmentsSubject = BehaviorSubject();

  Stream<List<Attachment>> get attachmentsObserver => _attachmentsSubject.stream;

  BehaviorSubject<bool> _isOpenGpsSubject = BehaviorSubject();

  Stream<bool> get isOpenGpsStream => _isOpenGpsSubject.stream;

  String name = '';
  String phone = '';

  bool get canContinue =>
      arguments.gotoPhotoLibrary ||
      arguments.openVideoView ||
      arguments.openCameraView ||
      arguments.openVideoMemory;

  bool get mapIsReady => _controller.isCompleted;

  BehaviorSubject<bool> _googleMapSubject = BehaviorSubject();

  final TaskRunner task = TaskRunner();

  bool isEnableGPS = true;

  CurrentProvince currentProvince;
  CurrentDistrict currentDistrict;
  CurrentWard currentWard;
  bool isChangedArea = false;
  bool isChangeCategory = false;
  String nameCategory = "";
  int maxImage = 5;

  Future<void> showTextCategory(String nameSubCategory) async {
    if (contentController.text == "") {
      contentController.value = TextEditingValue(text: nameSubCategory);
    } else if (isChangeCategory) {
      contentController.value = TextEditingValue(text: contentController.text);
    } else {
      contentController.value = TextEditingValue(text: nameSubCategory);
    }
  }

  Future<void> initLocation() async {
    if (!this.isEnableGPS) {
      position.value = await this.helperViewModel.getPositionDefault();
    } else {
      try {
        position.value = await _locationViewModel.getCurrentLocationOnMap();
      } catch (err) {
        print(err);
      }
    }
  }

  Future<void> getArea() async {
    ResponseObject<AreaModel> areaResponse;
    String positionValue = this.position.value.toString();
    String latLng =
        positionValue.substring(7, positionValue.length - 1).replaceAll(RegExp(r"\s+"), "");
    areaResponse = await this._locationViewModel.getArea(latlng: latLng, name: this.locationName);

    if (areaResponse.isSuccess()) {
      this.currentProvince = areaResponse.data.currentProvince;
      this.currentDistrict = areaResponse.data.currentDistrict;
      this.currentWard = areaResponse.data.currentWard;
    } else {
      print("${areaResponse.msg}");
    }
  }

  void moveToPosition() async {
    if (_controller.isCompleted) {
      if (!isEnableGPS) {
        this._locationSubject.value = EnumFilterType.isEnableGPS;
      }
      final GoogleMapController controller = await _controller.future;
      task.executeDelay(() async {
        controller
            ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: position.value,
          zoom: EnumMap.zoom19,
        )))
            ?.then((_) async {
          await _getLocationName();
          if (await _showMarker()) {
            if (markerId != null) {
              try {
                controller?.showMarkerInfoWindow(markerId);
                if (!isChangedArea) {
                  await this.getArea();
                }
              } catch (err) {
                print(err);
              }
            }
          }
          task.cancel();
        });
      }, milliseconds: 100);
    }
  }

  void complete(GoogleMapController controller) {
    print('complete');
    if (!_controller.isCompleted) {
      _controller.complete(controller);
      _googleMapSubject.value = true;
      _googleMapSubject.close();
    }
  }

  Future<bool> _showMarker() async {
    if (position != null) {
      String location =
          _locationNameIsLoading() ? StringResource.getText(context, 'loading') : locationName;
      markers.clear();
      Marker marker = Marker(
          markerId: markerId,
          draggable: false,
//          infoWindow: InfoWindow(
//              title: StringResource.getText(context, 'location_happening'),
//              snippet: location),
          position: position.value);
      markers.add(marker);
      _markerSubject.value = markers;
      _locationSubject.value = location;
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    contentController.dispose();
    contentFocusNode.dispose();
    position.close();
    _contentSubject.close();
    _markerSubject.close();
    _locationSubject.close();
    _categorySubject.close();
    _attachmentsSubject.close();
    _googleMapSubject.close();
    _isOpenGpsSubject.close();
  }

  bool _locationNameIsLoading() {
    return locationName.isEmpty || locationName == '';
  }

  Future<void> _getLocationName() async {
    locationName = await GeocoderUtils.getAddressLine(position.value);
  }

  void updateLocation(LatLng positionNew, String locationNameNew, CurrentProvince province,
      CurrentDistrict district, CurrentWard ward) {
    if (district != this.currentDistrict || ward != this.currentWard) {
      isChangedArea = true;
    } else {
      isChangedArea = false;
    }
    position.value = positionNew;
    locationName = locationNameNew;
    this.currentProvince = province;
    this.currentDistrict = district;
    this.currentWard = ward;
    // renew marker
    markers.clear();
    Marker marker = Marker(
        markerId: markerId,
        draggable: false,
//        infoWindow: InfoWindow(
//            title: StringResource.getText(context, 'location_happening'),
//            snippet: locationName),
        position: position.value);
    markers.add(marker);
    _markerSubject.value = markers;
    _locationSubject.value = locationName;
    moveToPosition();
  }

  selectedItem({String code, String parentCode}) async {
    CategoryData categoryData =
        await _categoryViewModel.getCategoryByCodeAndParentCode(parentCode, code);
    if (categoryData != null) {
      _categorySelected = categoryData;
      _categorySubject.value = _categorySelected;
      nameCategory = _categorySelected.subCategories[0].name;
      this.showTextCategory(categoryData.subCategories[0].name);
    }
  }

  bool get isSelectedCategoryItem {
    return _categorySelected != null ? true : false;
  }

  bool checkDataIsValid() {
    String content = contentController.value.text;
    LatLng position = this.position.value;
    String locationName = this.locationName;
    CategoryData categorySelected = _categorySelected;
    List<Attachment> attachments = this.attachments;
    String name = this.name;
    String phone = this.phone;

    if (content == '') {
      _contentSubject.addError(StringResource.getText(context, 'missing_content'));
      contentFocusNode.requestFocus();
      return false;
    } else {
      contentFocusNode.unfocus();
      _contentSubject.value = null;
    }
    if (position == null || locationName == null || locationName == '') {
      Fluttertoast.showToast(msg: StringResource.getText(context, 'missing_location'));
      showModalMap();
      return false;
    }
    if (categorySelected == null) {
      Fluttertoast.showToast(msg: StringResource.getText(context, 'missing_category'));
      showModalField();
      return false;
    }
    if (name == '' || phone == '') {
      showModalInfo();
      return false;
    }
    return true;
  }

  void sendComplain() async {
    this.currentProvince = null;
    this.currentDistrict = null;
    this.currentWard = null;
    await _progressDialogLoading.show();

    String content = contentController.value.text;
    LatLng position = this.position.value;
    String locationName = this.locationName;
    CategoryData categorySelected = _categorySelected;
    List<Attachment> attachments = this.attachments;
    String name = this.name;
    String phone = this.phone;

    final onError = () async {
      await _progressDialogLoading.hide();
      Fluttertoast.showToast(msg: StringResource.getText(context, 'issuse_send_failed'));
    };
    _issueViewModel
        .sendIssue(
      content: content,
      position: position,
      areaDetail: locationName,
      categoryData: categorySelected,
      name: name,
      phone: phone,
      currentProvince: this.currentProvince,
      currentDistrict: this.currentDistrict,
      currentWard: this.currentWard,
    )
        .then((ResponseObject<String> responseObject) {
      if (responseObject.isSuccess()) {
        _issueViewModel.addIssueToLocal(responseObject.data).then((isSaved) async {
          if (isSaved) {
            print('attachments ${attachments.length}');
            if (attachments.length > 0) {
              _issueViewModel.uploadAttachments(attachments, responseObject.data, (sent, total) {
                _progressDialogLoading.updateProgress(sent, total);
              }).then((ResponseObject<bool> res) async {
                if (res.isSuccess()) {
                  if (res.data) {
                    await _progressDialogLoading.hide();
                    Fluttertoast.showToast(
                        msg: StringResource.getText(context, 'issuse_send_completed'));
                    NavigatorService.gotoHome(context);
                  } else {
                    await _progressDialogLoading.hide();
                    Fluttertoast.showToast(
                        msg: StringResource.getText(context, 'issuse_send_failed'));
                  }
                } else {
                  await _issueViewModel.removeIssueToLocal(responseObject.data);
                  onError();
                }
              });
            } else {
              await _progressDialogLoading.hide();
              Fluttertoast.showToast(msg: StringResource.getText(context, 'issuse_send_completed'));
              NavigatorService.gotoHome(context);
            }
          } else {
            onError();
          }
          this.observerCreate();
        });
      } else {
        onError();
      }
    });
  }

  void showModalField() {
    if (contentController.text != "" && contentController.text != nameCategory) {
      isChangeCategory = true;
    }
    FocusScope.of(context).unfocus();
    final argument =
        ModalFieldArguments(categoryData: arguments.categoryData, callback: selectedItem);
    NavigatorService.showModalField(context, arguments: argument);
  }

  void showModalMap() {
    FocusScope.of(context).unfocus();
    final arguments = ModalMapArguments(
      locationName: locationName,
      position: position.value,
      currentProvince: this.currentProvince,
      currentDistrict: this.currentDistrict,
      currentWard: this.currentWard,
      callback: updateLocation,
    );
    NavigatorService.showModalMap(context, arguments: arguments);
  }

  Future showModalAttachments() async {
    if (!_isCheckVideoTypeInAttachments("")) {
      if (this.helperViewModel.appConfigModel.chooseDefaultImages) {
        //file : data/user/0/com.orim.newdemo/cache/IMG_1594612193222.png
        FocusScope.of(context).unfocus();
        List<File> files = [];
        List<Asset> resultList = List<Asset>();
        try {
          resultList = await MultiImagePicker.pickImages(
            maxImages: this.maxImage,
            enableCamera: false,
            materialOptions: MaterialOptions(
              selectionLimitReachedText:
                  "${StringResource.getText(context, "alert_choose_image")} ${this.maxImage}",
            ),
          );
        } catch (e) {
          print(e.toString());
        }

        for (var asset in resultList) {
          final filePath = await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
          File tempFile = File(filePath);
          if (tempFile.existsSync()) {
            files.add(tempFile);
          }
        }
        _setAttachment(files);
      } else {
        //'/storage/emulated/0/Pictures/Screenshots/Screenshot_2020-04-28-08-52-44.png'
        FocusScope.of(context).unfocus();
        final arguments =
            AttachmentPickerArguments(listImage: attachments, callback: updateAttachment);
        NavigatorService.gotoAttachmentPicker(context, arguments: arguments);
      }
    } else {
      this.view.showToastWithMessage(StringResource.getText(context, "choose_image"));
    }
  }

  void getCategory() {
    if (arguments.gotoCategories) {
      _categorySubject.value = arguments.categoryData;
    } else {
      _categorySubject.value = null;
    }
  }

  void showModalInfo() {
    FocusScope.of(context).unfocus();
    ModalInfoArguments arguments = ModalInfoArguments(callback: updateNameAndPhoneThenSendIssue);
    NavigatorService.showModalInfo(context, arguments: arguments);
  }

  updateNameAndPhoneThenSendIssue(String name, String phone) {
    this.name = name;
    this.phone = phone;
    sendComplain();
  }

  bool removeAttachment(Attachment attachment) {
    if (attachments.remove(attachment)) {
      _attachmentsSubject.value = attachments;
      return true;
    }
    return false;
  }

  void updateAttachment(List<Attachment> attachments) {
    if (attachments != null) {
      this.attachments.addAll(attachments);
      _attachmentsSubject.value = this.attachments;
    }
  }

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    _locationViewModel = Provider.of<LocationViewModel>(context);
    _categoryViewModel = Provider.of<CategoryViewModel>(context);
    _userInfoViewModel = Provider.of<UserInfoViewModel>(context);
    _residentInfoViewModel = Provider.of<ResidentInfoViewModel>(context);
    _issueViewModel = Provider.of<IssueViewModel>(context);
    _galleryStorage = Provider.of<GalleryStorage>(context);
    this._createIssueObServer = Provider.of<CreateIssueObserver>(context);
    if (_progressDialogLoading == null) {
      _progressDialogLoading = ProgressDialogLoading(context: context);
    }
  }

  void loadInfoSender() {
    if (position == null) {
      position.value = _locationViewModel.locationDefault;
    }
    if (name.isEmpty || phone.isEmpty) {
      _residentInfoViewModel.loadDataResident().then((_) {
        if (_residentInfoViewModel.data != null) {
          name = _residentInfoViewModel.data.name;
          phone = _residentInfoViewModel.data.phone;
        }
      });
    }
  }

  void next() async {
    FocusScope.of(context).unfocus();
    if (this.arguments.gotoPhotoLibrary) {
      this.showModalAttachments();
      this.arguments.gotoPhotoLibrary = false;
    } else if (this.arguments.openCameraView) {
      this.openCameraView();
      this.arguments.openCameraView = false;
    } else if (this.arguments.openVideoView) {
      this.openVideoView();
      this.arguments.openVideoView = false;
    } else {
      this.openVideoMemory();
      this.arguments.openVideoMemory = false;
    }
  }

/*  void nextIfNeed() async {
    if (arguments.gotoPhotoLibrary) {
      showModalAttachments();
      arguments.gotoPhotoLibrary = false;
    } else if (arguments.gotoCategories) {
      showModalField();
      arguments.gotoCategories = false;
    } else {
      await initLocation();
      print('nextIfNeed');
      moveToPosition();
    }
  }*/

  Future<void> openVideoView() async {
    FocusScope.of(context).unfocus();
    if (await checkPermission()) {
      if (NavigatorService.back(context)) {
        File fileVideo;
        try {
          fileVideo = await ImagePicker.pickVideo(source: ImageSource.camera);
        } catch (err) {
          print(err);
        }
        if (fileVideo != null) {
//          await _galleryStorage.saveVideo(fileVideo);
          _afterSave(fileVideo, PM.AssetType.video);
        }
      }
    } else {
      NavigatorService.back(context);
    }
  }

  bool _isCheckVideoTypeInAttachments(String type) {
    if (this.attachments != null) {
      if (this.attachments.length > 0) {
        int countSelectedImage = 0;
        for (final attachment in this.attachments) {
          if (attachment.isVideo()) {
            if (type == "video") {
              return true;
            }
          }
          if (attachment.isImage()) {
            countSelectedImage++;
            this.maxImage = 5 - countSelectedImage;
          }
          if (countSelectedImage == 5) {
            return true;
          }
        }
      }
    }
    return false;
  }

  void openVideoMemory() async {
    if (!_isCheckVideoTypeInAttachments("video")) {
      if (await checkPermission()) {
        if (NavigatorService.back(context)) {
          File fileVideo;
          File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
          fileVideo = video;
          if (fileVideo != null) {
            await _galleryStorage.saveVideo(fileVideo);
            _afterSave(fileVideo, PM.AssetType.video);
          }
        }
      } else {
        NavigatorService.back(context);
      }
    } else {
      Navigator.of(context).pop();
      this.view.showToastWithMessage(StringResource.getText(context, "choose_video"));
    }
  }

  Future<void> openCameraView() async {
    FocusScope.of(context).unfocus();
    if (await checkPermission()) {
      if (NavigatorService.back(context)) {
        File fileImage;
        try {
          fileImage = await ImagePicker.pickImage(source: ImageSource.camera);
        } catch (err) {
          print(err);
        }
        if (fileImage != null) {
          await _galleryStorage.saveImage(fileImage);
          _afterSave(fileImage, PM.AssetType.image);
        }
      }
    } else {
      NavigatorService.back(context);
    }
  }

  void _setAttachment(List<File> files) {
    List<Attachment> attachments = [];
    if (files != null) {
      for (File file in files) {
        Attachment attachment = Attachment(
          file: file,
          type: PM.AssetType.image,
        );
        attachments.add(attachment);
      }
      updateAttachment(attachments);
    }
  }

  void _afterSave(File file, PM.AssetType type) {
    if (file != null) {
      Attachment attachment = Attachment(
        file: file,
        type: type,
      );
      attachments.add(attachment);
      _attachmentsSubject.value = attachments;
    }
  }

  StreamSubscription listenMapIsReady(Function(bool) callback) {
    return _googleMapSubject.listen(callback);
  }

  Future<bool> checkPermission() async {
    final List<Permission> listPermission = [
      Permission.storage,
      Permission.microphone,
      Permission.camera
    ];

    final Map<Permission, PermissionStatus> permissions =
        await PermissionUtils.requestPermissions(listPermission);
    bool res = true;
    for (final value in permissions.values) {
      res = res && value == PermissionStatus.granted;
    }
//    print('res $res');
    return res;
  }

  onTapMedia(Attachment attachment) {
    ShowFullMediaArguments arguments = ShowFullMediaArguments(
        positionSelect: this.attachments.indexOf(attachment), medias: this.attachments);
    NavigatorService.gotoShowFullGallery(context, arguments: arguments);
  }

  observerCreate() {
    this._createIssueObServer.data = true;
  }

  Future<void> getLocationCurrent() async {
    if (await this.turnOnGPS()) {
      this.checkLocationPermissionIsNotShow().then((res) async {
        if (res) {
          this.showNoticeWhenPermissionNotGrant();
        } else {
          if (await this.requestLocationPermission()) {
            this.isEnableGPS = true;
            this.view.isEnableGPS();
          } else {
            this.isEnableGPS = false;
            this.view.showToastWithMessage(StringResource.getText(context, "gps_title"));
            this.view.isEnableGPS();
          }
        }
      });
    }
  }

  void showNoticeWhenPermissionNotGrant() {
    this._locationViewModel.showNoticeWhenPermissionNotGrant(context, () {}, () {
      _openSetting();
    });
  }

  _openSetting() {
    PermissionUtils.openSetting();
  }

  Future<bool> turnOnGPS() async {
    return await _locationViewModel.turnOnGPS();
  }

  Future<bool> requestLocationPermission() async {
    return await _locationViewModel.requestLocationPermission();
  }

  Future<bool> checkLocationPermissionIsNotShow() async {
    return await PermissionUtils.checkPermissionIsNotShowAgain(Permission.location);
  }
}
