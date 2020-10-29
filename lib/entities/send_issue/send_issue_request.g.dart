// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_issue_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendIssueRequest _$SendIssueRequestFromJson(Map<String, dynamic> json) {
  return SendIssueRequest(
    Content: json['Content'] as String,
    Areadetail: json['Areadetail'] as String,
    currentProvince: json['currentProvince'] == null
        ? null
        : CurrentProvince.fromJson(
            json['currentProvince'] as Map<String, dynamic>),
    currentDistrict: json['currentDistrict'] == null
        ? null
        : CurrentDistrict.fromJson(
            json['currentDistrict'] as Map<String, dynamic>),
    currentWard: json['currentWard'] == null
        ? null
        : CurrentWard.fromJson(json['currentWard'] as Map<String, dynamic>),
  )
    ..Level = json['Level'] as String
    ..Location = json['Location'] as String
    ..Category = json['Category'] == null
        ? null
        : CategoryDataRequest.fromJson(json['Category'] as Map<String, dynamic>)
    ..Subcategory = json['Subcategory'] == null
        ? null
        : SubcategoryDataRequest.fromJson(
            json['Subcategory'] as Map<String, dynamic>)
    ..Contact = json['Contact'] == null
        ? null
        : ContactDataRequest.fromJson(json['Contact'] as Map<String, dynamic>)
    ..ReceptionChannel = json['ReceptionChannel'] as String
    ..InformationChannel = json['InformationChannel'] == null
        ? null
        : InformationChannelRequest.fromJson(
            json['InformationChannel'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SendIssueRequestToJson(SendIssueRequest instance) =>
    <String, dynamic>{
      'Content': instance.Content,
      'Level': instance.Level,
      'Location': instance.Location,
      'Areadetail': instance.Areadetail,
      'Category': instance.Category,
      'Subcategory': instance.Subcategory,
      'Contact': instance.Contact,
      'ReceptionChannel': instance.ReceptionChannel,
      'currentProvince': instance.currentProvince,
      'currentDistrict': instance.currentDistrict,
      'currentWard': instance.currentWard,
      'InformationChannel': instance.InformationChannel,
    };

CategoryDataRequest _$CategoryDataRequestFromJson(Map<String, dynamic> json) {
  return CategoryDataRequest(
    Code: json['Code'] as String,
    Name: json['Name'] as String,
  );
}

Map<String, dynamic> _$CategoryDataRequestToJson(
        CategoryDataRequest instance) =>
    <String, dynamic>{
      'Code': instance.Code,
      'Name': instance.Name,
    };

InformationChannelRequest _$InformationChannelRequestFromJson(
    Map<String, dynamic> json) {
  return InformationChannelRequest(
    deviceid: json['deviceid'] as String,
    typedeviceid: json['typedeviceid'] as String,
  );
}

Map<String, dynamic> _$InformationChannelRequestToJson(
        InformationChannelRequest instance) =>
    <String, dynamic>{
      'deviceid': instance.deviceid,
      'typedeviceid': instance.typedeviceid,
    };

SubcategoryDataRequest _$SubcategoryDataRequestFromJson(
    Map<String, dynamic> json) {
  return SubcategoryDataRequest(
    Code: json['Code'] as String,
    Name: json['Name'] as String,
  );
}

Map<String, dynamic> _$SubcategoryDataRequestToJson(
        SubcategoryDataRequest instance) =>
    <String, dynamic>{
      'Code': instance.Code,
      'Name': instance.Name,
    };

ContactDataRequest _$ContactDataRequestFromJson(Map<String, dynamic> json) {
  return ContactDataRequest(
    Name: json['Name'] as String,
    Phonenumber: json['Phonenumber'] as String,
    Address: json['Address'] as String,
    Email: json['Email'] as String,
  );
}

Map<String, dynamic> _$ContactDataRequestToJson(ContactDataRequest instance) =>
    <String, dynamic>{
      'Name': instance.Name,
      'Phonenumber': instance.Phonenumber,
      'Address': instance.Address,
      'Email': instance.Email,
    };
