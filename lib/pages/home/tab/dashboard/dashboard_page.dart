import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/container_appbar.dart';
import 'package:orim/components/drawer_toggle.dart';
import 'package:orim/components/title_container.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/enum_packages/enum_time_dashboard.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/dashboardarea/dashboard_area.dart';
import 'package:orim/model/dashboardarea/dashboard_object.dart';
import 'package:orim/model/dashboardarea/services_area.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/home/tab/dashboard/dashboard_bloc.dart';
import 'package:orim/pages/home/tab/dashboard/dashboard_chart.dart';
import 'package:orim/pages/home/tab/dashboard/dashboard_view.dart';
import 'package:orim/utils/alert_dialog.dart';
import 'dardboard_item.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage();

  static const routeName = 'dashboard_title';

  get objModel => null;

  @override
  State<StatefulWidget> createState() {
    return _DashboardState();
  }
}

class _DashboardState extends BaseState<DashboardBloc, DashboardPage>
    with AutomaticKeepAliveClientMixin<DashboardPage>
    implements DashboardView {
  int heightItemGird = 150;
  Map<String, String> mapKindOfTime = {
    KindOfTimeEnum.day: StringResource.getTextResource('dashboard_day_filter'),
    KindOfTimeEnum.week:
    StringResource.getTextResource('dashboard_week_filter'),
    KindOfTimeEnum.month:
    StringResource.getTextResource('dashboard_month_filter'),
    KindOfTimeEnum.year:
    StringResource.getTextResource('dashboard_year_filter'),
  };
  String _value ;
  void _setValue(String value) => setState(() => _value = value);
  @override
  void initBloc() {
    bloc = DashboardBloc(context: context, view: this);
  }

  @override
  void updateKeepAlive() {}

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.updateDependencies(context);
  }

  @override
  void onPostFrame() {
    // TODO: implement onPostFrame
    super.onPostFrame();
    this.bloc.getTotalAreaDashBoard();
    this.bloc.listenDataChange();
  }

  // test
  Future _selectTimeFilter() async {
    switch (await showDialog(
        context: context,
        child: SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
          title: Text(StringResource.getTextResource('select_kind_of_time')),
          children: <Widget>[
            SimpleDialogOption(
              child: Text(StringResource.getTextResource('dashboard_year_filter')),
              onPressed: () {
                this.bloc.onChangeFilterTime(KindOfTimeEnum.year);
                Navigator.pop(context, KindOfTimeEnum.year);
              },
            ),
            SimpleDialogOption(
              child: Text(StringResource.getTextResource('dashboard_month_filter')),
              onPressed: () {
                this.bloc.onChangeFilterTime(KindOfTimeEnum.month);
                Navigator.pop(context, KindOfTimeEnum.month);
              },
            ),
            SimpleDialogOption(
              child: Text(StringResource.getTextResource('dashboard_week_filter')),
              onPressed: () {
                this.bloc.onChangeFilterTime(KindOfTimeEnum.week);
                Navigator.pop(context, KindOfTimeEnum.week);
              },
            ),
            SimpleDialogOption(
              child: Text(StringResource.getTextResource('dashboard_day_filter')),
              onPressed: () {
                  this.bloc.onChangeFilterTime(KindOfTimeEnum.day);
                  Navigator.pop(context, KindOfTimeEnum.day);
              },
            ),
          ],
        ))){
      case KindOfTimeEnum.week:
        _setValue(StringResource.getTextResource('dashboard_week_filter'));
        break;
      case KindOfTimeEnum.day:
        _setValue(StringResource.getTextResource('dashboard_day_filter'));
        break;
      case KindOfTimeEnum.month:
        _setValue(StringResource.getTextResource('dashboard_month_filter'));
        break;
      case KindOfTimeEnum.year:
        _setValue(StringResource.getTextResource('dashboard_year_filter'));
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder(
          stream: this.bloc.enableDasBoardStream,
          builder: (context,AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return StreamBuilder(
                  stream: this.bloc.streamTotalDashBoard,
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            this.headerChart(),
                            this.filterTime(),
                            this.detailContentDashboard(),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child:SizedBox(
                          child: CircularProgressIndicator(),
                          width: 50,
                          height: 50,
                        ) ,
                      );
                    }
                  },
                );
              } else {
                return Column(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Text(
                          StringResource.getText(
                              context, "no_permission_view_feature"),
                          style: TextStyle(
                              color: ColorsResource.backgroundColorTabbar),
                        ),
                      ),
                    )
                  ],
                );
              }
            } else {
              return Center(child: Loading());
            }
          },
        ));
  }

  Widget headerChart() {
    return StreamBuilder(
      stream: this.bloc.chartServices,
      builder: (context, AsyncSnapshot<DashBoardAreaModel> snapshot) {
        if (snapshot.hasData && snapshot.data.sumIssue > 0) {
          DashBoardAreaModel model = snapshot.data;
          List<ServicesAreaModel> listServicesCurrent =
          new List<ServicesAreaModel>();
          listServicesCurrent = this.bloc.getValidServices(model);
          return Container(
            child: DetailChartDashBoard(
              list: listServicesCurrent,
            ),
          );
        } else {
          return Container(
            height: 250,
            child: Center(
              child: Text(StringResource.getText(
                  context, 'dashboard_no_data_services')),
            ),
          );
        }
//        return Container(
//          child: DetailChartDashBoard(),
//        );
      },
    );
  }

  Widget filterTime() {
    return Container(
      color: Colors.deepOrangeAccent,
      padding: EdgeInsets.symmetric(vertical: DimenResource.paddingContent),
      child: Column(
        children: <Widget>[
          StreamBuilder(
            stream: this.bloc.chartServices,
            builder: (context, AsyncSnapshot<DashBoardAreaModel> snapshot) {
              DashBoardAreaModel dashboard = snapshot.data;
              if (snapshot.hasData) {
                return (Text(
                  StringResource.getText(context, 'watching') +
                      '${dashboard.nameArea}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ));
              } else {
                return SizedBox(
                  height: 8,
                );
              }
            },
          ),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Container(
              color: Colors.white,
              height: 50,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding:
                    EdgeInsets.only(left: DimenResource.paddingContent),
                    child: Text(
                      StringResource.getText(context, 'time'),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(
                            right: DimenResource.paddingContent),
                        child: StreamBuilder(
                          stream: this.bloc.streamKindOfTime,
                          builder: (context, AsyncSnapshot<String> snapshot) {
                            print(snapshot.data);
                          return _selectAreaWidget();
                          },
                        )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _selectAreaWidget() {
    return Container(
      margin: EdgeInsets.only(
        left: DimenResource.paddingContent,
        right: DimenResource.paddingContent,
      ),
      width: 150.0,
      height: 40.0,
      child: RaisedButton(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey[350]),
            borderRadius:
            BorderRadius.circular(20),
          ),
          onPressed: (){
            this._selectTimeFilter();
          },
          color: Colors.white,
          textColor: Colors.black,
          disabledColor: Colors.white,
          disabledTextColor: Colors.grey,
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text( _value ??=
                StringResource.getTextResource('dashboard_year_filter'),
                maxLines: 1,
//                overflow: TextOverflow.ellipsis,
              ),
              Icon(
                  Icons.arrow_drop_down,
                  size: 25,
                  color: Colors.grey,
                ) ,
            ],
          )),
    );
  }

  Widget detailContentDashboard() {
    int maxLineNameArea = 2;
    int maxLineNumberIssue = 1;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: StreamBuilder(
              stream: this.bloc.streamTotalDashBoard,
              builder: (context, AsyncSnapshot snapShot) {
                if (snapShot.hasData) {
                  DashBoardObjectModel obj = snapShot.data;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: DimenResource.paddingContent,
                        vertical: DimenResource.paddingLarg),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: StreamBuilder(
                              stream: this.bloc.streamNameArea,
                              builder:
                                  (context, AsyncSnapshot<String> snapShot) {
                                if (snapShot.hasData) {
                                  return GestureDetector(
                                    onTap: () {
                                      this.bloc.changeHeaderService(
                                          model: this.bloc.areaObject);
                                    },
                                    child: Text(
                                      '${snapShot.data}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: DimenResource.textTitleSize,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                } else {
                                  return Text('');
                                }
                              }),
                        ),
                        Text(
                          StringResource.getText(
                              context, 'dashboard_sum_of_issues') +
                              '${obj.sumIssue} ' +
                              StringResource.getText(
                                  context, 'dashboard_processed_issues') +
                              '${obj.processed}' +
                              "(" +
                              '${this.bloc.calculatorPercents(
                                  obj.processed, obj.sumIssue)}' +
                              "%)",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          StringResource.getText(
                              context, 'dashboard_processing_issues') +
                              '${obj.processing}' +
                              "(" +
                              '${this.bloc.calculatorPercents(
                                  obj.processing, obj.sumIssue)}' +
                              "%)",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Text("");
                }
              },
            ),
          ),
          StreamBuilder(
            stream: this.bloc.streamTotalDashBoard,
            builder: (context, AsyncSnapshot snapShot) {
              if (snapShot.hasData) {
                DashBoardObjectModel obj = snapShot.data;
                List<DashBoardAreaModel> dataList = obj.listDashBoard;
                return GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: MediaQuery
                      .of(context)
                      .size
                      .width /
                      (this.heightItemGird * 2),
                  children: new List.generate(dataList.length, (index) {
                    return Card(
                      child: DashBoardItem(
                        objModel: dataList[index],
                        areaNameClicked: this.bloc.changeService,
                        processClicked: this.bloc.goToDashboardList,
                      ),
                    );
                  }),
                );
              } else if (snapShot.hasError) {
                return Text("");
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void showPopupError(String message) {
    // TODO: implement showPopupError
    this.showPopupWithAction(message, actions: [AlertDialogBuilder.button(
      text: StringResource.getText(context, 'agree'),
      onPress: () {
        NavigatorService.back(context);
      },
    )]);
  }
}

class DashboardPageTabbar extends StatelessWidget
    implements PreferredSizeWidget {
  final double height;

  const DashboardPageTabbar({
    Key key,
    this.height = DimenResource.heightTabbar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerAppbar(
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      isLightStatus: true,
      child: AppBar(
        leading: DrawerToggle(),
        title: TitleContainer(
          titleText: StringResource.getText(context, 'dashboard_title'),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
