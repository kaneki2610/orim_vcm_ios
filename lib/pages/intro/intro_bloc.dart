import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/services/notification.dart';
import 'package:orim/utils/permission.dart';
import 'package:orim/viewmodel/resident_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

const max_index_page = 4;
const duration = 400;

class IntroBloc extends BaseBloc {
  PageController pageController = PageController();
  NotificationService notificationService = NotificationService.getInstance();
  int indexPage = 0;
  bool stateCheck;
  final ReplaySubject<bool> _subjectIsChecked;

  Stream<bool> get isCheckedObservable => _subjectIsChecked.stream;

  IntroBloc({this.stateCheck = false, BuildContext context})
      : _subjectIsChecked = ReplaySubject<bool>(),
        super(context: context) {
    _subjectIsChecked.value = stateCheck;
  }
  ResidentInfoViewModel _infoViewModel;

  startFirst() {
    if (stateCheck == false) {
      // open app first time
      PermissionUtils.requestPermissions([
        Permission.location,
//        PermissionGroup.camera,
        Permission.storage,
//        PermissionGroup.microphone
      ]).then((Map<Permission, PermissionStatus> permissions) {
        for (int i = 0; i < permissions.length; i++) {
          //print('permission $i ${permissions[i].value}');
        }
        //notificationService.requestPermission();
      }).catchError((err) {
        print(err);
      });
    } else {
      // app is opened
    }
  }

  onChangeStateCheck(bool state) {
    stateCheck = state;
    _subjectIsChecked.value = stateCheck;
  }

  void dispose() {
    _subjectIsChecked.close();
  }

  next(bool skip) async {
    if (skip) {
      NavigatorService.back(context);
    } else {
      await _infoViewModel.loadDataResident();
      if(_infoViewModel.data == null) {
        NavigatorService.gotoUpdateInfo(context);
      } else{
        NavigatorService.popToRoot(context);
      }

    }
  }

  changIndexPage(int index){
    this.indexPage = index;
  }


  clickedNextPage(){
    if(this.indexPage < max_index_page){
      this.indexPage ++;
      this._setPageToAnimation();
    }
  }

  clickedBackPage() {
    if(this.indexPage > 0){
      this.indexPage --;
      this._setPageToAnimation();
    }
  }

  _setPageToAnimation(){
    pageController.animateToPage(
      this.indexPage,
      curve: Curves.easeIn,
      duration: Duration(milliseconds: duration),
    );
  }

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    _infoViewModel = Provider.of<ResidentInfoViewModel>(context);
  }
}
