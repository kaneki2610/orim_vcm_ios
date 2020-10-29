import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/info_issue_component.dart';
import 'package:orim/components/raised_buttom_custom.dart';
import 'package:orim/components/search_bar/search_bar_view.dart';
import 'package:orim/components/title_container.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/model/officer.dart';
import 'package:orim/pages/issue_need_assign_support_detail/issue_need_assign_support_detail_bloc.dart';
import 'package:orim/pages/issue_need_assign_support_detail/issue_need_assign_support_detail_view.dart';

class IssueNeedAssignSupportDetailPage extends StatefulWidget {
  const IssueNeedAssignSupportDetailPage(
      {IssueNeedAssignSupportDetailPageArguments arguments})
      : _arguments = arguments;

  static const String routeName = 'IssueNeedAssignSupportDetailPage';

  final IssueNeedAssignSupportDetailPageArguments _arguments;

  @override
  State<StatefulWidget> createState() {
    return IssueNeedAssignSupportState();
  }
}

class IssueNeedAssignSupportState extends BaseState<
        IssueNeedAssignSupportDetailBloc, IssueNeedAssignSupportDetailPage>
    implements IssueNeedAssignSupportDetailView {
  @override
  void initBloc() {
    bloc = IssueNeedAssignSupportDetailBloc(
        context: context, view: this, arguments: widget._arguments);
  }

  @override
  void onPostFrame() {
    super.onPostFrame();
    bloc.loadData();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
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
              _renderButtonSubmit(),
            ],
          ),
        ),
      )),
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
        Text('${model.resolvedComment}', style: TextStyle(
            fontWeight: FontWeight.normal
        ),)
      ],
    );
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
        SizedBox(
          height: DimenResource.padding5,
        ),
        TitleContainer(
          titleText:
              StringResource.getText(context, 'issue_assignment').toUpperCase(),
          titleColor: Theme.of(context).primaryColor,
          fontSize: DimenResource.textTitleSize,
        ),
        SizedBox(
          height: DimenResource.padding5,
        ),
        _renderSelectSpecialist(),
        _renderContentAssign()
      ],
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

  Widget _renderButtonSubmit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(),
        Flexible(
          child: RaisedButtonCustom(
            onPressed: bloc.sendAssign,
            text: StringResource.getText(context, 'issue_assignment'),
          ),
        )
      ],
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

  @override
  Future<void> showMessageTimeout() {
    return showMessage(msg: StringResource.getText(context, 'time_out'));
  }

  @override
  Future<void> showMessage({String msg}) async {
    await Fluttertoast.showToast(msg: msg);
  }

  @override
  Future<void> showMessageOfficerMissing() async {
    return showMessage(
            msg: StringResource.getText(
                context, 'issue_need_assign_un_select_specialist'))
        .then((_) => _openSpecialist());
  }

  @override
  Future<void> showMessageExpired() {
    return showMessage(msg: StringResource.getText(context, 'expired'));
  }

  @override
  Future<void> showMessagePermissionDeny() {
    return showMessage(msg: StringResource.getText(context, 'no_permission'));
  }

  @override
  void assignSupportFailed() {
    showMessage(
        msg: StringResource.getText(
            context, 'issue_need_assign_assign_support_failed'));
  }

  @override
  void assignSupportSucceed() {
    showMessage(
        msg: StringResource.getText(
            context, 'issue_need_assign_assign_support_success'));
  }

  @override
  Future<void> hideLoading() async {
    return progressDialogLoading.hide();
  }

  @override
  Future<void> showLoading() async {
    return progressDialogLoading.show();
  }
}

class IssueNeedAssignSupportDetailPageArguments {
  IssueModel model;

  IssueNeedAssignSupportDetailPageArguments({this.model});
}
