import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/tabbar_color.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/strings_resource.dart';

import 'handle_complain_bloc.dart';
import 'handle_complain_child_bloc.dart';
import 'mobx/handle_complain_mobx.dart';

class HandleComplainChild extends StatefulWidget {

  static const String routeAssignName = 'handle_assign_tab';
  static const String routeHandleName = 'handle_handle_tab';
  static const String routeApprovedName = 'handle_approve_tab';

  HandleComplainType typeHandle;
  ComplainMobx _complainMobx;

  HandleComplainChild({Key key, HandleComplainType type, ComplainMobx mobx})
      : this.typeHandle = type,
        this._complainMobx = mobx,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HandleComplainChildState();
  }
}

class HandleComplainChildState
    extends BaseState<HandleComplainChildBloc, HandleComplainChild>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<HandleComplainChild> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void initBloc() {
    this.bloc = HandleComplainChildBloc(
      context,
      this.widget.typeHandle,
      this.widget._complainMobx,
      TabController(
          vsync: this,
          length:
              this.widget.typeHandle == HandleComplainType.approved ? 1 : 2),
    );
  }

  @override
  void onPostFrame() {
    // TODO: implement onPostFrame
    super.onPostFrame();
//    widget._complainMobx.reaction((_) => widget._complainMobx.isShowCalendar,
//        (state) => this.bloc.setToggleCalendar(state));
//    widget._complainMobx.reaction((_) => widget._complainMobx.isShowSearch,
//            (state) => this.bloc.setToggleSearch(state));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.updateDependencies(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: this.bloc.typeHandle == HandleComplainType.approved
          ? 1
          : this.bloc.tabViews.length,
      child: Column(
        children: <Widget>[
          StreamBuilder(
            builder: (context, data) {
              return AnimatedContainer(
                height: data.hasData ? data.data : 0.0,
                width: double.infinity,
                color: Colors.white,
                duration: Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                child: _filter(
                  data,
                ),
              );
            },
            stream: this.bloc.streamHeader,
          ),
          this.bloc.typeHandle == HandleComplainType.approved
              ? SizedBox()
              : Container(
                  color: Colors.white,
                  child: TabBar(
                      indicatorColor: Colors.orange,
                      labelColor: ColorsResource.primaryColor,
                      tabs: this.bloc.tabs),
                ),
          Flexible(
            child: TabBarView(
                children: this.bloc.typeHandle == HandleComplainType.approved
                    ? this.bloc.view
                    : this.bloc.tabViews),
          )
        ],
      ),
    );
  }

  Widget _filter(data) {
    Widget filter = Container();
    filter =  SingleChildScrollView(
      child: Card(
        child: Column(
          children: <Widget>[
            this._search(),
            this._calendar(),
          ],
        ),
      ),
    );
    return filter;
  }

  Widget _calendar() {
    return Observer(builder: (context) {
      if (this.bloc.getIndexTab() ==
              this.widget._complainMobx.indexCurrentTab &&
          this.widget._complainMobx.isChangeCalendar == true) {
        this.bloc.isShowCalendar = !this.bloc.isShowCalendar;
        this.widget._complainMobx.isChangeCalendar = false;
        this.bloc.setHeightHeader();
      }

      if (this.widget._complainMobx.isShowCalendar == true ||
          this.widget._complainMobx.isShowCalendar == false) {
        if (this.bloc.isShowCalendar == true) {
          return Container(
            height: 45.0,
            child: StreamBuilder(
              stream: bloc.streamDate,
              builder: (context, snapshot) {
                String title = snapshot.hasData ? snapshot.data : "";
                return InkWell(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20.0,
                      ),
                      Icon(
                        Icons.calendar_today,
                        color: ColorsResource.primaryColor,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        title,
                        style: TextStyle(color: ColorsResource.primaryColor),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                    ],
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
          this.bloc.setDateSelect(null);
          return Container();
        }
      } else {
        return Container();
      }
    });
  }

  Widget _search() {
    return Observer(builder: (context) {
      if (this.bloc.getIndexTab() ==
              this.widget._complainMobx.indexCurrentTab &&
          this.widget._complainMobx.isChangeSearch == true) {
        this.widget._complainMobx.isChangeSearch = false;
        this.bloc.isShowSearch = !this.bloc.isShowSearch;
        this.bloc.setHeightHeader();
      }

      if (this.widget._complainMobx.isShowSearch == true ||
          this.widget._complainMobx.isShowSearch == false) {
        if (this.bloc.isShowSearch == true) {
          return Container(
            height: 45.0,
            margin: EdgeInsets.only(left: 20.0, right: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onChanged: (text) {
                      this.bloc.textSearchChange();
                    },
                    controller: this.bloc.textfieldController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: StringResource.getText(context, "handle_complain_find_issue"),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: this.bloc.streamShowClear,
                  builder: (context, AsyncSnapshot<bool> snapshot) {
                    return !snapshot.hasData || !snapshot.data
                        ? SizedBox()
                        : IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: Colors.grey,
                            ),
                            onPressed: this.bloc.clearSearch,
                          );
                  },
                ),
              ],
            ),
          );
        } else {
          this.bloc.clearSearch();
          return Container();
        }
      } else {
        return Container();
      }
    });
  }

  @override
  void updateKeepAlive() {}

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    this.bloc.dispose();
    super.dispose();
  }
}
