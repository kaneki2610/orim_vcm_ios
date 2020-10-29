import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';

@JsonSerializable(nullable: true)
class Contact {
  String name;
  String phoneNumber;
  String address;
  String email;
  int accountId;

  Contact(
      {this.name, this.phoneNumber, this.address, this.email, this.accountId});

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);
}
