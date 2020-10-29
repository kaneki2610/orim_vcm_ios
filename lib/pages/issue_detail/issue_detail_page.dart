import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/title_container.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/issue_detail/issue_detail_bloc.dart';
import 'package:orim/pages/issue_detail/issue_detail_view.dart';
import 'package:orim/pages/issue_detail/widget/issue_attachment.dart';
import 'package:orim/pages/issue_detail/widget/issue_banner.dart';
import 'package:orim/pages/issue_detail/widget/issue_category.dart';
import 'package:orim/pages/issue_detail/widget/issue_location.dart';
import 'package:orim/pages/issue_detail/widget/issue_rating.dart';
import 'package:orim/pages/issue_detail/widget/issue_resolved_comment.dart';
import 'package:orim/pages/issue_detail/widget/issue_sender.dart';
import 'package:orim/pages/issue_detail/widget/issue_status.dart';
import 'package:orim/pages/issue_detail/widget/issue_time_created.dart';

const paddingContent = DimenResource.paddingContent;

class IssueDetailPage extends StatefulWidget {
  static const routeName = 'detail_issue';
  static const title = 'title_detail_issue'; //

  final IssueDetailArguments arguments;

  IssueDetailPage({Key key, @required this.arguments}) : super(key: key);

  @override
  _IssueDetailState createState() {
    return _IssueDetailState();
  }
}

class _IssueDetailState extends BaseState<IssueDetailBloc, IssueDetailPage>
    implements IssueDetailView {
  double rating = 2.4;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.updateDependencies(context);
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = buildListWidget();
    return Scaffold(
      appBar: AppBar(
        title: TitleContainer(
          titleText: StringResource.getText(context, IssueDetailPage.title),
          titleColor: ColorsResource.textColorTitle,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(DimenResource.paddingContent),
          child: ListView.separated(
            padding: EdgeInsets.only(bottom: DimenResource.paddingContent),
            itemCount: list.length,
            separatorBuilder: (context, index) => Container(
              height: paddingContent,
            ),
            itemBuilder: (context, index) => list[index],
          ),
        ),
      ),
    );
  }

  List<Widget> buildListWidget() {
    List<Widget> list = [];
    list.add(IssueStatus(
        statusName: bloc.model.statusName, status: bloc.model.status));
    list.add(IssueBanner(background: bloc.model.background));
    list.add(IssueCategoryAndContent(
      subCategory: bloc.model.subCategory,
      category: bloc.model.category,
      content: bloc.model.content,
    ));
    if (bloc.model.status == 14 || bloc.model.status == 34) {
      list.add(IssueComment(resolvedComment: bloc.model.resolvedComment));

      list.add(IssueLocation(
        location: bloc.model.location,
        onPressButton: bloc.showModalMap,
      ));
    }

    list.add(IssueTimeCreated(
      dateText: bloc.model.dateText,
      timeText: bloc.model.timeText,
      dateResolved: bloc.model.dateResolved,
      timeResolved: bloc.model.timeResolved,
    ));
    if (this.widget.arguments.isFromHistoryPage) {
      list.add(IssueSender(
        sender: bloc.model.sender,
      ));
    }

    if (bloc.model.imageAttachments.length > 0 ||
        bloc.model.videoAttachments.length > 0) {
      list.add(IssueAttachment(
        images: bloc.model.imageAttachments,
        videos: bloc.model.videoAttachments,
        titleImageAttachment:
            StringResource.getText(context, 'issue_photo_attachment'),
        titleVideoAttachment:
            StringResource.getText(context, 'issue_video_attachment'),
      ));
    }
    if (bloc.model.imageResolveAttachment.length > 0 ||
        bloc.model.videoResolveAttachment.length > 0) {
      list.add(IssueAttachment(
        images: bloc.model.imageResolveAttachment,
        videos: bloc.model.videoResolveAttachment,
        titleImageAttachment:
            StringResource.getText(context, 'issue_photo_attachment_resolved'),
        titleVideoAttachment:
            StringResource.getText(context, 'issue_video_attachment_resolved'),
      ));
    }

    list.add(_widgetRating());
    return list;
  }

  Widget _widgetRating() {
    return IssueRating(
      ratingObserver: bloc.ratingObserver,
      ownerObserver: bloc.issueIsOwn(),
      ratingComment: bloc.model.ratingComment,
      onRatingChanged: bloc.changeRating,
      status: this.bloc.model.status,
      contentRatingController: bloc.contentController,
      contentRatingFocusNode: bloc.contentFocusNode,
      onPressSendFeedback: bloc.onPressSendFeedback,
    );
  }

  @override
  void sendFeedbackFailed(String msg) {
    String message =
        '${StringResource.getText(context, 'send_feedback_failed')} - $msg';
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
  }

  @override
  void sendFeedbackSuccess() {
    Fluttertoast.showToast(
        msg: StringResource.getText(context, 'send_feedback_success'),
        toastLength: Toast.LENGTH_LONG);
  }

  @override
  Future<bool> hideLoading() {
    return progressDialogLoading.hide();
  }

  @override
  Future<bool> showLoading() {
    return progressDialogLoading.show();
  }

  @override
  bool back() {
    return NavigatorService.back(context);
  }

  @override
  void initBloc() {
    bloc = IssueDetailBloc(
        context: context, arguments: widget.arguments, issueDetailView: this);
  }
}

class IssueDetailArguments {
  IssueModel model;
  bool isFromHistoryPage;

  IssueDetailArguments({this.model, this.isFromHistoryPage});
}
