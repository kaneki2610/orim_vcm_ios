import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/info_issue_component.dart';
import 'package:orim/components/raised_buttom_custom.dart';
import 'package:orim/components/title_container.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/pages/issue_need_support/issue_need_support_bloc.dart';
import 'package:orim/pages/issue_need_support/issue_need_support_view.dart';

class IssueNeedSupportPage extends StatefulWidget {
  static const String routeName = 'IssueNeedSupportPage';

  const IssueNeedSupportPage({IssueNeedSupportArgument arguments})
      : arguments = arguments;

  final IssueNeedSupportArgument arguments;

  @override
  State<StatefulWidget> createState() {
    return _IssueNeedSupportState();
  }
}

class _IssueNeedSupportState
    extends BaseState<IssueNeedSupportBloc, IssueNeedSupportPage>
    implements IssueNeedSupportView {
  @override
  void initBloc() {
    bloc = IssueNeedSupportBloc(context: context, arguments: widget.arguments, view: this);
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _infoIssue(),
              this.bloc.model.resolvedComment != "" ?
              _resolveComment() : SizedBox(),
              _buttonWatchLocation(),
              _buttonWatchProcess(),
              _imagesAttachment(),
              _videosAttachment(),
              _infoAssignSupport(),
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

  Widget _infoAssignSupport() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: DimenResource.paddingContent,
        ),
        TitleContainer(
          titleText:
              StringResource.getText(context, 'issue_process_info_support')
                  .toUpperCase(),
          titleColor: Theme.of(context).primaryColor,
          fontSize: DimenResource.textTitleSize,
        ),
        _renderContentSupport(),
      ],
    );
  }

  Widget _renderContentSupport() {
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
                  context, 'issue_process_content_support'),
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
    return RaisedButtonCustom(
      onPressed: bloc.submit,
      text:
          StringResource.getText(context, 'issue_process_send_content_support'),
    );
  }

  @override
  void showMessageTimeout() {
    toastMessageTimeout();
  }

  @override
  void showMessage({String msg}) {
    toastMessage(msg: msg);
  }

  @override
  void showMessageNotPermission() {
    toastMessagePermissionDeny();
  }

  @override
  void showMessageExpired() {
    toastMessageExpired();
  }

  @override
  void showMessageSendInfoSupportFailed() {
    toastMessage(
        msg: StringResource.getText(context, 'issue_process_send_info_failed'));
  }

  @override
  void showMessageSendInfoSupportSuccess() {
    toastMessage(
        msg:
            StringResource.getText(context, 'issue_process_send_info_success'));
  }

  @override
  Future<bool> hideLoading() {
    return progressDialogLoading.hide();
  }

  @override
  Future<bool> showLoading() {
    return progressDialogLoading.show();
  }
}

class IssueNeedSupportArgument {
  IssueModel model;

  IssueNeedSupportArgument({this.model});
}
