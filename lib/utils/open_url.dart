import 'package:url_launcher/url_launcher.dart';

class Web {
  static Future<void> openUrl({String url}) async {
    if(url != null) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
      }
    }
  }

}