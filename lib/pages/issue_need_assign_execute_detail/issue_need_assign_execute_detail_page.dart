import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/info_issue_component.dart';
import 'package:orim/components/leading_widget_text_item.dart';
import 'package:orim/components/raised_buttom_custom.dart';
import 'package:orim/components/search_bar/search_bar_view.dart';
import 'package:orim/components/title_container.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/enum_packages/enum_group_responsible.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/department/department.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/model/officer.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/utils/alert_dialog.dart';
import 'package:orim/utils/widget/widget.dart';

import 'issue_need_assign_execute_detail_bloc.dart';
import 'issue_need_assign_execute_detail_view.dart';

class IssueNeedAssignExecuteDetailPage extends StatefulWidget {
  const IssueNeedAssignExecuteDetailPage(
      {@required IssueNeedAssignExecuteDetailPageArguments arguments})
      : _arguments = arguments;

  static const String routeName = 'IssueAssignDetailPage';
  final IssueNeedAssignExecuteDetailPageArguments _arguments;

  @override
  State<StatefulWidget> createState() {
    return _IssueAssignDetailState();
  }
}

class _IssueAssignDetailState extends BaseState<IssueNeedAssignDetailBloc,
    IssueNeedAssignExecuteDetailPage> implements IssueNeedAssignDetailView {
  @override
  void initBloc() {
    bloc = IssueNeedAssignDetailBloc(
        context: context, model: widget._arguments.model, view: this);
  }

  @override
  void onPostFrame() {
    super.onPostFrame();
    bloc.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringResource.getText(context, 'issue_detail')),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: bloc.loadData,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(DimenResource.paddingContent),
            child: Column(
              children: <Widget>[
                _infoIssue(),
                this.bloc.model.resolvedComment != "" ?
                _resolveComment() : SizedBox(),
                _buttonWatchLocation(),
                _buttonWatchProcess(),
                _imagesAttachment(),
                _videosAttachment(),
                _assignment(),
                _requestSupport(),
                SizedBox(height: 10,),
                _renderButtonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoIssue() {
    IssueModel model = bloc.model;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleContainer(
          titleText: StringResource.getText(context, 'title_detail_issue')
              .toUpperCase(),
          titleColor: Theme.of(context).primaryColor,
          fontSize: DimenResource.textTitleSize,
        ),
        InfoIssueComponent(
          model: model,
        ),
      ],
    );
  }

  Widget _resolveComment() {
    IssueModel model = bloc.model;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleContainer(
          titleText: StringResource.getText(context, 'issue_area_item_comment_resolved')
              .toUpperCase(),
          titleColor: Theme.of(context).primaryColor,
          fontSize: DimenResource.textTitleSize,
        ),
        SizedBox(height: DimenResource.padding5,),
        Text('${model.resolvedComment}', style: TextStyle(
          fontWeight: FontWeight.normal
        ),)
      ],
    );
  }
  Widget _imagesAttachment() {
    return ImageAttachmentComponent(
      model: bloc.model,
    );
  }

  Widget _videosAttachment() {
    return VideoAttachmentComponent(
      model: bloc.model,
    );
  }

  Widget _assignment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: DimenResource.paddingContent,
        ),
        TitleContainer(
          titleText:
              StringResource.getText(context, 'issue_need_assign_assign_title')
                  .toUpperCase(),
          titleColor: Theme.of(context).primaryColor,
          fontSize: DimenResource.textTitleSize,
          padding: 0,
        ),
        _renderRadioResponsible(),
      ],
    );
  }

  Widget _renderRadioResponsible() {
    return StreamBuilder(
      stream: bloc.responsibleObserver,
      builder: (context, AsyncSnapshot<Responsible> snapshot) {
        bool isSpecialist = snapshot.data == Responsible.SPECIALIST;
        return Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Radio(
                        value: Responsible.SPECIALIST,
                        groupValue: snapshot.hasData
                            ? snapshot.data
                            : Responsible.SPECIALIST,
                        onChanged: bloc.changeResponsible,
                      ),
                      Text(ResponsibleUtils.convertResponsibleToString(context,
                          responsible: Responsible.SPECIALIST))
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Radio(
                        value: Responsible.DEPARTMENT,
                        groupValue: snapshot.hasData
                            ? snapshot.data
                            : Responsible.SPECIALIST,
                        onChanged: bloc.changeResponsible,
                      ),
                      Text(ResponsibleUtils.convertResponsibleToString(context,
                          responsible: Responsible.DEPARTMENT))
                    ],
                  ),
                ],
              ),
              isSpecialist
                  ? _renderSelectSpecialist()
                  : _renderSelectDepartment(),
              _renderContentAssign(),
            ],
          ),
        );
      },
    );
  }

  Widget _renderSelectSpecialist() {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: InkWell(
        onTap: _openSpecialist,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(
                    left: DimenResource.paddingSubContent,
                    top: DimenResource.paddingSubContent,
                    bottom: DimenResource.paddingSubContent),
                child: StreamBuilder(
                  stream: bloc.officersObserver,
                  builder: (context, AsyncSnapshot<OfficerModel> snapshot) {
                    return Text(
                      snapshot.hasData
                          ? snapshot.data.fullname
                          : StringResource.getText(
                              context, 'issue_need_assign_select_specialist'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_drop_down),
              onPressed: null,
            )
          ],
        ),
      ),
    );
  }

  Widget _renderContentAssign() {
    return StreamBuilder(
      stream: bloc.contentAssign,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return Container(
          padding: EdgeInsets.only(top: DimenResource.paddingSubContent),
          child: TextField(
            controller: bloc.contentAssignController,
            focusNode: bloc.contentAssignFocusNode,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: StringResource.getText(
                  context, 'issue_need_assign_select_content_assign'),
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
              errorText: snapshot.hasError ? snapshot.error : null,
            ),
          ),
        );
      },
    );
  }

  Widget _requestSupport() {
    return StreamBuilder(
      stream: bloc.responsibleObserver,
      builder: (context, AsyncSnapshot<Responsible> snapshot) {
        if (snapshot.hasData && snapshot.data == Responsible.SPECIALIST) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: DimenResource.paddingContent,
              ),
              TitleContainer(
                titleText: StringResource.getText(
                        context, 'issue_need_assign_request_support_title')
                    .toUpperCase(),
                titleColor: Theme.of(context).primaryColor,
                fontSize: DimenResource.textTitleSize,
              ),
              SizedBox(height: 8,),
              _renderSelectSupportUnit(),
              _renderContentSupport(),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _renderSelectSupportUnit() {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: InkWell(
        onTap: _openSupportList,
        child: StreamBuilder(
          stream: bloc.departmentSupportObserver,
          builder: (context, AsyncSnapshot<DepartmentModel> snapshot) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: DimenResource.paddingSubContent,
                        top: DimenResource.paddingSubContent,
                        bottom: DimenResource.paddingSubContent),
                    child: Text(
                      snapshot.hasData
                          ? snapshot.data.name
                          : StringResource.getText(context,
                              'issue_need_assign_select_department_support'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                      snapshot.hasData ? Icons.delete : Icons.arrow_drop_down),
                  onPressed:
                      snapshot.hasData ? bloc.removeDepartmentSupport : null,
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _renderContentSupport() {
    return StreamBuilder(
      stream: bloc.departmentSupportObserver,
      builder: (context, AsyncSnapshot<DepartmentModel> snapshot) {
        if (snapshot.hasData) {
          return Container(
            padding: EdgeInsets.only(top: DimenResource.paddingSubContent),
            child: TextField(
              controller: bloc.contentSupportController,
              focusNode: bloc.contentSupportFocusNode,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: StringResource.getText(
                    context, 'issue_need_assign_select_content_support'),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _renderButtonSubmit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                    height: DimenResource.heightButton40,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.red,
                          width: 1.0,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(4.0)),
                    onPressed: _confirmReport,
                    child: Text(
                      StringResource.getText(
                          context, 'issue_need_assign_report'),
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(
                width: 5.0,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: MaterialButton(
                  height: DimenResource.heightButton40,
                  color: ColorsResource.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  onPressed: bloc.sendAssign,
                  child: Text(
                    StringResource.getText(context, 'issue_need_assign_assign'),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _renderSelectDepartment() {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: InkWell(
        onTap: _openUnitList,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(
                    left: DimenResource.paddingSubContent,
                    top: DimenResource.paddingSubContent,
                    bottom: DimenResource.paddingSubContent),
                child: StreamBuilder(
                  stream: bloc.departmentUnitObserver,
                  builder: (context, AsyncSnapshot<DepartmentModel> snapshot) {
                    return Text(
                      snapshot.hasData
                          ? snapshot.data.name
                          : StringResource.getText(context,
                              'issue_need_assign_select_department_unit'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                ),
              ),
            ),
            Icon(Icons.arrow_drop_down)
          ],
        ),
      ),
    );
  }

  void _openSpecialist() async {
    FocusScope.of(context)?.unfocus();
    if (bloc.officers != null && bloc.officers.length > 0) {
      int idx;
      try {
        idx = await selectItem(context,
            data: bloc.officers.map((item) => item.fullname).toList(),
            title: StringResource.getText(
                context, 'issue_need_assign_select_specialist'));
      } catch (err) {
        print(err);
      }
      if (idx != null) {
        bloc.changeSpecialist(index: idx);
      }
    } else {
      showMessage(
          msg: StringResource.getText(
              context, 'issue_need_assign_no_select_specialist'));
      bloc.loadOfficers();
    }
  }

  void _openSupportList() async {
    FocusScope.of(context)?.unfocus();
    if (bloc.departmentsSupport != null && bloc.departmentsSupport.length > 0) {
      int idx;
      try {
        idx = await selectItem(context,
            data: bloc.departmentsSupport.map((item) => item.name).toList(),
            title: StringResource.getText(
                context, 'issue_need_assign_select_department_support'));
      } catch (err) {
        print(err);
      }
      if (idx != null) {
        bloc.changeSupportUnit(index: idx);
      }
    } else {
      showMessage(
          msg: StringResource.getText(
              context, 'issue_need_assign_no_select_department_support'));
      bloc.loadDepartmentsSupport();
    }
  }

  _buttonWatchLocation() {
    return RaisedButtonCustom(
      text: StringResource.getText(context, 'view_on_map'),
      onPressed: bloc.viewLocation,
    );
  }

  _buttonWatchProcess() {
    return RaisedButtonCustom(
      text: StringResource.getText(context, 'issue_need_execute_watch_process'),
      onPressed: bloc.viewProcess,
    );
  }

  @override
  Future<void> showMessage({String msg}) async {
    await Fluttertoast.showToast(msg: msg);
  }

  void _confirmReport() {
    FocusScope.of(context)?.unfocus();
    Function back = () => NavigatorService.back(context);
    Function sure = () {
      if (NavigatorService.back(context)) {
        bloc.report();
      }
    };
    AlertDialogBuilder(
            context: context,
            title: StringResource.getText(
                context, 'issue_need_assign_report_title'),
            content: StringResource.getText(
                context, 'issue_need_assign_report_content'))
        .show(cancelable: true, actions: [
      AlertDialogBuilder.button(
          text: StringResource.getText(context, 'i_wrong'), onPress: back),
      AlertDialogBuilder.button(
          text: StringResource.getText(context, 'i_sure'), onPress: sure)
    ]);
  }

  void _openUnitList() async {
    FocusScope.of(context)?.unfocus();
    if (bloc.departmentsUnit != null && bloc.departmentsUnit.length > 0) {
      int idx;
      try {
        idx = await selectItem(context,
            data: bloc.departmentsUnit.map((item) => item.name).toList(),
            title: StringResource.getText(
                context, 'issue_need_assign_select_department_unit'));
      } catch (err) {
        print(err);
      }
      if (idx != null) {
        bloc.changeDepartmentUnit(index: idx);
      }
    } else {
      showMessage(
          msg: StringResource.getText(
              context, 'issue_need_assign_no_select_department_unit'));
      bloc.loadDepartmentUnit();
    }
  }

  @override
  Future<void> showErrorNoSelectDepartment() async {
    _openUnitList();
    showMessage(
        msg: StringResource.getText(
            context, 'issue_need_assign_un_select_department_support'));
  }

  @override
  Future<void> showErrorNoSelectSpecialist() async {
    _openSpecialist();
    showMessage(
        msg: StringResource.getText(
            context, 'issue_need_assign_un_select_specialist'));
  }

  @override
  Future<void> sendAssignExecuteSuccess() {
    return showMessage(
        msg: StringResource.getText(
            context, 'issue_need_assign_assign_execute_success'));
  }

  @override
  Future<void> showMessageTimeout() {
    return showMessage(msg: StringResource.getText(context, 'time_out'));
  }

  @override
  Future<void> dontHavePermission() {
    return showMessage(msg: StringResource.getText(context, 'no_permission'));
  }

  @override
  Future<void> sendAssignExecuteFailed() {
    return showMessage(
        msg: StringResource.getText(
            context, 'issue_need_assign_assign_execute_failed'));
  }

  @override
  Future<void> hideLoading() async {
   await progressDialogLoading.hide();
  }

  @override
  Future<void> showLoading() async {
    await progressDialogLoading.show();
  }

  @override
  void sendReportFailed() {
    showMessage(
        msg:
            StringResource.getText(context, 'issue_need_assign_report_failed'));
  }

  @override
  void sendReportSucceed() {
    showMessage(
        msg: StringResource.getText(
            context, 'issue_need_assign_report_succeed'));
  }

  @override
  void back() {
    NavigatorService.back(context);
  }

  @override
  void showMessageExpired() {
    showMessage(msg: StringResource.getText(context, 'expired'));
  }

  @override
  Future<void> showPopUpSupportError() async {
    await this.showPopupWithAction(StringResource.getText(context, 'department_not_found'), actions: null);
  }

  @override
  Future<void> showPopUpUnitError() async {
    await this.showPopupWithAction(StringResource.getText(context, 'department_not_found'), actions: null);
  }
}

class IssueNeedAssignExecuteDetailPageArguments {
  IssueModel model;

  IssueNeedAssignExecuteDetailPageArguments({this.model});
}
