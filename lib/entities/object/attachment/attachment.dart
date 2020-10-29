import 'package:json_annotation/json_annotation.dart';

part 'attachment.g.dart';

@JsonSerializable(nullable: true)
class Attachment {
  String filePath;

  Attachment({this.filePath});

  factory Attachment.fromJson(Map<String, dynamic> json) => _$AttachmentFromJson(json);
  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
}