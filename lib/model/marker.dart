
import 'package:geolocator/geolocator.dart';
import 'package:orim/entities/object/marker/marker.dart';
import 'package:orim/utils/time_util.dart';

class MarkerModel {
  String areaDetail;
  String contactPhone;
  String contactName;
  String content;
  Position location;
  String createOn;
  MarkerModel({this.areaDetail, this.content, this.contactName, this.contactPhone, this.location, this.createOn});
  static MarkerModel from(Marker mk){
    String time = "";
    if(mk.createdOn != null){
      time = TimeUtil.convertStringToTextDate(mk.createdOn) + " " +  TimeUtil.convertStringToTextTime(mk.createdOn);
    }
    return MarkerModel(areaDetail: mk.areadetail, content: mk.content, contactName: mk.contact?.name ?? "", contactPhone: mk.contact?.phoneNumber ?? "", location: mk.position, createOn: time);
  }
}