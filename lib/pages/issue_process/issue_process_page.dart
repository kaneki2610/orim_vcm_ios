import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/loading.dart';
import 'package:orim/components/try_again_button.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/entities/issue_process/issue_process_response.dart';
import 'package:orim/model/process.dart';
import 'package:orim/utils/time_util.dart';

import 'issue_process_bloc.dart';
import 'issue_process_view.dart';

class _IssueProcessPage extends StatefulWidget {
  const _IssueProcessPage({String issueId}) : issueId = issueId;

  final String issueId;

  @override
  State<StatefulWidget> createState() {
    return _IssueProcessState();
  }
}

class _IssueProcessState extends BaseState<IssueProcessBloc, _IssueProcessPage>
    implements IssueProcessView {
  @override
  void initBloc() {
    bloc =
        IssueProcessBloc(context: context, issueId: widget.issueId, view: this);
  }

  @override
  void onPostFrame() {
    super.onPostFrame();
    bloc.loadProcess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringResource.getText(context, 'issue_process')),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: bloc.loadProcess,
          child: StreamBuilder(
            stream: bloc.issueProcessObserver,
            builder:
                (context, AsyncSnapshot<List<IssueProcessModel>> snapshot) {
              if (snapshot.hasData) {
                return buildListProcess(data: snapshot.data);
              } else if (snapshot.hasError) {
                return Container(
                  child: Center(
                    child: TryAgainButton(
                      onPressed: bloc.loadProcess,
                    ),
                  ),
                );
              } else {
                return Container(
                  child: Center(
                    child: Loading(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  Future<void> showMessage({String msg}) {
    return toastMessage(msg: msg);
  }

  @override
  Future<void> showMessageExpired() {
    return toastMessageExpired();
  }

  @override
  Future<void> showNotPermission() {
    return toastMessagePermissionDeny();
  }

  @override
  Future<void> showTimeout() {
    return toastMessageTimeout();
  }

  Widget buildListProcess({List<IssueProcessModel> data}) {
    return ListView(
      padding: EdgeInsets.all(DimenResource.paddingContent),
      children: data
          .map((e) => itemProcess(
              model: e, isLast: data.indexOf(e) == (data.length - 1)))
          .toList(),
      semanticChildCount: data.length,
    );
  }

  Widget itemProcess({IssueProcessModel model, bool isLast}) {
    return IntrinsicHeight(
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _renderCheckPoint(isLast),
          Expanded(
            child: _renderInfo(model: model),
          )
        ],
      ) ,
    );
  }

  Widget _renderCheckPoint(bool isLast) {
    return Container(
      padding: EdgeInsets.only(left: 15.0),
      width: 70,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15),
            child:isLast ?  Container(
              width: 6.0,
              height: 20,
              color: Theme.of(context).primaryColor,
            ): Container(
              width: 6.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Container(
                width: 26,
                height: 26,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _renderInfo({IssueProcessModel model}) {
    Widget infoAssigner, infoAssignees;
    if (model.nameAssigner != "") {
      infoAssigner = _renderInfoRow(
          icon: Icon(Icons.person, color: ColorsResource.timeLineContact),
          content: StringResource.getText(context, 'issue_process_assigner') +
              model.nameAssigner +
              " (" +
              ((model.departmentName != null && model.departmentName.isNotEmpty)
                  ? model.departmentName
                  : model.nameAssigner) +
              ")");
    } else {
      infoAssigner = SizedBox();
    }
    //
    if (model.assignees.length > 0) {
      infoAssignees = _renderInfoRow(
          icon: Icon(Icons.person, color: ColorsResource.timeLineDepartment),
          content: (StringResource.getText(context, 'issue_process_assignes') +
              ((model.assignees[0].name != null &&
                      model.assignees[0].name.isNotEmpty)
                  ? model.assignees[0].name
                  : model.nameAssigner)));
    } else {
      infoAssignees = SizedBox();
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(DimenResource.paddingContent),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _renderInfoTime(
                dateText: TimeUtil.convertStringToTextDate(model.time),
                timeText: TimeUtil.convertStringToTextTime(model.time)),
            Container(
              height: DimenResource.paddingSubContent,
            ),
            infoAssigner,
            Container(
              height: DimenResource.paddingSubContent,
            ),
            infoAssignees,
            Container(
              height: DimenResource.paddingSubContent,
            ),
            _renderInfoRow(
                icon: Icon(Icons.insert_drive_file,
                    color: ColorsResource.timeLineContent,),
                content:
                    StringResource.getText(context, "issue_process_content") +
                        model.content, isCenter: false),
          ],
        ),
      ),
    );
  }

  Widget _renderInfoRow({Widget icon, String content, bool isCenter = true}) {
    return Row(
      crossAxisAlignment: isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: <Widget>[
        icon,
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 3.0),
            margin: EdgeInsets.only(left: DimenResource.paddingContent),
            child: Text(
              '$content',
            ),
          ),
        )
      ],
    );
  }

  _renderInfoTime({String dateText, String timeText}) {
    return Row(
      children: <Widget>[
        Text(
          '$dateText',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        Container(
          width: 20,
        ),
        Text(
          '$timeText',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 12.0,
          ),
        )
      ],
    );
  }
}

Future<int> showIssueProcess(BuildContext context, {String issueId}) async {
  assert(issueId != null);
  return await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => _IssueProcessPage(
                issueId: issueId,
              )));
}
