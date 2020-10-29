import 'package:flutter/material.dart';
import 'package:orim/pages/attachments_picker/attachments_picker_page.dart';
import 'package:orim/pages/browser_page/browser.dart';
import 'package:orim/pages/dashboard_list/dashboad_list_page.dart';
import 'package:orim/pages/change_password/change_password_page.dart';
import 'package:orim/pages/employer_info/employer_info_page.dart';
import 'package:orim/pages/home/home_page.dart';
import 'package:orim/pages/home/tab/history/history_page.dart';
import 'package:orim/pages/intro/intro_page.dart';
import 'package:orim/pages/issue_administration_detail/issue_administration_detail_page.dart';
import 'package:orim/pages/issue_approve/issue_approve_page.dart';
import 'package:orim/pages/issue_detail/issue_detail_page.dart';
import 'package:orim/pages/issue_map/issue_map_page.dart';
import 'package:orim/pages/issue_need_assign_execute_detail/issue_need_assign_execute_detail_page.dart';
import 'package:orim/pages/issue_need_assign_support_detail/issue_need_assign_support_detail_page.dart';
import 'package:orim/pages/issue_need_execute/issue_need_execute_page.dart';
import 'package:orim/pages/issue_need_support/issue_need_support_page.dart';
import 'package:orim/pages/listimage/ListImage.dart';
import 'package:orim/pages/reflected/reflected_page.dart';
import 'package:orim/pages/send_complain/modal/modal_fields/modal_field.dart';
import 'package:orim/pages/send_complain/modal/modal_info/modal_info.dart';
import 'package:orim/pages/send_complain/modal/modal_map/modal_map.dart';
import 'package:orim/pages/send_complain/send_complain_page.dart';
import 'package:orim/pages/show_full_gallery/show_full_meida.dart';
import 'package:orim/pages/signin/sign_in_page.dart';
import 'package:orim/pages/splash/splash_page.dart';
import 'package:orim/pages/update_info/update_info_page.dart';

import 'pages/home/tab/info/info_page.dart';

