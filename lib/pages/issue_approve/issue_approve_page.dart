import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/info_issue_component.dart';
import 'package:orim/components/raised_buttom_custom.dart';
import 'package:orim/components/title_container.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/issue_approve/issue_approve_bloc.dart';
import 'package:orim/pages/issue_approve/issue_approve_view.dart';

class IssueApprovePage extends StatefulWidget {
  const IssueApprovePage({IssueApprovePageArgument argument})
      : argument = argument;

  static const String routeName = 'IssueApprovePage';
  final IssueApprovePageArgument argument;

  @override
  State<StatefulWidget> createState() {
    return _IssueApproveState();
  }
}

class _IssueApproveState extends BaseState<IssueApproveBloc, IssueApprovePage>
    implements IssueApproveView {
  @override
  void initBloc() {
    bloc = IssueApproveBloc(
        context: context, view: this, argument: widget.argument);
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _infoIssue(),
              this.bloc.model.resolvedComment != "" ?
              _resolveComment() : SizedBox(),
              _imagesAttachment(),
              _videosAttachment(),
              _buttonWatchLocation(),
              _buttonWatchProcess(),
              _imagesAttachmentResolve(),
              _videosAttachmentResolve(),
              _infoApprove(),
              _renderButtonSubmit()
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

  _imagesAttachmentResolve() {
    return ImageAttachmentResolvedComponent(
      model: bloc.model,
    );
  }

  _videosAttachmentResolve() {
    return VideoAttachmentResolvedComponent(
      model: bloc.model,
    );
  }

  Widget _infoApprove() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: DimenResource.paddingContent,
        ),
        TitleContainer(
          titleText:
              StringResource.getText(context, 'issue_approve_content_approve')
                  .toUpperCase(),
          titleColor: Theme.of(context).primaryColor,
          fontSize: DimenResource.textTitleSize,
        ),
        SizedBox(height: 6,),
        _renderContentApprove(),
      ],
    );
  }

  Widget _renderContentApprove() {
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
                  context, 'issue_approve_input_content_approve'),
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

  _renderButtonSubmit() {
    return RaisedButtonCustom(
      onPressed: bloc.submit,
      text: StringResource.getText(context, 'issue_approve_send_approve'),
    );
  }

  @override
  void showMessage({String msg}) {
    toastMessage(msg: msg);
  }

  @override
  void showApproveFailed() {
    toastMessage(
        msg: StringResource.getText(
            context, 'issue_approve_update_approve_failed'));
  }

  @override
  void showApproveSuccess() {
    toastMessage(
        msg: StringResource.getText(
            context, 'issue_approve_update_approve_success'));
  }

  @override
  void showMessageExpired() {
//    toastMessageExpired();
  NavigatorService.back(context);
  }

  @override
  void showMessageNotPermission() {
    toastMessagePermissionDeny();
  }

  @override
  void showMessageTimeout() {
    toastMessageTimeout();
  }

  @override
  Future<void> hideLoading() async {
  await  progressDialogLoading.hide();
  }

  @override
  Future<void> showLoading() async {
    await progressDialogLoading.show();
  }
}

class IssueApprovePageArgument {
  IssueModel model;

  IssueApprovePageArgument({this.model});
}
