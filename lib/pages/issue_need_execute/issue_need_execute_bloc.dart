import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/category_execute_model.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/attachments_picker/attachments_picker_page.dart';
import 'package:orim/pages/issue_map/issue_map_page.dart';
import 'package:orim/pages/issue_process/issue_process_page.dart';
import 'package:orim/pages/show_full_gallery/show_full_meida.dart';
import 'package:orim/utils/gallery_storage/attachement.dart';
import 'package:orim/utils/gallery_storage/gallery_storage.dart';
import 'package:orim/utils/permission.dart';
import 'package:orim/viewmodel/category_execute.dart';
import 'package:orim/viewmodel/issue.dart';
import 'package:orim/viewmodel/send_info_process.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart' as PM;
import 'package:provider/provider.dart';

import 'issue_need_execute_view.dart';

class IssueNeedExecuteBloc extends BaseBloc {
  IssueNeedExecuteBloc(
      {BuildContext context, IssueNeedExecuteView view, IssueModel model})
      : model = model,
        view = view,
        super(context: context);

  final IssueModel model;
  IssueNeedExecuteView view;

  CategoryExecuteViewModel categoryExecuteViewModel;
  SendInfoProcessViewModel sendInfoProcessViewModel;
  IssueViewModel issueViewModel;
  GalleryStorage _galleryStorage;

  List<CategoryExecuteModel> categoriesExe = [];

  BehaviorSubject<CategoryExecuteModel> _categoryExecuteSubject =
      BehaviorSubject();

  Stream<CategoryExecuteModel> get categorySelectObserver =>
      _categoryExecuteSubject.stream;

  BehaviorSubject<String> _contentExecuteSubject = BehaviorSubject();

  Stream<String> get contentExecute => _contentExecuteSubject.stream;

  TextEditingController contentExecuteController = TextEditingController();
  FocusNode contentExecuteFocusNode = FocusNode();

  BehaviorSubject<List<Attachment>> attachmentsExecute =
      BehaviorSubject(value: []);

  Stream<List<Attachment>> get attachmentsExecuteObserver =>
      attachmentsExecute.stream;

