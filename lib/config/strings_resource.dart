import 'package:easy_localization/easy_localization.dart' as EasyLocalization;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/config/app_config.dart';

class StringResource {
  static const String baseURLForIcon = '${AppConfig.DOMAIN_API}storage/';

  static String getText(BuildContext context, String key) {
    return EasyLocalization.tr(key);
  }

  static String getTextResource( String key) {
    return EasyLocalization.tr(key);
  }

  static String getLinkResource(String url) {
    if (url.startsWith('https') || url.startsWith('http')) {
      return url;
    } else if (url.startsWith('/')) {
      return baseURLForIcon + url.substring(1);
    }
    return baseURLForIcon + url;
  }
}