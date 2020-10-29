import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as Location;
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/viewmodel.dart';
import 'package:orim/config/enum_packages/map.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/entities/modal_map/area_response.dart';
import 'package:orim/model/area/area_model.dart';
import 'package:orim/repositories/area/area_repo.dart';
import 'package:orim/utils/alert_dialog.dart';

class LocationViewModel extends BaseViewModel<LatLng> {
  // data is position current of marker on map or position recent which user choose

  static LocationViewModel _locationViewModel;

//  static LocationViewModel getInstance() {
//    if (_locationViewModel == null) {
//      _locationViewModel = LocationViewModel();
//    }
//    return _locationViewModel;
//  }
  bool isViewMap = false;
  final LatLng locationDefault = EnumMap.locationDefault;
  final Geolocator _geolocator = Geolocator();
  Location.Location location = Location.Location();
  AreaRepo areaRepo;

  Future<ResponseObject<AreaModel>> getArea ({String latlng, String name}) async {
    return await areaRepo.getArea(latlng: latlng, name: name);
  }

  Future<bool> turnOnGPS() async {
    bool serviceIsEnabled = await location.serviceEnabled();
    if (!serviceIsEnabled) {
      serviceIsEnabled = await location.requestService();
    }
    return serviceIsEnabled;
  }

  Future<bool> checkLocationPermission() async {
    GeolocationStatus geolocationStatus =
        await _geolocator.checkGeolocationPermissionStatus();
    switch (geolocationStatus) {
      case GeolocationStatus.granted:
      case GeolocationStatus.restricted:
        return true;
      case GeolocationStatus.denied:
      case GeolocationStatus.disabled:
      case GeolocationStatus.unknown:
      default:
        return false;
    }
  }

  Future<bool> requestLocationPermission() async {
    Location.PermissionStatus permissionStatus =
        await location.requestPermission();
    switch (permissionStatus) {
      case Location.PermissionStatus.GRANTED:
        return true;
      case Location.PermissionStatus.DENIED:
      case Location.PermissionStatus.DENIED_FOREVER:
      default:
        return false;
    }
  }

  Future<LatLng> getCurrentLocationOnMap() async {
    if (data != null) {
      return data;
    } else {
      data = await getCurrentLocationDevice();
      return data;
    }
  }

  Future<LatLng> getCurrentLocationDevice() async {
    print('getCurrentLocationDevice');
    Position position = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (position != null) {
      LatLng positionCurrentDevice =
          LatLng(position.latitude, position.longitude);
      return positionCurrentDevice;
    } else {
      throw ('get current location errr');
    }
  }

  void showNoticeWhenPermissionNotGrant(BuildContext context, Function functionNo, Function functionYes) {
    AlertDialogBuilder(
      context: context,
      title: StringResource.getText(context, 'permission_deny_title'),
      content: StringResource.getText(context, 'permission_content_request'),
    ).show(
      actions: [
        AlertDialogBuilder.button(
          text: StringResource.getText(context, 'no'),
          onPress: (){
            if(functionNo != null){
              functionNo();
            }
          },
        ),
        AlertDialogBuilder.button(
          text: StringResource.getText(context, 'yes'),
          onPress: () {
            if(functionYes != null){
              functionYes();
            }
          },
        )
      ],
    );
  }
}