  int maxImage = 5;

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    categoryExecuteViewModel = Provider.of<CategoryExecuteViewModel>(context);
    _galleryStorage = Provider.of<GalleryStorage>(context);
    sendInfoProcessViewModel = Provider.of<SendInfoProcessViewModel>(context);
    issueViewModel = Provider.of<IssueViewModel>(context);
  }

  Future<void> loadData() async {
    loadCategoriesExecute();
  }

  void viewLocation() {
    IssueMapPageArguments arguments = IssueMapPageArguments(
        location: model.location, position: model.position);
    print('position: ${model.position.longitude} - ${model.position.latitude}');
    NavigatorService.showModalIssueMap(context, arguments: arguments);
  }

  void viewProcess() {
    showIssueProcess(context, issueId: model.id);
  }

  @override
  void dispose() {
    _categoryExecuteSubject.close();
    _contentExecuteSubject.close();
    contentExecuteController.dispose();
    contentExecuteFocusNode.dispose();
  }

  void selectCategoryExecute({int index}) {
    if (index < categoriesExe.length) {
      _categoryExecuteSubject.value = categoriesExe[index];
    }
  }

  Future<void> loadCategoriesExecute() async {
    categoriesExe = await categoryExecuteViewModel.getCategoriesExecute();
  }

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
        print('fileVideo ${fileVideo != null}');
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
    if(this.attachmentsExecute.value != null) {
      if(this.attachmentsExecute.value.length > 0) {
        int countSelectedImage = 0;
        for(final attachment in this.attachmentsExecute.value) {
          if(attachment.isVideo()) {
            if(type == "video") {
              return true;
            }
          }
          if(attachment.isImage()) {
            countSelectedImage++;
            this.maxImage = 5 - countSelectedImage;
          }
          if(countSelectedImage == 5) {
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
      this.view.showMessage(msg: StringResource.getText(context, "choose_video"));
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

  void _afterSave(File file, PM.AssetType type) {
    if (file != null) {
      Attachment attachment = Attachment(
        file: file,
        type: type,
      );
      List<Attachment> listCurrent = attachmentsExecute.value;
      listCurrent.add(attachment);
      attachmentsExecute.value = listCurrent;
    }
  }

  Future showModalAttachments() async {
    if(!_isCheckVideoTypeInAttachments("")) {
      if(this.helperViewModel.appConfigModel.chooseDefaultImages) {
        //file : data/user/0/com.orim.newdemo/cache/IMG_1594612193222.png
        FocusScope.of(context).unfocus();
        List<File> files = [];
        List<Asset> resultList = List<Asset>();
        resultList = await MultiImagePicker.pickImages(
          maxImages : this.maxImage,
          enableCamera: false,
          materialOptions: MaterialOptions(
            selectionLimitReachedText:
            "${StringResource.getText(context, "alert_choose_image")} ${this.maxImage}",
          ),
        );

        for (var asset in resultList) {
          final filePath = await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
          File tempFile = File(filePath);
          if(tempFile.existsSync()) {
            files.add(tempFile);
          }
        }
        _setAttachment(files);
      } else {
        //'/storage/emulated/0/Pictures/Screenshots/Screenshot_2020-04-28-08-52-44.png'
        FocusScope.of(context).unfocus();
        final arguments = AttachmentPickerArguments(
            listImage: attachmentsExecute.value, callback: updateAttachment);
        NavigatorService.gotoAttachmentPicker(context, arguments: arguments);
      }
    } else {
      this.view.showMessage(msg: StringResource.getText(context, "choose_image"));
    }
  }

  void _setAttachment(List<File> files) {
    List<Attachment> attachments = [];
    if(files != null) {
      for(File file in files) {
        Attachment attachment = Attachment(
          file: file,
          type: PM.AssetType.image,
        );
        attachments.add(attachment);
      }
      updateAttachment(attachments);
    }
  }

  showImageView(Attachment attachment) {
    ShowFullMediaArguments arguments = ShowFullMediaArguments(
        positionSelect: attachmentsExecute.value.indexOf(attachment),
        medias: attachmentsExecute.value);
    NavigatorService.gotoShowFullGallery(context, arguments: arguments);
  }

  removeAttachment(Attachment attachment) {
    List<Attachment> listCurrent = attachmentsExecute.value;
    if (listCurrent.remove(attachment)) {
      attachmentsExecute.value = listCurrent;
      return true;
    }
    return false;
  }

  void updateAttachment(List<Attachment> attachments) {
    if (attachments != null) {
      List<Attachment> listCurrent = attachmentsExecute.value;
      listCurrent.addAll(attachments);
      attachmentsExecute.value = listCurrent;
    }
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
    return res;
  }

  void submit() async {
    if (dataIsValid()) {
      await view.showLoading();
      String content = contentExecuteController.text;
      CategoryExecuteModel categoryExecuteModel = _categoryExecuteSubject.value;
      final ResponseObject<bool> res =
          await sendInfoProcessViewModel.sendExecute(
              issueId: model.id,
              comment: content,
              categoryExeId: categoryExecuteModel.id);
      if (res.isSuccess()) {
        final bool resUpload = await sendAttchment();
        view.sendExecuteSuccess();
        await view.hideLoading();
        NavigatorService.back(context);
//        if (resUpload) {
//          NavigatorService.back(context);
//        } else {
//          view.sendExecuteFailed();
//        }
      } else {
        view.sendExecuteFailed();
      }
    }
  }

  bool dataIsValid() {
    String content = contentExecuteController.text;
    CategoryExecuteModel categoryExecuteModel = _categoryExecuteSubject.value;
    if (context == null || content.length == 0) {
      _contentExecuteSubject.addError(
          StringResource.getText(context, 'issue_process_no_content_execute'));
      return false;
    } else {
      _contentExecuteSubject.value = null;
    }
    if (categoryExecuteModel == null) {
      view.showMessageNoCategoryExecute();
      view.openCategoriesExecute();
      return false;
    }
    return true;
  }

  Future<bool> sendAttchment() async {
    List<Attachment> attachments = attachmentsExecute.value;
    if (attachments.length > 0) {
      ResponseObject<bool> res = await issueViewModel
          .uploadAttachments(attachments, model.id, (sent, total) {
        print('send $sent - total $total');
      });
      if (res.isSuccess()) {
        return true;
      }
      return false;
    }
    return true;
  }

}
