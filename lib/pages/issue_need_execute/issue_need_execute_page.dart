import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/attachment_component.dart';
import 'package:orim/components/info_issue_component.dart';
import 'package:orim/components/raised_buttom_custom.dart';
import 'package:orim/components/search_bar/search_bar_view.dart';
import 'package:orim/components/title_container.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/category_execute_model.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/issue_need_execute/issue_need_execute_bloc.dart';
import 'package:orim/pages/issue_need_execute/issue_need_execute_view.dart';
import 'package:orim/utils/alert_dialog.dart';
import 'package:orim/utils/dialog/dialog_util.dart';
import 'package:orim/utils/gallery_storage/attachement.dart';

class IssueNeedExecutePage extends StatefulWidget {
  const IssueNeedExecutePage({IssueNeedExecuteArgument argument})
      : argument = argument;

  final IssueNeedExecuteArgument argument;

  static const String routeName = 'IssueNeedExecutePage';

  @override
  State<StatefulWidget> createState() {
    return IssueNeedExecuteState();
  }
}

class IssueNeedExecuteState
    extends BaseState<IssueNeedExecuteBloc, IssueNeedExecutePage>
    implements IssueNeedExecuteView {
  @override
  void initBloc() {
    bloc = IssueNeedExecuteBloc(
        context: context, view: this, model: widget.argument.model);
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
              _infoExecute(),
              _attachments(),
              _submitButton(),
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

  Widget _buttonWatchLocation() {
    return RaisedButtonCustom(
      text: StringResource.getText(context, 'view_on_map'),
      onPressed: bloc.viewLocation,
    );
  }

  Widget _buttonWatchProcess() {
    return RaisedButtonCustom(
      text: StringResource.getText(context, 'issue_need_execute_watch_process'),
      onPressed: bloc.viewProcess,
    );
  }

  Widget _infoExecute() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: DimenResource.paddingContent,
        ),
        TitleContainer(
          titleText:
              StringResource.getText(context, 'issue_process_info_execute')
                  .toUpperCase(),
          titleColor: Theme.of(context).primaryColor,
          fontSize: DimenResource.textTitleSize,
        ),
        SizedBox(
          height: DimenResource.paddingContent,
        ),
        _renderSelectCategoriesExecute(),
        _renderContentExecute(),
      ],
    );
  }

  Widget _renderSelectCategoriesExecute() {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: InkWell(
        onTap: openCategoriesExecute,
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
                  stream: bloc.categorySelectObserver,
                  builder:
                      (context, AsyncSnapshot<CategoryExecuteModel> snapshot) {
                    return Text(
                      snapshot.hasData
                          ? snapshot.data.name
                          : StringResource.getText(
                              context, 'issue_process_categories_select'),
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

  Widget _renderContentExecute() {
    return StreamBuilder(
      stream: bloc.contentExecute,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return Container(
          padding: EdgeInsets.only(top: DimenResource.paddingSubContent),
          child: TextField(
            controller: bloc.contentExecuteController,
            focusNode: bloc.contentExecuteFocusNode,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: StringResource.getText(
                  context, 'issue_process_content_execute'),
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

  Widget _attachments() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: DimenResource.paddingContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TitleContainer(
              titleText: StringResource.getText(
                      context, 'issue_process_attachment_execute')
                  .toUpperCase(),
              titleColor: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            InkWell(
//              onTap: () => _sendComplainBloc.showModalAttachments(),
              onTap: _openModalAttachmentOptions,
              child: Row(
                children: <Widget>[
                  Text(
                    StringResource.getText(context, 'add_attachments'),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                      size: 15,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Container(
          height: 10,
        ),
        StreamBuilder(
          stream: bloc.attachmentsExecuteObserver,
          builder: (context, AsyncSnapshot<List<Attachment>> snapshot) {
            if (snapshot.hasData && snapshot.data.length > 0) {
              return Container(
                height: 80.0,
                width: double.infinity,
                child: ListView.separated(itemBuilder: (context, index){
                  Attachment attachment = snapshot.data[index];
                  return Container(
                    width: 80.0,
                    height: 80.0,
                    child: AttachmentComponent(
                      attachment: attachment,
                      onPress: () => bloc.showImageView(attachment),
                      icon: Wrap(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () => bloc.removeAttachment(attachment),
                              child: Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }, separatorBuilder: (context, index){
                  return Container(width: 5.0,);
                },
                  itemCount: snapshot.data.length,
                scrollDirection: Axis.horizontal,),
              );
            } else {
              return Container(
                child: Center(
                  child:
                      Text(StringResource.getText(context, 'no_attachments')),
                ),
              );
            }
          },
        ),
        Container(
          height: 20,
        ),
      ],
    );
  }

  void _openModalAttachmentOptions() {
    DialogUtil().showModalAttachmentOptions(
        context,
        openCameraCallback: this.bloc.openCameraView,
        openVideoViewCallBack: this.bloc.openVideoView,
        openGalleryCallback: this._openModalAttachments,
        openVideoCallback: () {
          this.bloc.openVideoMemory();
        }
    );
  }

  _openModalAttachments() {
    if (NavigatorService.back(context)) {
      bloc.showModalAttachments();
    }
  }

  @override
  Future<void> showMessage({String msg}) {
    return toastMessage(msg: msg);
  }

  Widget _submitButton() {
    return RaisedButtonCustom(
      onPressed: bloc.submit,
      text: StringResource.getText(context, 'issue_process_attachment_send'),
    );
  }

  @override
  Future<void> showMessageNoCategoryExecute() {
    return toastMessage(
        msg: StringResource.getText(
            context, 'issue_process_categories_un_select'));
  }

  @override
  void openCategoriesExecute() async {
    if (bloc.categoriesExe.length > 0) {
      int index = await selectItem(context,
          data: bloc.categoriesExe.map((e) => e.name).toList(),
          title: StringResource.getText(
              context, 'issue_process_categories_select'));
      if (index != null) {
        bloc.selectCategoryExecute(index: index);
      }
    } else {
      showMessage(
          msg: StringResource.getText(
              context, 'issue_process_categories_loading'));
      bloc.loadCategoriesExecute();
    }
  }

  @override
  void showMesageExpired() {
    toastMessageExpired();
  }

  @override
  void showNotPermission() {
    toastMessagePermissionDeny();
  }

  @override
  void showTimeout() {
    toastMessageTimeout();
  }

  @override
  void sendExecuteFailed() {
    toastMessage(
        msg: StringResource.getText(
            context, 'issue_process_attachment_send_failed'));
  }

  @override
  void sendExecuteSuccess() {
    toastMessage(
        msg: StringResource.getText(
            context, 'issue_process_attachment_send_success'));
  }

  @override
  Future<void> hideLoading() {
    progressDialogLoading.hide();
  }

  @override
  Future<void> showLoading() {
    progressDialogLoading.show();
  }

  @override
  void showMessageErrorWhenUploading() {
    toastMessage(
        msg: StringResource.getText(
            context, 'issue_process_attachment_send_attachment_failed'));
  }
}

class IssueNeedExecuteArgument {
  IssueNeedExecuteArgument({this.model});

  final IssueModel model;
}
