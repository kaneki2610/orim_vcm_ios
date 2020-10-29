import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/components/InforWindow.dart';
import 'package:orim/components/info_window_item.dart';
import 'package:orim/config/enum_packages/map.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/marker.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/home/tab/map/map_page.dart';
import 'package:orim/pages/send_complain/send_complain_page.dart';
import 'package:orim/utils/debounce.dart';
import 'package:orim/utils/gallery_storage/gallery_storage.dart';
import 'package:orim/utils/geocoder_utils.dart';
import 'package:orim/utils/permission.dart';
import 'package:orim/viewmodel/category.dart';
import 'package:orim/viewmodel/helper.dart';
import 'package:orim/viewmodel/location.dart';
import 'package:orim/viewmodel/marker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:orim/base/subject.dart';

class MapBlocOfficer extends BaseBloc {
  MapBlocOfficer({@required BuildContext context}) : super(context: context);

  CategoryViewModel _categoryViewModel;
  LocationViewModel _locationViewModel;
  MarkerViewModel _markerViewModel;
  List<Marker> markers = [];
  Completer<GoogleMapController> controller = Completer();
  LatLng positionCurrent;

  LatLng position;
  String locationName = "";
  final Debounce _debouncer = Debounce(milliseconds: 500);

  BehaviorSubject<String> _addressName = BehaviorSubject();

  Stream<String> get addressObserver => _addressName.stream;

  Future<bool> turnOnGPS() async {
    return await _locationViewModel.turnOnGPS();
  }
  HelperViewModel _helperViewModel;
  CameraPosition _kGooglePlex;
  CameraPosition get kGooglePlex{
    if(this._kGooglePlex == null){
      this.createCameraMap(this._helperViewModel.appConfigModel.locationDefault);
    }
    if(this._kGooglePlex == null){
      final CameraPosition location = CameraPosition(
        target: EnumMap.locationDefault,
        zoom: EnumMap.zoom11,
      );
      return location;
    }
    print("location " + _kGooglePlex.target.latitude.toString() + " " +_kGooglePlex.target.longitude.toString());


    return this._kGooglePlex;
  }
  BehaviorSubject<List<Marker>> _markersSubject = BehaviorSubject();

  Stream<List<Marker>> get markerStream => _markersSubject.stream;

  StreamSubscription _mapIdleSubscription;
  InfoWidgetRoute _infoWidgetRoute;

  Future<bool> checkLocationPermission() async {
    return await _locationViewModel.checkLocationPermission();
  }

  Future<bool> requestLocationPermission() async {
    return await _locationViewModel.requestLocationPermission();
  }

