import 'package:flutter/material.dart';

class ColorsResource {
  static const primaryColor = Colors.blue;
  static const accentColor = Colors.blueAccent;
  static const backgroundColorIntro = Color(0xFF2675D1);
  static const backgroundColorTabbar = Color(0xFF2675D1);

  static const textColorButton = Colors.white;
  static const textColorTutorial = Colors.white;
  static const textColorUpdateInfo = Colors.white;
  static const textColorTitle = Colors.white;
  static const textButtonSkip = Colors.red;
  static const textButtonUpdate = Color(0xFF4B6EB9);

  static const buttonColorTutorial = Color(0xFF1199CB);

  static const iconColorTabbar = Colors.white;

  static const backgroundColorOverlaySelected = Color(0x0088000000);
  static const backgroundColorOverlayUnSelect = Colors.transparent;
  static const backgroundContainer = Color(0xFFFAFAFA);
  static const textHandleComplain = Color.fromRGBO(121, 121, 121, 1.0);
  static const titleIssueHistoryDetailContent = Colors.black87;
  static const contentIssueHistoryDetail = Colors.black;
  static const lineAdministration = Colors.black;
  static final areaDetails = HexColor.fromHex('#7e3d92');
  static final contentIssue = HexColor.fromHex('#c14f4f');
  static final timeIssue = HexColor.fromHex('#797979');
  static final timeLineContact = HexColor.fromHex('#fb845f');
  static final timeLineDepartment = HexColor.fromHex('#c4b958');
  static final timeLineContent = HexColor.fromHex('#65999c');
  static const inputColor = Colors.grey;
  static const textNotification = Color.fromRGBO(117, 110, 110, 1.0);
  static const lineGray = Color(0xFFD6D6D6);
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}