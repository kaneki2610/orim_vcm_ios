import 'dart:core';
import 'dart:ui';

import 'package:flutter/material.dart';

class ReflectedModel {
  String id;
  String image;
  String title;
  String location;
  String dateText;
  String timeText;

  String statusText;
  Color statusColor;

  String category;

  int status;

  ReflectedModel({ this.id,this.image, this.title, this.location, this.dateText, this.timeText, this.status, this.category }) {
    switch(status) {
      case 1:
        this.statusText = "Đang xử lý";
        this.statusColor = Color(0xFFFCD248);
        break;
      case 2:
        this.statusText = "Đã xử lý";
        this.statusColor = Colors.blue;
        break;
      case 3:
        this.statusText = "Hoàn thành";
        this.statusColor = Colors.green;
        break;
      default:
        this.statusText = "Mới";
        this.statusColor = Colors.green;
    }
  }
}