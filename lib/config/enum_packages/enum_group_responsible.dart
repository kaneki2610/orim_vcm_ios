import 'package:flutter/cupertino.dart';
import 'package:orim/config/strings_resource.dart';

enum Responsible {
  SPECIALIST,
  DEPARTMENT,
}

class ResponsibleUtils {
  static String convertResponsibleToString(BuildContext context, { Responsible responsible }){
    switch (responsible) {
      case Responsible.DEPARTMENT: return StringResource.getText(context, 'issue_need_assign_department');
      case Responsible.SPECIALIST: return StringResource.getText(context, 'issue_need_assign_specialist');
      default:
        return "unknown";
    }
  }
}