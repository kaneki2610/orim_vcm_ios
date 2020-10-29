import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/viewmodel/issue_need_assign.dart';
import 'package:provider/provider.dart';
import 'handle_complain_bloc.dart';
import 'handle_complain_list.dart';
import 'mobx/handle_complain_mobx.dart';

enum HandleComplainListType {
  assigned_handling,
  assigned_support,
  handling_handling,
  handling_support,
  approved,
}

class HandleComplainChildBloc extends BaseBloc {
  TextEditingController textfieldController = TextEditingController();
  HandleComplainType typeHandle;

  BehaviorSubject<bool> _showClearSubject = BehaviorSubject();

  Stream<bool> get streamShowClear => _showClearSubject.stream;

  BehaviorSubject<String> _dateSubject = BehaviorSubject();

  Stream<String> get streamDate => _dateSubject.stream;

  IssueNeedAssignViewModel _issueNeedAssignViewModel;

  BehaviorSubject<double> headerSubject = BehaviorSubject();

  Stream<double> get streamHeader => headerSubject.stream;

  ComplainMobx _complainMobx;
  ScrollController scrollViewControllerTab1; // To control scrolling
  ScrollController scrollViewControllerTab2;
  TabController tabController;

  DateTime _date;
  bool isShowClear = false;
  bool isShowSearch = false;
  bool isShowCalendar = false;

  double _heightHeader = 0;
  List<Widget> tabViews;

  List<Widget> tabs;
  List<Widget> view;

  HandleComplainChildBloc(BuildContext context, HandleComplainType type,
      ComplainMobx mobx, TabController tab)
      : this.typeHandle = type,
        this._complainMobx = mobx,
        this.tabController = tab,
        super(context: context) {
    this.scrollViewControllerTab1 = ScrollController();
    this.scrollViewControllerTab2 = ScrollController();
    this.tabs = [
      Tab(
        text: StringResource.getText(context, 'handle_complain_child_handling'),
      ),
      Tab(
        text: StringResource.getText(context, 'handle_complain_child_support'),
      ),
    ];

    this.tabViews = [
      HandleComplainList(
        type: this.typeHandle == HandleComplainType.assigned
          ? HandleComplainListType.assigned_handling
          : HandleComplainListType.handling_handling,
        mobx: _complainMobx,
        indexTabParent: this.getIndexTab(),
        scrollController: this.scrollViewControllerTab1,
      ),
      HandleComplainList(
        type: this.typeHandle == HandleComplainType.assigned
          ? HandleComplainListType.assigned_support
          : HandleComplainListType.handling_support,
        mobx: _complainMobx,
        indexTabParent: this.getIndexTab(),
        scrollController: this.scrollViewControllerTab2,
      )
    ];
    view = [
      HandleComplainList(
        type: HandleComplainListType.approved,
        mobx: _complainMobx,
        indexTabParent: this.getIndexTab(),
        scrollController: this.scrollViewControllerTab1,
      )
    ];
    this.scrollViewControllerTab1.addListener(() {
      if (this.scrollViewControllerTab1.position.userScrollDirection ==
          ScrollDirection.forward) {
        this.headerSubject.value = this.getHeightHeader();
      } else if (this.scrollViewControllerTab1.position.userScrollDirection ==
          ScrollDirection.reverse) {
        this.headerSubject.value = 0.0;
      }
    });
    this.scrollViewControllerTab2.addListener(() {
      if (this.scrollViewControllerTab2.position.userScrollDirection ==
          ScrollDirection.forward) {
        this.headerSubject.value = this.getHeightHeader();
      } else if (this.scrollViewControllerTab2.position.userScrollDirection ==
          ScrollDirection.reverse) {
        this.headerSubject.value = 0.0;
      }
    });
  }

  @override
  void updateDependencies(BuildContext context) {
    _issueNeedAssignViewModel = Provider.of<IssueNeedAssignViewModel>(context);
  }

  clearSearch(){
    this.isShowClear = false;
    this._showClearSubject.value = this.isShowClear;
    this.textfieldController.text = "";
    this._issueNeedAssignViewModel.setDataSearch(this.textfieldController.text);
  }

  textSearchChange() {
    this._issueNeedAssignViewModel.setDataSearch(this.textfieldController.text);
    bool show = !(this.textfieldController.text == "");
    if (this.isShowClear != show) {
      this.isShowClear = show;
      this._showClearSubject.value = this.isShowClear;
    }
  }

  textCalendarChange(String date) {
    this._issueNeedAssignViewModel.setCalendar(date);
  }

  getDateSelect() {
    return this._date == null ? new DateTime.now() : this._date;
  }

  setDateSelect(DateTime date) async {
    if (date != null) {
      if (DateTime.now().isBefore(date) &&
        !DateTime.now().isAtSameMomentAs(date)) {
        Fluttertoast.showToast(
          msg: StringResource.getText(
            context, 'history_date_less_than_current'));
      } else {
        _date = date;
        String startString = DateFormat('dd/MM/yyyy').format(this._date);
        String endString = DateFormat('dd/MM/yyyy').format(DateTime.now());
        this.textCalendarChange(startString);
        _dateSubject.value = startString + " - " + endString;
      }
    } else {
      _date = null;
      this.textCalendarChange("");
      _dateSubject.value = "";
    }
  }

  int getIndexTab() {
    int index = 0;
    switch (this.typeHandle) {
      case HandleComplainType.assigned:
        index = 0;
        break;
      case HandleComplainType.handling:
        index = 1;
        break;
      case HandleComplainType.approved:
        index = 2;
        break;
    }
    return index;
  }

  double getHeightHeader() {
    double height = 0.0;
    if (this.isShowSearch) {
      height += 45;
    }
    if (this.isShowCalendar) {
      height += 45;
    }
    if(this.isShowCalendar || this.isShowSearch){
      height += 8;
    }
    return height;
  }

  void setHeightHeader() {
    double height = this._heightHeader;
    this._heightHeader += height;
    if (this._heightHeader < 0.0) {
      this._heightHeader = 0.0;
    }
    height = 0.0;
    if (this.isShowSearch) {
      height += 60;
    }
    if (this.isShowCalendar) {
      height += 60;
    }
    this._heightHeader = height;
    this.headerSubject.value = this.getHeightHeader();
//    this.scrollViewController.animateTo(0.0, duration: Duration(milliseconds: 200), curve: null);
//    new Timer(const Duration(milliseconds: 3000), (){
//      this.textfieldController.text = this.scrollViewController.offset.toString();
//      this.scrollViewController.jumpTo(0.0);
//    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    this.textfieldController.dispose();
    this._dateSubject.close();
    this._showClearSubject.close();
  }
}
