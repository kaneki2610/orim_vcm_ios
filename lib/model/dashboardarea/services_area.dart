
import 'dart:math';
import 'dart:ui';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:json_annotation/json_annotation.dart';
part 'services_area.g.dart';
@JsonSerializable(nullable: false)

final Random _random = Random();
class ServicesAreaModel {
  String code;
  String name;
  int percent;
  int number;
  int red = _random.nextInt(256);
  int blue= _random.nextInt(256);
  int green= _random.nextInt(256);

  ServicesAreaModel({ this.code,this.name, this.percent, this.number});
  factory ServicesAreaModel.fromJson(Map<String, dynamic> json) => _$ServicesAreaModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesAreaModelToJson(this);
}
