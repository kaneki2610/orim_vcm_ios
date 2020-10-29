import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:orim/entities/object/area/area.dart';
import 'package:orim/entities/object/assign/assign.dart';
import 'package:orim/entities/object/attachment/attachment.dart';
import 'package:orim/entities/object/category/category.dart';
import 'package:orim/entities/object/contact/contact.dart';
import 'package:orim/entities/object/department/department.dart';
import 'package:orim/entities/object/sub_category/sub_category.dart';
import 'package:orim/entities/object/informationChannel/information_channel.dart';

part 'issue.g.dart';

@JsonSerializable(nullable: true)
class Issue {
  String content;
  String level;
  String location;
  int status;
  String statusName;
  String areadetail;
  Area area;
  Category category;
  SubCategory subcategory;
  Contact contact;
  List<Attachment> attachment;
  List<Attachment> resolveAttachment;
  List<Attachment> videoAttachment;
  List<Attachment> videoResolveAttachment;
  String resolvedDate;
  String resolvedComment;
  String processComment; // may be create enum
  String updatedBy;
  String receptionChannel;
  dynamic informationChannel; // may be create enum
  double rating;
  String imageurl;
  String ratingComment;
  Department currentExecDepartment; // may be create class
  List<Assign> currentAssignees; // may be create class
  List<Supporter> currentSupports; // may be create class
  List<Assign> olderAssignees; // may be create class
  List<Supporter> olderSupports; // may be create class
  int reHandler;
  int reOpen;
  int orderByTime;
  int statusSupport;
  String partition;
  String id;
  String createdOn;
  String updatedOn;
  String createdBy;

  Issue(
      {this.content,
      this.level,
      this.location,
      this.status,
      this.statusName,
      this.areadetail,
      this.area,
      this.category,
      this.subcategory,
      this.contact,
      this.attachment,
      this.resolveAttachment,
      this.videoAttachment,
      this.videoResolveAttachment,
      this.resolvedDate,
      this.resolvedComment,
      this.processComment,
      this.updatedBy,
      this.receptionChannel,
      this.informationChannel,
      dynamic rating,
      this.ratingComment,
      this.currentExecDepartment,
      this.currentAssignees,
      this.currentSupports,
      this.olderAssignees,
      this.olderSupports,
      this.reHandler,
      this.reOpen,
      this.orderByTime,
      this.statusSupport,
      this.partition,
      this.id,
      this.createdOn,
      this.updatedOn,
        this.imageurl,
      this.createdBy})
      : this.rating = rating is String ? double.parse(rating) : rating;

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);

  Map<String, dynamic> toJson() => _$IssueToJson(this);

  Position get position {
    final List<String> stringPosition = location.split(',');
    if (stringPosition.length == 2) {
      final double latitude = double.parse(stringPosition[0]);
      final double longitude = double.parse(stringPosition[1]);
      Position postition = Position(latitude: latitude, longitude: longitude);
      return postition;
    } else {
      throw ('error $location');
    }
  }
}

@JsonSerializable(nullable: true)
class Supporter {
  String name;

  Supporter({this.name});

  factory Supporter.fromJson(Map<String, dynamic> json) =>
      _$SupporterFromJson(json);

  Map<String, dynamic> toJson() => _$SupporterToJson(this);
}
