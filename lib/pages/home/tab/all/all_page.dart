import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/container_appbar.dart';
import 'package:orim/components/drawer_toggle.dart';
import 'package:orim/components/loading.dart';
import 'package:orim/components/raised_buttom_custom.dart';
import 'package:orim/components/refresher.dart';
import 'package:orim/components/search_bar/search_bar_view.dart';
import 'package:orim/components/title_container.dart';
import 'package:orim/components/try_again_button.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/enum_packages/enum_filter_type.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/pages/home/tab/all/all_bloc.dart';
import 'package:orim/pages/home/tab/all/widget/issue_area_item.dart';

import 'all_view.dart';

class AllPage extends StatefulWidget {
  static const String routeName = 'all_tab';

  const AllPage();

  @override
  State<StatefulWidget> createState() {
    return _AppPageState();
  }
}

class _AppPageState extends BaseState<AllBloc, AllPage>
    with AllView, AutomaticKeepAliveClientMixin<AllPage> {
  @override
  void initBloc() {
    bloc = AllBloc(context: context, view: this);
  }

  @override
  void onPostFrame() {
    this.bloc.listenDataChange();
    this.bloc.getWards();
    this.bloc.getIssueArea();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.updateDependencies(context);
  }

  @override
  void updateKeepAlive() {}

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsResource.textColorTitle,
      child: Column(
        children: <Widget>[
          _renderFilter(context),
          StreamBuilder(
            stream: bloc.issuesAreaObserver,
            builder: (context, AsyncSnapshot<List<IssueModel>> snapshot) {
              if (snapshot.hasData) {
                Widget contentView;
                if (snapshot.data.length > 0) {
                  List<IssueModel> issues = [];
                  issues = snapshot.data;
                  contentView = ListView.separated(
                      itemBuilder: (context, index) => IssueAreaItem(
                            item: issues[index],
                            paddingBottom: DimenResource.paddingContent,
                            onPressed: bloc.gotoIssueDetail,
                            icon: this.bloc.getCategoryIcon(issues[index].category),
                            isFromHistoryPage: false,
                          ),
                      separatorBuilder: (context, index) => Divider(
                            color: ColorsResource.lineAdministration,
                          ),
                      itemCount: issues.length);
                } else {
                  contentView = Center(
                    child: Text(
                        StringResource.getText(context, 'no_data_issues_area')),
                  );
                }
                return Expanded(
                  child: Refresher(
                    onRefresh: bloc.onRefresh,
                    onLoadMore: bloc.onLoadMore,
                    contentView: contentView,
                  ),
                );
              } else if (snapshot.hasError) {
                String errorKey = snapshot.error.toString();
                return errorKey == EnumFilterType.filterProvince
                    ? Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: DimenResource.paddingContent,
                                right: DimenResource.paddingContent),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  StringResource.getText(
                                      context, 'filter_province'),
                                  textAlign: TextAlign.center,
                                ))),
                      )
                    : Column(
                        children: <Widget>[
                          Icon(Icons.error_outline,
                              color: Colors.red, size: 120),
                          Text(
                              StringResource.getText(context, 'error_network')),
                          TryAgainButton(
                            onPressed: bloc.getIssueArea,
                          )
                        ],
                      );
              } else {
                return Expanded(
                  child: Center(
                    child: Loading(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  showDialogProvince() async {
    final List<String> data = bloc.provinces.map((item) => item.name).toList();
    if (data.length > 0) {
      final index = await selectItem(context,
          data: data,
          title: StringResource.getText(context, 'select_province'));
      if (index != null) {
        bloc.updateProvinceSelected(index);
        bloc.getWards();
      }
    }
  }

  showDialogWard() async {
    final List<String> data = bloc.wards.map((item) => item.name).toList();
    if (data.length > 0) {
      final index = await selectItem(context,
          data: data, title: StringResource.getText(context, 'select_ward'));
      if (index != null) {
        bloc.updateWardSelected(index);
      }
    }
  }

  Widget _renderFilter(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: DimenResource.paddingContent,
          left: DimenResource.paddingContent,
          right: DimenResource.paddingContent),
      child: Row(
        children: <Widget>[
          //SizedBox(width: DimenResource.paddingButton),
          Flexible(
              child: StreamBuilder(
                  stream: bloc.provinceObserver,
                  builder: (context, AsyncSnapshot<String> snapshotProvince) {
                    return StreamBuilder(
                      stream: bloc.wardObserver,
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        return Visibility(
                          visible: bloc.disableSelectWard ? false : true,
                          child: RaisedButtonCustom(
                            text: snapshot.hasData
                                ? snapshot.data
                                : StringResource.getText(context, 'select_ward'),
                            onPressed: showDialogWard
                          ),
                        );
                      },
                    );
                  })),
        ],
      ),
    );
  }
}

class AllPageTabbar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const AllPageTabbar({
    Key key,
    this.height = DimenResource.heightTabbar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerAppbar(
      backgroundColor: Theme.of(context).primaryColor,
      isLightStatus: true,
      child: AppBar(
        leading: DrawerToggle(),
        title: TitleContainer(
          titleText: StringResource.getText(context, 'all_tab_title'),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