class NavigatorService {
  static void popToRoot(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashPage.routeName:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case IntroPage.routeName:
        final IntroPageArguments arguments =
            settings.arguments as IntroPageArguments;
        return MaterialPageRoute(
            builder: (context) =>
                IntroPage(skip: arguments != null ? arguments.skip : false));
      case UpdateInfoPage.routeName:
        return MaterialPageRoute(builder: (context) => UpdateInfoPage());
      case MyHomePage.routeName:
        return MaterialPageRoute(builder: (context) => MyHomePage());
      case ReflectedPage.routeName:
        return MaterialPageRoute(builder: (context) => ReflectedPage());
      case IssueDetailPage.routeName:
        {
          final IssueDetailArguments arguments =
              settings.arguments as IssueDetailArguments;
          return MaterialPageRoute(
              builder: (context) => IssueDetailPage(arguments: arguments));
        }
      case ListImage.routeName:
        final ListImageArguments argument =
            settings.arguments as ListImageArguments;
        return MaterialPageRoute(
          builder: (context) => ListImage(
            listImageArgument: argument,
          ),
        );
      case SendComplainPage.routeName:
        SendComplainArguments arguments =
            settings.arguments as SendComplainArguments;
        if (arguments == null) {
          arguments = SendComplainArguments(
            gotoPhotoLibrary: false,
            gotoCategories: false,
          );
        }
        return MaterialPageRoute(
          builder: (context) => SendComplainPage(
            arguments: arguments,
          ),
        );
      case AttachmentsPickerPage.routeName:
        AttachmentPickerArguments arguments =
            settings.arguments as AttachmentPickerArguments;
        return MaterialPageRoute(
            builder: (context) => AttachmentsPickerPage(
                  arguments: arguments,
                ));
      case ModalMap.routeName:
        ModalMapArguments arguments = settings.arguments as ModalMapArguments;
        return MaterialPageRoute(
            builder: (context) => ModalMap(
                  position: arguments.position,
                  locationName: arguments.locationName,
                  currentProvince: arguments.currentProvince,
                  currentDistrict: arguments.currentDistrict,
                  currentWard: arguments.currentWard,
                  callback: arguments.callback,
                ));
      case ModalField.routeName:
        ModalFieldArguments arguments =
            settings.arguments as ModalFieldArguments;
        return MaterialPageRoute(
            builder: (context) => ModalField(
                  categoryData: arguments.categoryData,
                  callback: arguments.callback,
                ));
      case ModalInfoPage.routeName:
        ModalInfoArguments arguments = settings.arguments as ModalInfoArguments;
        return MaterialPageRoute(
            builder: (context) => ModalInfoPage(
                  arguments: arguments,
                ));
      case IssueMapPage.routeName:
        IssueMapPageArguments arguments =
            settings.arguments as IssueMapPageArguments;
        return MaterialPageRoute(
          builder: (context) => IssueMapPage(arguments: arguments),
        );
      case SignInPage.routeName:
        return MaterialPageRoute(
          builder: (context) => SignInPage(),
        );

      case ShowFullGallery.routeName:
        ShowFullMediaArguments arguments =
            settings.arguments as ShowFullMediaArguments;
        return MaterialPageRoute(
          builder: (context) => ShowFullGallery(
            arguments: arguments,
          ),
        );
      case IssueNeedAssignExecuteDetailPage.routeName:
        IssueNeedAssignExecuteDetailPageArguments arguments =
            settings.arguments as IssueNeedAssignExecuteDetailPageArguments;
        return MaterialPageRoute(
            builder: (context) => IssueNeedAssignExecuteDetailPage(
                  arguments: arguments,
                ));
      case IssueNeedAssignSupportDetailPage.routeName:
        IssueNeedAssignSupportDetailPageArguments arguments =
            settings.arguments as IssueNeedAssignSupportDetailPageArguments;
        return MaterialPageRoute(
            builder: (context) => IssueNeedAssignSupportDetailPage(
                  arguments: arguments,
                ));
      case IssueNeedExecutePage.routeName:
        IssueNeedExecuteArgument arguments =
            settings.arguments as IssueNeedExecuteArgument;
        return MaterialPageRoute(
            builder: (context) => IssueNeedExecutePage(
                  argument: arguments,
                ));
      case IssueNeedSupportPage.routeName:
        IssueNeedSupportArgument argument =
            settings.arguments as IssueNeedSupportArgument;
        return MaterialPageRoute(
            builder: (context) => IssueNeedSupportPage(
                  arguments: argument,
                ));
      case IssueApprovePage.routeName:
        IssueApprovePageArgument argument =
            settings.arguments as IssueApprovePageArgument;
        return MaterialPageRoute(
            builder: (context) => IssueApprovePage(
                  argument: argument,
                ));
      case HistoryPageLogin.routeName:
        HistoryPageLoginArgument argument =
            settings.arguments as HistoryPageLoginArgument;
        return MaterialPageRoute(
            builder: (context) => HistoryPageLogin(
                  argument: argument,
                ));

      case IssueAdministrationDetailPage.routeName:
        IssueAdministrationDetailArguments arguments =
            settings.arguments as IssueAdministrationDetailArguments;
        return MaterialPageRoute(
            builder: (context) =>
                IssueAdministrationDetailPage(arguments: arguments));
      case DashboardListPage.routeName:
        DashboardListArguments arguments =
            settings.arguments as DashboardListArguments;
        return MaterialPageRoute(
            builder: (context) => DashboardListPage(argument: arguments));
      case ChangePasswordPage.routeName:
        return MaterialPageRoute(
            builder: (context) => ChangePasswordPage(
            ));
      case EmployerInfoPage.routeName:
        return MaterialPageRoute(
            builder: (context) => EmployerInfoPage(
            ));
      case BrowserPage.routeName:
        BrowserArgument arguments =
        settings.arguments as BrowserArgument;
        return MaterialPageRoute(
          builder: (context) =>BrowserPage(arguments),
        );
      case InfoLoginPage.routeName:
        return MaterialPageRoute(
          builder: (context) =>InfoLoginPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static bool back<T extends Object>(BuildContext context, [T result]) {
     Navigator.of(context).pop(result);
     return true;
  }

  static Future gotoIntro(BuildContext context,
      {IntroPageArguments arguments}) {
    assert(context != null);
    return Navigator.of(context)
        .pushNamed(IntroPage.routeName);
  }

  static Future switchIntro(BuildContext context,
      {IntroPageArguments arguments}) {
    assert(arguments != null);
    return Navigator.of(context).pushNamedAndRemoveUntil(
        IntroPage.routeName, ModalRoute.withName(IntroPage.routeName),
        arguments: arguments);
  }

  static Future gotoUpdateInfo(BuildContext context) {
    return Navigator.of(context).pushNamedAndRemoveUntil(
        UpdateInfoPage.routeName,
        ModalRoute.withName(UpdateInfoPage.routeName));
  }

  static Future gotoHome(BuildContext context) {
    return Navigator.pushNamedAndRemoveUntil(context, MyHomePage.routeName,
        ModalRoute.withName(MyHomePage.routeName));
  }

  static Future switchHome(BuildContext context) {
    return Navigator.pushNamedAndRemoveUntil(context, MyHomePage.routeName,
        ModalRoute.withName(MyHomePage.routeName));
  }

  static Future gotoReflected(BuildContext context) {
    return Navigator.of(context).pushNamed(ReflectedPage.routeName);
  }

  static Future gotoDetailIssue(BuildContext context,
      {IssueDetailArguments arguments}) {
    assert(arguments != null);
    return Navigator.of(context)
        .pushNamed(IssueDetailPage.routeName, arguments: arguments);
  }

  static Future gotoListImage(BuildContext context,
      {ListImageArguments arguments}) {
    assert(arguments != null);
    return Navigator.of(context)
        .pushNamed(ListImage.routeName, arguments: arguments);
  }

  static Future gotoSendComplain(BuildContext context,
      {SendComplainArguments arguments}) {
    if (arguments == null) {
      arguments = SendComplainArguments(
        gotoPhotoLibrary: false,
        gotoCategories: false,
        openVideoView: false,
        openCameraView: false
      );
    }
    assert(arguments != null);
    return Navigator.of(context)
        .pushNamed(SendComplainPage.routeName, arguments: arguments);
  }

  static Future gotoAttachmentPicker(BuildContext context,
      {AttachmentPickerArguments arguments}) {
    assert(arguments != null);
    return Navigator.of(context)
        .pushNamed(AttachmentsPickerPage.routeName, arguments: arguments);
  }

  static Future showModalMap(BuildContext context,
      {ModalMapArguments arguments}) {
    assert(arguments != null);
    return Navigator.of(context)
        .pushNamed(ModalMap.routeName, arguments: arguments);
  }

  static Future showModalField(BuildContext context,
      {ModalFieldArguments arguments}) {
    assert(arguments != null);
    return Navigator.of(context)
        .pushNamed(ModalField.routeName, arguments: arguments);
  }

  static Future showModalInfo(BuildContext context,
      {ModalInfoArguments arguments}) {
    assert(arguments != null);
    return Navigator.of(context)
        .pushNamed(ModalInfoPage.routeName, arguments: arguments);
  }

  static Future showModalIssueMap(BuildContext context,
      {IssueMapPageArguments arguments}) {
    assert(arguments != null);
    return Navigator.of(context)
        .pushNamed(IssueMapPage.routeName, arguments: arguments);
  }

  static void gotoShowFullGallery(BuildContext context,
      {ShowFullMediaArguments arguments}) {
    assert(context != null && arguments != null);
    Navigator.of(context)
        .pushNamed(ShowFullGallery.routeName, arguments: arguments);
  }

  static Future gotoSignIn(BuildContext context) {
    assert(context != null);
    return Navigator.of(context).pushNamed(SignInPage.routeName);
  }

  static Future gotoIssueNeedAssignDetail(BuildContext context,
      {IssueNeedAssignExecuteDetailPageArguments arguments, Function callBackWhenBack}) {
    assert(context != null && arguments != null);
    return Navigator.of(context).pushNamed(
        IssueNeedAssignExecuteDetailPage.routeName,
        arguments: arguments).then((value){
          if(callBackWhenBack != null){
            callBackWhenBack();
          }
    });
  }

  static Future gotoHistory(BuildContext context) {
    assert(context != null);
    return Navigator.of(context).pushNamed(HistoryPage.routeName);
  }

  static Future gotoIssueNeedAssignSupportDetail(BuildContext context,
      {IssueNeedAssignSupportDetailPageArguments arguments, Function callBackWhenBack}) {
    assert(context != null && arguments != null);
    return Navigator.of(context).pushNamed(
        IssueNeedAssignSupportDetailPage.routeName,
        arguments: arguments).then((value){
      if(callBackWhenBack != null){
        callBackWhenBack();
      }
    });
  }

  static Future gotoIssueNeedExecute(BuildContext context,
      {IssueNeedExecuteArgument arguments, Function callBackWhenBack}) {
    assert(context != null && arguments != null);
    return Navigator.of(context)
        .pushNamed(IssueNeedExecutePage.routeName, arguments: arguments).then((value){
      if(callBackWhenBack != null){
        callBackWhenBack();
      }
    });
  }

  static Future gotoIssueNeedSupport(BuildContext context,
      {IssueNeedSupportArgument arguments, Function callBackWhenBack}) {
    assert(context != null && arguments != null);
    return Navigator.of(context)
        .pushNamed(IssueNeedSupportPage.routeName, arguments: arguments).then((value){
      if(callBackWhenBack != null){
        callBackWhenBack();
      }
    });
  }

  static Future gotoIssueApprove(BuildContext context,
      {IssueApprovePageArgument argument, Function callBackWhenBack}) {
    assert(context != null && argument != null);
    return Navigator.of(context)
        .pushNamed(IssueApprovePage.routeName, arguments: argument).then((value){
      if(callBackWhenBack != null){
        callBackWhenBack();
      }
    });
  }

  static Future gotoHistoryLogin(BuildContext context,
      {HistoryPageLoginArgument argument}) {
    assert(context != null && argument != null);
    return Navigator.of(context)
        .pushNamed(HistoryPageLogin.routeName, arguments: argument);
  }

  static Future gotoIssueAdminDetail(BuildContext context,
      {IssueAdministrationDetailArguments argument}) {
    assert(context != null && argument != null);
    return Navigator.of(context).pushNamed(
        IssueAdministrationDetailPage.routeName,
        arguments: argument);
  }

  static Future gotoDashboardList (BuildContext context,
      {DashboardListArguments argument}) {
    assert(context != null && argument != null);
    return Navigator.of(context).pushNamed(
        DashboardListPage.routeName,
        arguments: argument);
  }
  static Future gotoUpdatePassword(BuildContext context) {
    assert(context != null);
    return Navigator.of(context).pushNamed(ChangePasswordPage.routeName);
  }

  static Future gotoBrowser(BuildContext context, {String url}) {
    assert(context != null);
    if(url != null && url != ""){
      BrowserArgument argument = BrowserArgument(url);
      return Navigator.of(context).pushNamed(BrowserPage.routeName, arguments: argument);
    }
  }

  static Future gotoEmployerInfo(BuildContext context) {
    assert(context != null);
    return Navigator.of(context).pushNamed(EmployerInfoPage.routeName);
  }

  static Future gotoInfoLogin(BuildContext context) {
    assert(context != null);
    return Navigator.of(context).pushNamed(InfoLoginPage.routeName);
  }
}
