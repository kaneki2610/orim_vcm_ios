import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/loading.dart';
import 'package:orim/components/refresher.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/enum_packages/dashboard_list_type.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/pages/home/tab/administration/administration_child_item.dart';

import 'dashboad_list_bloc.dart';

class DashboardListPage extends StatefulWidget {
  static const String routeName = 'DashboardListPage';
  DashboardListArguments argument;
  DashboardListPage({DashboardListArguments argument}){
    this.argument = argument;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DashboardListPageState();
  }
}

class DashboardListPageState
    extends BaseState<DashboardListBloc, DashboardListPage> {
  @override
  void initBloc() {
    this.bloc = DashboardListBloc(context, this.widget.argument.type,
        areaCodeStatic: this.widget.argument.areaCodeStatic,
        kindOfTime: this.widget.argument.kindOfTime);
  }

  @override
  void onPostFrame() {
    this.bloc.getIssues();
    super.onPostFrame();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(this.bloc.getTitle()),
      ),
      body: StreamBuilder(
        stream: this.bloc.streamComplains,
        builder: (context, AsyncSnapshot<List<IssueModel>> data) {
          return Refresher(
            onRefresh: this.bloc.onRefresh,
            onLoadMore: this.bloc.onLoading,
            contentView: getWidget(data),
          );
        },
      ),
    );
  }

  getWidget(AsyncSnapshot<List<IssueModel>> data) {
    if (data.hasData) {
      if (data.data.length > 0) {
        return ListView.separated(
            itemBuilder: (context, index) {
              final IssueModel model = data.data[index];
              return AdministrationItem(model, () {
                this.bloc.goDetailComplain(model);
              });
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 1.0,
                color: ColorsResource.lineAdministration,
              );
            },
            itemCount: data.data.length);
      } else {
        return Align(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Text(StringResource.getText(context, 'no_complain')),
          ),
        );
      }
    } else {
      return Center(
        child: Loading(
          circleColor: ColorsResource.primaryColor,
          backgroundColor: Colors.white,
        ),
      );
    }
  }

  @override
  void dispose() {
    this.bloc.dispose();
    super.dispose();
  }
}

class DashboardListArguments {
  DashboardListEnum type;
  String kindOfTime;
  String areaCodeStatic;

  DashboardListArguments({DashboardListEnum type, String kindOfTime, String areaCodeStatic}){
    this.type = type;
    this.kindOfTime = kindOfTime;
    this.areaCodeStatic = areaCodeStatic;
  }
}