  Future<bool> getCurrentLocation() async {
    positionCurrent = await _locationViewModel.getCurrentLocationDevice();
    if (positionCurrent != null) {
      final GoogleMapController _controller = await this.controller.future;
      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: positionCurrent,
        zoom: EnumMap.zoom11,
      )));
    }
    return positionCurrent != null;
  }

  void onUpdateLocation(LatLng position) async {
    _debouncer.run(() async {
      this.position = position;
      try {
        locationName = await GeocoderUtils.getAddressLine(position);
      } catch (err) {
        print('getAddressLineError $err');
      }
      _addressName.value = locationName;
      moveToPosition();
    });
  }

  Future<void> moveToPosition() async {
    if (controller?.isCompleted != null) {
      final GoogleMapController _controller = await controller.future;
      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: this.position,
        zoom: EnumMap.zoom11,
      )));
    }
  }

  Future<void> getList() async {
    try {
      await _categoryViewModel.loadData();
    } catch (err) {
      print(err);
    }
  }

  void gotoLogin() {
    NavigatorService.gotoSignIn(context);
  }

  void gotoSendComplain() {
    final arguments = SendComplainArguments();
    NavigatorService.gotoSendComplain(context, arguments: arguments);
  }

  void complete(GoogleMapController c) {
    controller.complete(c);
  }

  void refresh() {
    this.getListMarkers();
  }

  void gotoAttachmentsPicker(AssetType type) {
    Navigator.of(context).pop();
    bool openCamera = false;
    bool openVideo = false;
    bool openGallery = false;
    bool openVideoMemory = false;
    switch(type) {
      case AssetType.image:
        openGallery = true;
        break;
      case AssetType.camera:
        openCamera = true;
        break;
      case AssetType.video:
        openVideo = true;
        break;
      case AssetType.video_memory:
        openVideoMemory = true;
        break;
    }
    final arguments = SendComplainArguments(
        gotoPhotoLibrary: openGallery,
        openCameraView: openCamera,
        openVideoView: openVideo,
        openVideoMemory: openVideoMemory
    );
    NavigatorService.gotoSendComplain(context, arguments: arguments);
  }

  Future<bool> checkLocationPermissionIsNotShow() async {
    return await PermissionUtils.checkPermissionIsNotShowAgain(
        Permission.location);
  }

  openSetting() {
    PermissionUtils.openSetting();
  }

  @override
  void dispose() {
    this._markersSubject.close();
    this._addressName.close();
  }

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    _categoryViewModel = Provider.of<CategoryViewModel>(context);
    _locationViewModel = Provider.of<LocationViewModel>(context);
    _markerViewModel = Provider.of<MarkerViewModel>(context);

    this._helperViewModel = Provider.of(context);
    if(this._kGooglePlex == null){
      this.createCameraMap(this._helperViewModel?.appConfigModel?.locationDefault);
    }
  }

  bool back() {
    return NavigatorService.back(context);
  }

  void initDefaultLocation() {
    positionCurrent = _locationViewModel.locationDefault;
  }
  Future<void> getListMarkers() async {
    ResponseListNew<MarkerModel> response;
    response =  await _markerViewModel.getMarkers();
    if(response.isSuccess()) {
      markers = response.datas.map((item) {
        PointObject point = PointObject(location: LatLng(item.location.latitude, item.location.longitude), child: this.getInfoWindow(item));
        return Marker(
            markerId: MarkerId("marker" + item.createOn),
            draggable: true,
            position: point.location,
            onTap: (){
              tapMarker(point);
            }
        );
      }).toList();
      if(markers.length > 0){
        this.createCameraMap(markers.first.position);
      }
      this.zoomMap();
      this._markersSubject.value = markers;
    } else if (response.isExpired()) {
      this.observerLogout();
    } else {
      _markersSubject.addError(response.msg ?? "");
    }
  }

  tapMarker(PointObject point)async {
    final RenderBox renderBox = context.findRenderObject();
    Rect _itemRect = renderBox.localToGlobal(Offset.zero) & renderBox.size;
    _infoWidgetRoute = InfoWidgetRoute(
      child: Container(
        child: point.child,
      ),
      buildContext: context,
      textStyle: const TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      mapsWidgetSize: _itemRect,
    );
    final GoogleMapController _controller = await this.controller.future;
    await _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            point.location.latitude - 0.0001,
            point.location.longitude,
          ),
          zoom: EnumMap.zoom19,
        ),
      ),
    ).then((value) {
      if (_infoWidgetRoute != null) {
        _mapIdleSubscription?.cancel();
        _mapIdleSubscription =
            Future.delayed(Duration(milliseconds: 150)).asStream().listen((_) {
              Navigator.of(context, rootNavigator: true)
                  .push(_infoWidgetRoute)
                  .then<void>(
                    (newValue) {
                  _infoWidgetRoute = null;
                },
              );
            });
      }
    });
    await _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            point.location.latitude,
            point.location.longitude,
          ),
          zoom: EnumMap.zoom19,
        ),
      ),
    );
  }

  Widget getInfoWindow(MarkerModel model){
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          InfoWindowItem(StringResource.getText(context, "info_window_address"), model.areaDetail, 2),
          SizedBox(height: 5.0,),
          InfoWindowItem(StringResource.getText(context, "info_window_time_send_complain"), model.createOn, 1),
          SizedBox(height: 5.0,),
          InfoWindowItem(StringResource.getText(context, "info_window_content"), model.content, 2),
          SizedBox(height: 5.0,),
          InfoWindowItem(StringResource.getText(context, "info_window_user_send_complain"), model.contactName, 1),
          SizedBox(height: 5.0,),
          InfoWindowItem(StringResource.getText(context, "info_window_phone"), model.contactPhone, 1),
        ],
      ),
    );
  }

  onMoveCamera(){
//    _mapIdleSubscription?.cancel();
//    _mapIdleSubscription =
//        Future.delayed(Duration(milliseconds: 150))
//            .asStream()
//            .listen((_) {
//          if (_infoWidgetRoute != null) {
//            Navigator.of(context, rootNavigator: false)
//                .push(_infoWidgetRoute)
//                .then<void>(
//                  (newValue) {
//                _infoWidgetRoute = null;
//              },
//            );
//          }
//        });
  }
  void createCameraMap(LatLng location){
    if(location != null) {
      print("location " + location.latitude.toString() + " " +location.longitude.toString());
      this._kGooglePlex = CameraPosition(
        target: location,
        zoom: EnumMap.zoom11,
      );
    }
  }

  Future<void> zoomMap() async {
    final GoogleMapController _controller = await this.controller.future;
    await _controller
        .animateCamera(
      CameraUpdate.newCameraPosition(
        this.kGooglePlex,
      ),
    );
  }

}
