import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/config/enum_packages/map.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/entities/modal_map/area_response.dart';
import 'package:orim/model/area/area_model.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/send_complain/modal/modal_map/modal_map_view.dart';
import 'package:orim/utils/debounce.dart';
import 'package:orim/utils/dialog/dialog_util.dart';
import 'package:orim/utils/geocoder_utils.dart';
import 'package:orim/utils/permission.dart';
import 'package:orim/viewmodel/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:orim/base/subject.dart';

class ModalMapBloc extends BaseBloc {
  ModalMapBloc(
      {BuildContext context,
      LatLng position,
      locationName,
      dis,
      ward,
      province,
      @required ModalMapView view})
      : this.position = position,
        this.locationName = locationName,
        this.currentDistrict = dis,
        this.currentWard = ward,
        this.province = province,
        super(context: context) {
    this.view = view;
  }

  ModalMapView view;

  final Debounce _debouncer = Debounce(milliseconds: 500);
  TextEditingController locationTextController = TextEditingController();

  LatLng position;
  String locationName;
  MarkerId _markerId = MarkerId('myMarker');
  Marker marker;
  LocationViewModel _locationViewModel;
  LatLng positionCurrent;
  Completer<GoogleMapController> _controller = Completer();

  BehaviorSubject<Marker> _markerSubject = BehaviorSubject();

  Stream<Marker> get markerObserver => _markerSubject.stream;

  BehaviorSubject<String> _addressName = BehaviorSubject();

  Stream<String> get adressObserver => _addressName.stream;

  BehaviorSubject<CurrentProvince> _provincesSubject = BehaviorSubject();

  Stream<CurrentProvince> get provincesStream => _provincesSubject.stream;

  BehaviorSubject<CurrentDistrict> _districtSubject = BehaviorSubject();

  Stream<CurrentDistrict> get districtsStream => _districtSubject.stream;

  BehaviorSubject<CurrentWard> _wardSubject = BehaviorSubject();

  Stream<CurrentWard> get wardStream => _wardSubject.stream;

  AreaModel _areaResponse;
  List<CurrentWard> currentWards = [];
  String districtCode = "";
  String wardCode = "";
  CurrentProvince currentProvince;
  CurrentDistrict currentDistrict;
  CurrentWard currentWard;
  CurrentProvince province;

