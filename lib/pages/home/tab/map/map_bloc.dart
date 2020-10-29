import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/components/InforWindow.dart';
import 'package:orim/components/info_window_item.dart';
import 'package:orim/config/enum_packages/map.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/entities/category/categories_model.dart';
import 'package:orim/entities/category/category.dart';
import 'package:orim/model/marker.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/send_complain/send_complain_page.dart';
import 'package:orim/utils/gallery_storage/gallery_storage.dart';
import 'package:orim/utils/permission.dart';
import 'package:orim/viewmodel/category.dart';
import 'package:orim/viewmodel/helper.dart';
import 'package:orim/viewmodel/location.dart';
import 'package:orim/viewmodel/marker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:orim/base/subject.dart';

import 'map_page.dart';

class MapBloc extends BaseBloc {
  MapBloc({@required BuildContext context}) : super(context: context) {}

  CategoryViewModel _categoryViewModel;
  LocationViewModel _locationViewModel;
  MarkerViewModel _markerViewModel;
  HelperViewModel _helperViewModel;
  CameraPosition _kGooglePlex;

  CameraPosition get kGooglePlex {
    if (this._kGooglePlex == null) {
      this.createCameraMap(
          this._helperViewModel.appConfigModel.locationDefault);
    }
    if (this._kGooglePlex == null) {
      final CameraPosition location = CameraPosition(
        target: EnumMap.locationDefault,
        zoom: EnumMap.zoom11,
      );
      return location;
    }
    return this._kGooglePlex;
  }

  Completer<GoogleMapController> controller = Completer();
  LatLng positionCurrent;
  List<Marker> markers = [];
  BehaviorSubject<List<CategoryData>> _categoriesSubject = BehaviorSubject();

  Stream<List<CategoryData>> get categoriesStream => _categoriesSubject.stream;

  BehaviorSubject<List<Marker>> _markersSubject = BehaviorSubject();

  Stream<List<Marker>> get markerStream => _markersSubject.stream;

  StreamSubscription _mapIdleSubscription;
  InfoWidgetRoute _infoWidgetRoute;

  Future<bool> turnOnGPS() async {
    return await _locationViewModel.turnOnGPS();
  }

  Future<bool> checkLocationPermission() async {
    return await _locationViewModel.checkLocationPermission();
  }

  Future<bool> requestLocationPermission() async {
    return await _locationViewModel.requestLocationPermission();
  }

  Future<bool> getCurrentLocation() async {
    positionCurrent = await _locationViewModel.getCurrentLocationDevice();
    if (positionCurrent != null) {
      final GoogleMapController _controller = await controller.future;
      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: positionCurrent,
        zoom: EnumMap.zoom11,
      )));
    }
    return positionCurrent != null;
  }

  Future<void> getList() async {
    if (_categoryViewModel.data != null) {
      _categoriesSubject.value = _categoryViewModel.data;
    } else {
      try {
        await _categoryViewModel.loadData();
        _categoriesSubject.value = _categoryViewModel.data;
      } catch (err) {
        print(err);
        _categoriesSubject.addError(err);
      }
    }
    await _handleSaveCategoriesIcon(_categoryViewModel.data);
  }

  Future<void> _handleSaveCategoriesIcon(
      List<CategoryData> categoryData) async {
    List<CategoriesModel> categories = [];
    for (var i = 0; i < categoryData.length; i++) {
      categories.add(CategoriesModel(
          id: categoryData[i].id,
          icon: categoryData[i].icon,
          name: categoryData[i].name
      ));
    }
    if (categories != null) {
      this._helperViewModel.saveCategoryIcons(categories);
    }
  }

  Future<void> getListMarkers() async {
    ResponseListNew<MarkerModel> response;
    response = await _markerViewModel.getMarkers();

    if (response.isSuccess()) {
      markers = response.datas.map((item) {
        PointObject point = PointObject(
            location: LatLng(item.location.latitude, item.location.longitude),
            child: this.getInfoWindow(item));
        return Marker(
            markerId: MarkerId("marker" + item.createOn),
            draggable: true,
            position: point.location,
            onTap: () {
              tapMarker(point);
            });
      }).toList();
      if (markers.length > 0) {
        this.createCameraMap(markers.first.position);
      }
      this.zoomMap();
      print(this._kGooglePlex.target.toString());
      this._markersSubject.value = markers;
    } else if (response.isExpired()) {
      this.observerLogout();
    } else {
      _markersSubject.addError(response.msg);
    }
  }

  tapMarker(PointObject point) async {
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
        height: 115.0);
    final GoogleMapController _controller = await this.controller.future;
    await _controller
        .animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            point.location.latitude - 0.0001,
            point.location.longitude,
          ),
          zoom: EnumMap.zoom19,
        ),
      ),
    )
        .then((value) {
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

  Widget getInfoWindow(MarkerModel model) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          InfoWindowItem(
              StringResource.getText(context, "info_window_address"),
              model.areaDetail, 2),
          SizedBox(
            height: 5.0,
          ),
          InfoWindowItem(
              StringResource.getText(context, "info_window_time_send_complain"),
              model.createOn, 1),
          SizedBox(
            height: 5.0,
          ),
          InfoWindowItem(StringResource.getText(context, "info_window_content"),
              model.content, 2),
        ],
      ),
    );
  }

  onMoveCamera() {
//    _mapIdleSubscription?.cancel();
//    _mapIdleSubscription =
//        Future.delayed(Duration(milliseconds: 150))
//            .asStream()
//            .listen((_) {
//          if (_infoWidgetRoute != null) {
//            Navigator.of(context, rootNavigator: true)
//                .push(_infoWidgetRoute)
//                .then<void>(
//                  (newValue) {
//                _infoWidgetRoute = null;
//              },
//            );
//          }
//        });
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

  void gotoLogin() {
    NavigatorService.gotoSignIn(context);
  }

  void gotoSendComplain(CategoryData categoryData) {
    final arguments = SendComplainArguments(
        gotoCategories: true,
        categoryData: categoryData
    );
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
    }
    final arguments = SendComplainArguments(
      gotoPhotoLibrary: openGallery,
      openCameraView: openCamera,
      openVideoView: openVideo
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
    _categoriesSubject.close();
    _markersSubject.close();
  }

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    _categoryViewModel = Provider.of<CategoryViewModel>(context);
    _locationViewModel = Provider.of<LocationViewModel>(context);
    _markerViewModel = Provider.of<MarkerViewModel>(context);
    this._helperViewModel = Provider.of(context);
    if (this._kGooglePlex == null) {
      this.createCameraMap(
          this._helperViewModel.appConfigModel.locationDefault);
    }
  }

  bool back() {
    return NavigatorService.back(context);
  }

  void initDefaultLocation() {
    positionCurrent = _locationViewModel.locationDefault;
  }

  void showNoticeWhenPermissionNotGrant() {
    this._locationViewModel.showNoticeWhenPermissionNotGrant(context, () {
      this.back();
    }, () {
      if (this.back()) {
        this.openSetting();
      }
    });
  }

  void createCameraMap(LatLng location) {
    if (location != null) {
      this._kGooglePlex = CameraPosition(
        target: location,
        zoom: EnumMap.zoom11,
      );
    }
  }
}
