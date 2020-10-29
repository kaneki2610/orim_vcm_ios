import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/container_appbar.dart';
import 'package:orim/components/drawer_toggle.dart';
import 'package:orim/components/loading.dart';
import 'package:orim/components/title_container.dart';
import 'package:orim/components/try_again_button.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/pages/home/tab/all/widget/issue_area_item.dart';
import 'package:orim/pages/home/tab/history/history_page_bloc.dart';
import 'package:orim/pages/home/tab/history/mobx/history_mobx.dart';

class HistoryPage extends StatefulWidget {
  static const String routeName = 'history_tab';

  const HistoryPage({HistoryMobx mobx}) : _historyMobx = mobx;

  final HistoryMobx _historyMobx;

  @override
  State<StatefulWidget> createState() {
    return _HistoryPageState();
  }
}

class _HistoryPageState extends BaseState<HistoryPageBloc, HistoryPage>
    with AutomaticKeepAliveClientMixin<HistoryPage> {
  @override
  void initBloc() {
    bloc = HistoryPageBloc(context: context);
  }

  @override
  void onPostFrame() {
    super.onPostFrame();
    this.bloc.listenDataChange();
    bloc.getListIssues();
    widget._historyMobx.reaction((_) => widget._historyMobx.isShowCalendar,
        (state) => bloc.setToggleCalendar(state));
  }

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
  void updateKeepAlive() {}

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: StreamBuilder(
        stream: bloc.streamIssues,
        builder: (context, AsyncSnapshot<List<IssueModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              List<IssueModel> issues = [];
              issues = snapshot.data;
//              List<Widget> list = [];
//              for (final data in snapshot.data) {
//                list.add(IssueAreaItem(
//                  item: data,
//                  paddingBottom: DimenResource.paddingContent,
//                  onPressed: bloc.gotoDetail,
//                ));
//              }
              return Column(
                children: <Widget>[
                  _calendar(),
                  Expanded(
                    child: Container(
                      color: ColorsResource.textColorTitle,
                      child: ListView.separated(
                          itemBuilder: (context, index) => IssueAreaItem(
                            item: issues[index],
                            paddingBottom: DimenResource.paddingContent,
                            onPressed: bloc.gotoDetail,
                            icon: this.bloc.getCategoryIcon(issues[index].category),
                            isFromHistoryPage: true,
                          ),
                          separatorBuilder: (context, index) => Divider(
                            color: ColorsResource.lineAdministration,
                          ),
                          itemCount: issues.length
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                children: <Widget>[
                  _calendar(),
                  Expanded(
                    child: Center(
                      child: Text(
                          StringResource.getText(context, 'no_issue_send')),
                    ),
                  )
                ],
              );
            }
          } else if (snapshot.hasError) {
            return SizedBox();
          } else {
            return Center(
              child: Loading(),
            );
          }
        },
      ),
    );
  }

  Widget _calendar() {
    return Observer(builder: (context) {
      if (widget._historyMobx.isShowCalendar) {
        return Container(
          child: StreamBuilder(
            stream: bloc.streamDate,
            builder: (context, snapshot) {
              String title = snapshot.hasData ? snapshot.data : "";
              return ListTile(
                leading: Icon(
                  Icons.calendar_today,
                  color: ColorsResource.primaryColor,
                ),
                title: Text(
                  title,
                  style: TextStyle(color: ColorsResource.primaryColor),
                ),
                onTap: () async {
                  DateTime newDateTime = await showRoundedDatePicker(
                    context: context,
                    locale: Locale('vi', 'VN'),
                    initialDate: bloc.getDateSelect(),
                    firstDate: DateTime.parse('2010-01-01 00:00:00.000'),
                    lastDate: DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        23,
                        59,
                        59,
                        0,
                        0),
                    borderRadius: 16,
                  );
                  if (newDateTime != null) {
                    this.bloc.setDateSelect(newDateTime);
                  }
                },
              );
            },
          ),
        );
      } else {
        return Container();
      }
    });

//    return StreamBuilder(
//      stream: bloc.streamCalendar,
//      builder: (context, AsyncSnapshot<bool> snapshot) {
//        return snapshot.hasData == false || snapshot.data == false
//            ? Container()
//            : Container(
//                child: StreamBuilder(
//                  stream: this.bloc.streamDate,
//                  builder: (context, snapshot) {
//                    String title = snapshot.hasData ? snapshot.data : "";
//                    return ListTile(
//                      leading: Icon(
//                        Icons.calendar_today,
//                        color: ColorsResource.primaryColor,
//                      ),
//                      title: Text(
//                        title,
//                        style: TextStyle(color: ColorsResource.primaryColor),
//                      ),
//                      onTap: () async {
//                        DateTime newDateTime = await showRoundedDatePicker(
//                          context: context,
//                          locale: Locale('vi', 'VN'),
//                          initialDate: this.bloc.getDateSelect(),
//                          firstDate: DateTime.parse('2010-01-01 00:00:00.000'),
//                          lastDate: DateTime(
//                              DateTime.now().year,
//                              DateTime.now().month,
//                              DateTime.now().day,
//                              23,
//                              59,
//                              59,
//                              0,
//                              0),
//                          borderRadius: 16,
//                        );
//                        if (newDateTime != null) {
//                          this.bloc.setDateSelect(newDateTime);
//                        }
//                      },
//                    );
//                  },
//                ),
//              );
//      },
//    );
  }
}

class HistoryPageTabbar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const HistoryPageTabbar({
    Key key,
    this.height = DimenResource.heightTabbar,
    @required HistoryMobx mobx,
  })  : _historyMobx = mobx,
        super(key: key);

  final HistoryMobx _historyMobx;

  @override
  Widget build(BuildContext context) {
    return ContainerAppbar(
      backgroundColor: Theme.of(context).primaryColor,
      isLightStatus: true,
      child: AppBar(
        leading: DrawerToggle(),
        title: TitleContainer(
          titleText: StringResource.getText(context, 'history_tab_title'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_today),
//            onPressed: () {
//              IssueViewModel _issueViewModel =
//                  Provider.of<IssueViewModel>(context, listen: false);
//              _issueViewModel.showCalendarSubject.value = true;
//            },
            onPressed: _historyMobx.toggleCalendar,
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class HistoryPageLogin extends StatelessWidget{
  final HistoryPageLoginArgument argument;
  static const String routeName = 'history_login';
  const HistoryPageLogin({
    Key key,
    @required HistoryPageLoginArgument argument,
  })  : this.argument = argument,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TitleContainer(
            titleText: StringResource.getText(context, 'history_tab_title'),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.calendar_today),
//            onPressed: () {
//              IssueViewModel _issueViewModel =
//                  Provider.of<IssueViewModel>(context, listen: false);
//              _issueViewModel.showCalendarSubject.value = true;
//            },
              onPressed: this.argument.historyMobx.toggleCalendar,
            )
          ],
        ),

      body: HistoryPage(mobx: this.argument.historyMobx,),
    );
  }
}

class HistoryPageLoginArgument {
  HistoryMobx historyMobx;
  HistoryPageLoginArgument({this.historyMobx});
}