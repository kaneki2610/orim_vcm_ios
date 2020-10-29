import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:orim/entities/modal_map/area_response.dart';
import 'package:orim/model/area/area_model.dart';

part 'send_issue_request.g.dart';

@JsonSerializable()
class SendIssueRequest {
  String Content;
  String Level = 'RKC';
  String Location; // String format lat,lng,
  String Areadetail;
  CategoryDataRequest Category;
  SubcategoryDataRequest Subcategory;
  ContactDataRequest Contact;
  String ReceptionChannel = 'mobile';
  CurrentProvince currentProvince;
  CurrentDistrict currentDistrict;
  CurrentWard currentWard;
  InformationChannelRequest InformationChannel;

  SendIssueRequest(
      {this.Content,
      LatLng location,
      this.Areadetail,
      String categoryCode,
      String categoryName,
      String subcategoryCode,
      String subcategoryName,
      String name,
      String phone,
      String address,
      String email,
      this.currentProvince,
      this.currentDistrict,
      this.currentWard,
      String token})
      : this.Location = '${location.latitude},${location.longitude}',
        this.Category =
            CategoryDataRequest(Code: categoryCode, Name: categoryName),
        this.Subcategory = SubcategoryDataRequest(
            Code: subcategoryCode, Name: subcategoryName),
        this.Contact = ContactDataRequest(
            Name: name, Phonenumber: phone, Address: address, Email: email),
        this.InformationChannel = InformationChannelRequest(
            deviceid: token, typedeviceid: Platform.isIOS ? 'i' : Platform.isAndroid ? 'a' : 'unknown');

  factory SendIssueRequest.fromJson(Map<String, dynamic> json) =>
      _$SendIssueRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendIssueRequestToJson(this);
}

@JsonSerializable()
class CategoryDataRequest {
  final String Code;
  final String Name;

  CategoryDataRequest({this.Code, this.Name});

  factory CategoryDataRequest.fromJson(Map<String, dynamic> json) =>
      _$CategoryDataRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDataRequestToJson(this);
}

@JsonSerializable()
class InformationChannelRequest {
  final String deviceid;
  final String typedeviceid;

  InformationChannelRequest({this.deviceid, this.typedeviceid});

  factory InformationChannelRequest.fromJson(Map<String, dynamic> json) =>
      _$InformationChannelRequestFromJson(json);

  Map<String, dynamic> toJson() => _$InformationChannelRequestToJson(this);
}

@JsonSerializable()
class SubcategoryDataRequest {
  final String Code;
  final String Name;

  SubcategoryDataRequest({this.Code, this.Name});

  factory SubcategoryDataRequest.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryDataRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryDataRequestToJson(this);
}

@JsonSerializable()
class ContactDataRequest {
  String Name;
  String Phonenumber;
  String Address;
  String Email;

  ContactDataRequest({this.Name, this.Phonenumber, this.Address, this.Email});

  factory ContactDataRequest.fromJson(Map<String, dynamic> json) =>
      _$ContactDataRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ContactDataRequestToJson(this);
}
