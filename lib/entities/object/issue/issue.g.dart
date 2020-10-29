// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Issue _$IssueFromJson(Map<String, dynamic> json) {
  return Issue(
    content: json['content'] as String,
    level: json['level'] as String,
    location: json['location'] as String,
    status: json['status'] as int,
    statusName: json['statusName'] as String,
    areadetail: json['areadetail'] as String,
    area: json['area'] == null
        ? null
        : Area.fromJson(json['area'] as Map<String, dynamic>),
    category: json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>),
    subcategory: json['subcategory'] == null
        ? null
        : SubCategory.fromJson(json['subcategory'] as Map<String, dynamic>),
    contact: json['contact'] == null
        ? null
        : Contact.fromJson(json['contact'] as Map<String, dynamic>),
    attachment: (json['attachment'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    resolveAttachment: (json['resolveAttachment'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    videoAttachment: (json['videoAttachment'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    videoResolveAttachment: (json['videoResolveAttachment'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    resolvedDate: json['resolvedDate'] as String,
    resolvedComment: json['resolvedComment'] as String,
    processComment: json['processComment'] as String,
    updatedBy: json['updatedBy'] as String,
    receptionChannel: json['receptionChannel'] as String,
    informationChannel: json['informationChannel'] == null
        ? null
        : json['informationChannel'] is String
            ? json['informationChannel'] as String
            : InformationChannel.fromJson(
                json['informationChannel'] as Map<String, dynamic>),
    rating: json['rating'],
    ratingComment: json['ratingComment'] as String,
    currentExecDepartment: json['currentExecDepartment'] == null
        ? null
        : Department.fromJson(
            json['currentExecDepartment'] as Map<String, dynamic>),
    currentAssignees: (json['currentAssignees'] as List)
        ?.map((e) =>
            e == null ? null : Assign.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    currentSupports: (json['currentSupports'] as List)
        ?.map((e) =>
            e == null ? null : Supporter.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    olderAssignees: (json['olderAssignees'] as List)
        ?.map((e) =>
            e == null ? null : Assign.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    olderSupports: (json['olderSupports'] as List)
        ?.map((e) =>
            e == null ? null : Supporter.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    reHandler: json['reHandler'] as int,
    reOpen: json['reOpen'] as int,
    orderByTime: json['orderByTime'] as int,
    statusSupport: json['statusSupport'] as int,
    partition: json['partition'] as String,
    id: json['id'] as String,
    createdOn: json['createdOn'] as String,
    updatedOn: json['updatedOn'] as String,
    imageurl: json['imageurl'] as String,
    createdBy: json['createdBy'] as String,
  );
}

Map<String, dynamic> _$IssueToJson(Issue instance) => <String, dynamic>{
      'content': instance.content,
      'level': instance.level,
      'location': instance.location,
      'status': instance.status,
      'statusName': instance.statusName,
      'areadetail': instance.areadetail,
      'area': instance.area,
      'category': instance.category,
      'subcategory': instance.subcategory,
      'contact': instance.contact,
      'attachment': instance.attachment,
      'resolveAttachment': instance.resolveAttachment,
      'videoAttachment': instance.videoAttachment,
      'videoResolveAttachment': instance.videoResolveAttachment,
      'resolvedDate': instance.resolvedDate,
      'resolvedComment': instance.resolvedComment,
      'processComment': instance.processComment,
      'updatedBy': instance.updatedBy,
      'receptionChannel': instance.receptionChannel,
      'informationChannel': instance.informationChannel,
      'rating': instance.rating,
      'imageurl': instance.imageurl,
      'ratingComment': instance.ratingComment,
      'currentExecDepartment': instance.currentExecDepartment,
      'currentAssignees': instance.currentAssignees,
      'currentSupports': instance.currentSupports,
      'olderAssignees': instance.olderAssignees,
      'olderSupports': instance.olderSupports,
      'reHandler': instance.reHandler,
      'reOpen': instance.reOpen,
      'orderByTime': instance.orderByTime,
      'statusSupport': instance.statusSupport,
      'partition': instance.partition,
      'id': instance.id,
      'createdOn': instance.createdOn,
      'updatedOn': instance.updatedOn,
      'createdBy': instance.createdBy,
    };

Supporter _$SupporterFromJson(Map<String, dynamic> json) {
  return Supporter(
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$SupporterToJson(Supporter instance) => <String, dynamic>{
      'name': instance.name,
    };