  void complete(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void onUpdateLocation(LatLng position) async {
    _debouncer.run(() async {
      this.position = position;
      try {
        locationName = await GeocoderUtils.getAddressLine(position);
        this.getArea(locationName);
      } catch (err) {
        print('getAddressLineError $err');
      }
      createMarker();
      moveToPosition();
    });
  }

  void getArea(String name) async {
    ResponseObject<AreaModel> areaResponse;
    String latLng = "";
    latLng = "${this.position.latitude},${this.position.longitude}";

    this.view.showLoading();
    areaResponse =
        await this._locationViewModel.getArea(latlng: latLng, name: name);

    if (areaResponse.isSuccess()) {
      this._areaResponse = areaResponse.data;
      this.view.hideLoading();
      this._provincesSubject.value = areaResponse.data.currentProvince;
      this._districtSubject.value = areaResponse.data.currentDistrict;
      this._wardSubject.value = areaResponse.data.currentWard;

      if(areaResponse.data.currentDistrict != null) {
        this.districtCode = areaResponse.data.currentDistrict.code;
      }
      if(areaResponse.data.currentWard != null) {
        this.wardCode = areaResponse.data.currentWard.code;
      }
      this.currentProvince = areaResponse.data.currentProvince;
      this.currentDistrict = areaResponse.data.currentDistrict;
      this.currentWard = areaResponse.data.currentWard;
    } else {
      print("${areaResponse.msg}");
      this._provincesSubject.value = null;
      this._districtSubject.value = null;
      this._wardSubject.value = null;
    }
  }

  void setData() async {
    if(!this._locationViewModel.isViewMap) {
      this._locationViewModel.isViewMap = true;
      this.getArea(this.locationName);
    } else {
      ResponseObject<AreaModel> areaResponse;
      String latLng = "";
      latLng = "${this.position.latitude},${this.position.longitude}";
      areaResponse = await this._locationViewModel.getArea(latlng: latLng, name: locationName);
      this._areaResponse = areaResponse.data;

      this._provincesSubject.value = this.province;
      this._districtSubject.value = this.currentDistrict;
      this._wardSubject.value = this.currentWard;
      this.districtCode = this.currentDistrict != null ? this.currentDistrict.code : "";
      this.wardCode = this.currentWard != null ? this.currentWard.code : "";
      this.currentProvince = this.province;
      this.filterDistrict(this.currentDistrict.code);
    }
  }

  void selectWard() {
      DialogUtil().showWardDialog(context, code: this.wardCode, wards: this.currentWards,
        callback: (CurrentWard item) {
      this.wardCode = item.code;
      this._wardSubject.value = item;
      this.currentWard = item;
    });
  }

  void selectDistrict() {
       List<DistrictList> districtsResponse = this._areaResponse.districtList;
    List<CurrentDistrict> districts = [];
    for (DistrictList value in districtsResponse) {
      districts.add(CurrentDistrict(
          id: value.id,
          code: value.code,
          name: value.name,
          areaCode: value.areaCode,
          parentCode: value.parentCode,
          type: value.type));
    }
    DialogUtil().showDistrictDialog(context,
        name: this.districtCode,
        districts: districts, callback: (CurrentDistrict item) {
      this.filterDistrict(item.code);
      this.districtCode = item.code;
      CurrentWard currentWard = CurrentWard(id: "0");
      this._wardSubject.value = currentWard;
      this.currentDistrict = item;
      this.currentWard = null;
    });
  }

  void filterDistrict(String code) {
    List<DistrictList> districtsResponse = this._areaResponse.districtList;
    for (DistrictList value in districtsResponse) {
      if (value.code == code) {
        this._districtSubject.value = CurrentDistrict(
            id: value.id,
            code: value.code,
            name: value.name,
            areaCode: value.areaCode,
            parentCode: value.parentCode,
            type: value.type);
        this.currentWards = value.wardList;
        break;
      }
    }
  }

  bool checkSelectAreaIsValid() {
    if (this.currentProvince == null ||
        this.currentDistrict == null ||
        this.currentWard == null) {
      this.view.showToastWithMessage(
          StringResource.getText(context, "no_filter_area"));
      return false;
    }
    return true;
  }

  void createMarker() {
    marker = Marker(
        markerId: _markerId,
        draggable: true,
        infoWindow: InfoWindow(
            title: StringResource.getText(context, 'location_happening'),
            snippet: locationName),
        onDragEnd: onUpdateLocation,
        position: position);
    _markerSubject.value = marker;
    _addressName.value = locationName;
  }

  @override
  void dispose() {
    _markerSubject.close();
    _addressName.close();
    _provincesSubject.close();
    _districtSubject.close();
    _wardSubject.close();
  }

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    _locationViewModel = Provider.of<LocationViewModel>(context);
  }

  bool back() {
    return NavigatorService.back(context);
  }

  Future<void> moveToPosition() async {
    if (_controller?.isCompleted != null) {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: position,
        zoom: EnumMap.zoom19,
      )));
    }
  }

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
      this.onUpdateLocation(positionCurrent);
    }
    return positionCurrent != null;
  }

  Future<bool> checkLocationPermissionIsNotShow() async {
    return await PermissionUtils.checkPermissionIsNotShowAgain(
        Permission.location);
  }

  void showNoticeWhenPermissionNotGrant() {
    this._locationViewModel.showNoticeWhenPermissionNotGrant(context, () {},
        () {
      _openSetting();
    });
  }

  _openSetting() {
    PermissionUtils.openSetting();
  }
}
