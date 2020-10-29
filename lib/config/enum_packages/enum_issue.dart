import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/strings_resource.dart';

class IssueStatusEnum {
  static const int NewIssue = 10;                   // tin báo mới
  static const int HandlingStart = 11;              //Điều phối đến đơn vị tiếp nhận
  static const int ExecuteAssign = 12;              //Phân công xử lý
  static const int SupportRequirements = 20;        // Chuyên viên yêu cầu hỗ trợ
  static const int SupportDeptAssign = 21;          //Phân công đơn vị hỗ trợ
  static const int SupportExecuteAssign = 22;       //Đơn vị hỗ trợ phân công xử lý
  static const int ExecuteCompleted = 13;           //Đã xử lý hoàn tất- cấp dưới báo
  static const int ApprovedComplete = 14;           // Kết thúc luồng xử lý. Lãnh đạo phê duyệt cấp cuối cùng
  static const int RecycleIssueNotify = 33;         // Báo tin rác- cấp dưới báo
  static const int RecycleIssue = 34;               // Báo tin rác- phê duyệt cấp cuối cùng
  static const int OutOfBoundNotify = 43;           // Ngoài khu vực quản lý- cấp dưới báo
  static const int OutOfBound = 44;                 // Ngoài khu vực quản lý - phê duyệt cấp cuối cùng
  static const int ExecuteCompletedSuport = 23;     // Đã hỗ trợ hoàn tất- cấp dưới báo
  static const int CloseIssue = 55;                 // Tổng đài đóng tin báo - do trùng vs tin báo đã xử lý

  static String converToString(BuildContext context, int value) {
    switch (value) {
      case NewIssue: return StringResource.getText(context, 'NewIssueState');
      case HandlingStart: return StringResource.getText(context, 'HandlingStartState');
      case ExecuteAssign: return StringResource.getText(context, 'ExecuteAssignState');
      case SupportRequirements: return StringResource.getText(context, 'SupportRequirementsState');
      case SupportDeptAssign: return StringResource.getText(context, 'SupportDeptAssignState');
      case SupportExecuteAssign: return StringResource.getText(context, 'SupportExecuteAssignState');
      case ExecuteCompleted: return StringResource.getText(context, 'ExecuteCompletedState');
      case ApprovedComplete: return StringResource.getText(context, 'ApprovedCompleteState');
      case RecycleIssueNotify: return StringResource.getText(context, 'RecycleIssueNotifyState');
      case RecycleIssue: return StringResource.getText(context, 'RecycleIssueState');
      case OutOfBoundNotify: return StringResource.getText(context, 'OutOfBoundNotifyState');
      case OutOfBound: return StringResource.getText(context, 'OutOfBoundState');
      case ExecuteCompletedSuport: return StringResource.getText(context, 'ExecuteCompletedSuportState');
      case CloseIssue: return StringResource.getText(context, 'ExecuteCompletedSuportState');
      default: return 'unknown';
    }
  }

  static Color getColorByStatus(int value) {
    Color color;
    switch (value) {
      case IssueStatusEnum.RecycleIssue:
      case IssueStatusEnum.RecycleIssueNotify:
        color = Colors.redAccent;
        break;
      case IssueStatusEnum.ExecuteCompletedSuport:
      case IssueStatusEnum.ApprovedComplete:
        color = Colors.green;
        break;
      default:
        color = ColorsResource.primaryColor;
    }
    return color;
  }
}
