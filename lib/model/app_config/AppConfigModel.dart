import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppConfigModel {
  LatLng locationDefault;
  String areaCodeCurrent;
  bool isDistrict;
  bool chooseDefaultImages; // true: default , false: custom

  AppConfigModel({this.locationDefault, this.areaCodeCurrent, this.isDistrict}) {
    this.locationDefault = LatLng(21.019324,105.8072043);
    this.areaCodeCurrent = "3_16";
    this.isDistrict = true;
    this.chooseDefaultImages = true;
  }
}

