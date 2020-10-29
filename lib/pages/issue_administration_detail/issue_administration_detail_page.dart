import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/info_issue_component.dart';
import 'package:orim/components/leading_widget_text_item.dart';
import 'package:orim/components/loading.dart';
import 'package:orim/components/title_container.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/imgs_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/model/process.dart';

import 'issue_administration_detail_bloc.dart';

class IssueAdministrationDetailPage extends StatefulWidget {
  static const String routeName = 'IssueAdministrationDetail';

  final IssueAdministrationDetailArguments arguments;

  IssueAdministrationDetailPage({IssueAdministrationDetailArguments arguments})
      : this.arguments = arguments;

  @override
  State<StatefulWidget> createState() {
    return IssueAdministrationDetailState();
  }
}

class IssueAdministrationDetailState extends BaseState<
    IssueAdministrationDetailBloc, IssueAdministrationDetailPage> {
  @override
  void initBloc() {
    this.bloc = IssueAdministrationDetailBloc(
        context, this.widget.arguments.issue, this.widget.arguments.idIssue);
  }

  @override
  void onPostFrame() {
    this.bloc.getIssue();
    this.bloc.getStatusProcess();
    super.onPostFrame();
  }

  @override
  void didChangeDependencies() {
    this.bloc.updateDependencies(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringResource.getText(
            context, 'issue_administration_detail_title')),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: this.bloc.issueStream,
          builder: (context, snapShot) {
            bool error = false;
            if (snapShot.hasData) {
              error = !snapShot.data;
            }
            if (this.bloc.issue != null && !error) {
              return SingleChildScrollView(
                  child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: <Widget>[
                    this._headerTitle(StringResource.getText(
                        context, "issue_administration_detail_info")),
                    this._header(),
                    this._headerTitle(StringResource.getText(
                        context, "issue_administration_detail_handle")),
                    this._itemBodyStatus(),
                    this._itemBodyResolvedComment(),
                    StreamBuilder(
                      stream: this.bloc.processStream,
                      builder: (context, snapshot) {
                        List<Widget> ls = [];
                        ls.addAll(this._itemInfoAssign());
                        ls.addAll(this._itemInfoHandle());
                        ls.addAll(this._itemInfoAssignSupport());
                        ls.addAll(this._itemInfoSupport());
                        return Column(
                          children: ls,
                        );
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    this._process(),
                    this._locationIssue(),
                    this._imagesAttachment(),
                    this._imagesAttachmentResolve(),
                    this._videosAttachment(),
                    this._videosAttachmentResolve(),
                  ],
                ),
              ));
            } else if (error) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    StringResource.getText(context, "try_again_issue"),
                    style: TextStyle(color: ColorsResource.primaryColor),
                  ),
                ),
              );
            } else {
              return Center(
                child: Loading(
                  circleColor: ColorsResource.primaryColor,
                  backgroundColor: Colors.white,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  List<Widget> _itemInfoAssign() {
    List<Widget> lists = [];
    if (this.bloc.assignModel != null) {
      IssueProcessModel model = this.bloc.assignModel;
      if (model.nameAssigner != "") {
        lists.add(
          this._itemBodyPersonalAssign(),
        );
      }
      if (model.time != "") {
        lists.add(
          this._itemBodyTimeAssign(),
        );
      }
    }
    return lists;
  }

  List<Widget> _itemInfoHandle() {
    List<Widget> lists = [];
    if (this.bloc.handleModel != null) {
      IssueProcessModel model = this.bloc.handleModel;
      if (model.nameAssigner != null) {
        lists.add(
          this._itemBodyPersonalHandle(),
        );
      }
      if (model.time != "") {
        lists.add(
          this._itemBodyTimeHandle(),
        );
      }
    }
    return lists;
  }

  List<Widget> _itemInfoAssignSupport() {
    List<Widget> lists = [];
    if (this.bloc.assignSupportModel != null) {
      IssueProcessModel model = this.bloc.assignSupportModel;
      if (model.departmentName != "") {
        lists.add(
          this._itemBodyDepartmentSupport(),
        );
      }
      if (model.nameAssigner != "") {
        lists.add(
          this._itemBodyPersonalAssignSupport(),
        );
      }

      if (model.time != "") {
        lists.add(
          this._itemBodyTimelAssignSupport(),
        );
      }
    }
    return lists;
  }

  List<Widget> _itemInfoSupport() {
    List<Widget> lists = [];
    if (this.bloc.supportModel != null) {
      IssueProcessModel model = this.bloc.supportModel;
      if (model.nameAssigner != "") {
        lists.add(
          this._itemBodyPersonalSupport(),
        );
      }
      if (model.time != "") {
        lists.add(
          this._itemBodyTimeSupport(),
        );
      }
    }
    return lists;
  }

  Widget _headerTitle(String title) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: TitleContainer(
          titleText: title,
          titleColor: Theme.of(context).primaryColor,
          fontSize: DimenResource.textTitleSize,
        ),
      ),
    );
  }

  Widget _header() {
    Widget rightIteam = InfoIssueComponent(
      model: this.bloc.issue,
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 15,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  child: FadeInImage.assetNetwork(
                      placeholder: ImageResource.city_admin,
                      image: this.bloc.issue.imgUrl != null
                          ? this.bloc.issue.imgUrl
                          : ""),
                ),
              )),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            flex: 85,
            child: rightIteam,
          )
        ],
      ),
    );
  }

  Widget _itemBodyStatus() {
    final TextStyle status = TextStyle(
        color: ColorsResource.areaDetails, fontWeight: FontWeight.normal);
    return _bodyItem(
        StringResource.getText(context, 'issue_administration_detail_status') +
            this.bloc.issue.statusName,
        status,
        ColorsResource.areaDetails);
  }

  Widget _itemBodyResolvedComment() {
    final TextStyle resolvedComment = TextStyle(
        color: ColorsResource.contentIssue, fontWeight: FontWeight.normal);
    return this.bloc.issue.resolvedComment == null
        ? SizedBox()
        : _bodyItem(
            StringResource.getText(
                    context, 'issue_administration_detail_info_replay') +
                this.bloc.issue.resolvedComment,
            resolvedComment,
            ColorsResource.contentIssue);
  }

  Widget _itemBodyTimeSupport() {
    final TextStyle black =
        TextStyle(color: Colors.black, fontWeight: FontWeight.normal);
    return _bodyItem(
        StringResource.getText(
                    context, 'issue_administration_detail_time_support') +
                this.bloc.issue.resolvedComment ??
            "",
        black,
        Colors.black);
  }

  Widget _itemBodyPersonalAssign() {
    final TextStyle black =
        TextStyle(color: Colors.black, fontWeight: FontWeight.normal);
    return _bodyItem(
        StringResource.getText(
                context, 'issue_administration_detail_personal_assign') +
            this.bloc.assignModel.nameAssigner,
        black,
        Colors.black);
  }

  Widget _itemBodyTimeAssign() {
    final TextStyle black =
        TextStyle(color: Colors.black, fontWeight: FontWeight.normal);
    return _bodyItem(
        StringResource.getText(
                context, 'issue_administration_detail_time_assign_handle') +
            this.bloc.assignModel.time,
        black,
        Colors.black);
  }

  Widget _itemBodyPersonalHandle() {
    final TextStyle black =
        TextStyle(color: Colors.black, fontWeight: FontWeight.normal);
    return _bodyItem(
        StringResource.getText(
                context, 'issue_administration_detail_time_personal_handle') +
            this.bloc.handleModel.nameAssigner,
        black,
        Colors.black);
  }

  Widget _itemBodyTimeHandle() {
    final TextStyle black =
        TextStyle(color: Colors.black, fontWeight: FontWeight.normal);
    return _bodyItem(
        StringResource.getText(
                context, 'issue_administration_detail_time_handle') +
            this.bloc.handleModel.time,
        black,
        Colors.black);
  }

  Widget _itemBodyDepartmentSupport() {
    final TextStyle black =
        TextStyle(color: Colors.black, fontWeight: FontWeight.normal);
    return _bodyItem(
        StringResource.getText(
                context, 'issue_administration_detail_department_support') +
            this.bloc.assignSupportModel.departmentName,
        black,
        Colors.black);
  }

  Widget _itemBodyPersonalAssignSupport() {
    final TextStyle black =
        TextStyle(color: Colors.black, fontWeight: FontWeight.normal);
    return _bodyItem(
        StringResource.getText(context,
                'issue_administration_detail_personal_assign_support') +
            this.bloc.assignSupportModel.nameAssigner,
        black,
        Colors.black);
  }

  Widget _itemBodyTimelAssignSupport() {
    final TextStyle black =
        TextStyle(color: Colors.black, fontWeight: FontWeight.normal);
    return _bodyItem(
        StringResource.getText(
                context, 'issue_administration_detail_time_assign_support') +
            this.bloc.assignSupportModel.time,
        black,
        Colors.black);
  }

  Widget _itemBodyPersonalSupport() {
    final TextStyle black =
        TextStyle(color: Colors.black, fontWeight: FontWeight.normal);
    return _bodyItem(
        StringResource.getText(
                context, 'issue_administration_detail_personal_support') +
            this.bloc.assignSupportModel.nameAssigner,
        black,
        Colors.black);
  }

  Widget _bodyItem(String content, TextStyle style, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 15,
              child: Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.brightness_1,
                    size: 10.0,
                    color: iconColor,
                  ),
                ),
              )),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            flex: 85,
            child: Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                content,
                style: style,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _process() {
    return this._processAndMap(
      Icons.access_time,
      StringResource.getText(context, "issue_administration_detail_process"),
      true,
      this.bloc.gotoProcessView,
    );
  }

  Widget _locationIssue() {
    return this._processAndMap(
        Icons.map,
        StringResource.getText(context, "issue_administration_detail_location"),
        false,
        this.bloc.gotoMap);
  }

  Widget _processAndMap(
      IconData icon, String content, bool isProcess, Function ontap) {
    double sizeIcon = 34.0;
    double heightLine = 4.0;
    return Container(
        padding: EdgeInsets.symmetric(vertical: isProcess ? 5.0 : 0.0),
        child: GestureDetector(
            onTap: () {
              if (ontap != null) {
                ontap();
              }
            },
            child: Column(
              children: <Widget>[
                isProcess
                    ? Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Container(
                          width: double.infinity,
                          height: heightLine,
                          color: ColorsResource.primaryColor,
                        ),
                      )
                    : SizedBox(),
                Container(
                  padding: isProcess
                      ? EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0)
                      : EdgeInsets.only(bottom: 5.0, left: 10.0, right: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 15,
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(
                              icon,
                              size: sizeIcon,
                              color: ColorsResource.timeIssue,
                            ),
                          )),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        flex: 85,
                        child: Text(content,
                            style: TextStyle(
                                color: ColorsResource.timeIssue,
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600)),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: heightLine,
                  color: ColorsResource.primaryColor,
                ),
              ],
            )));
  }

  Widget _imagesAttachment() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ImageAttachmentComponent(
        model: this.bloc.issue,
      ),
    );
  }

  Widget _videosAttachment() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: VideoAttachmentComponent(
        model: this.bloc.issue,
      ),
    );
  }

  _imagesAttachmentResolve() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ImageAttachmentResolvedComponent(
        model: this.bloc.issue,
      ),
    );
  }

  _videosAttachmentResolve() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: VideoAttachmentResolvedComponent(
        model: this.bloc.issue,
      ),
    );
  }
}

class IssueAdministrationDetailArguments {
  IssueModel issue;
  String idIssue;

  IssueAdministrationDetailArguments({IssueModel issue, String idIssue}) {
    this.idIssue = idIssue;
    this.issue = issue;
  }
}
