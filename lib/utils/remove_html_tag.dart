import 'package:html/parser.dart';

class GetStringFromHtml {

  GetStringFromHtml();

  static String resolveCommentValue(String resolveComment) {
    if(resolveComment == null || resolveComment == "") {
      return "";
    }
    var document = parse(resolveComment);
    var value = parse(document.body.text).documentElement.text;
    return value;
  }
}