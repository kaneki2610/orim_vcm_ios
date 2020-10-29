import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/loading.dart';
import 'package:orim/components/refresher.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/enum_packages/enum_administration_tab.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/pages/home/tab/administration/administration_child_bloc.dart';
import 'package:orim/pages/home/tab/administration/administration_child_item.dart';
import 'package:orim/utils/alert_dialog.dart';

import '../../../../navigator_service.dart';
import 'administration_child_view.dart';

class AdministrationChildPage extends StatefulWidget {
  EnumAdministrationTab type;

  AdministrationChildPage({Key key, EnumAdministrationTab type})
      : this.type = type,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AdministrationChildState();
  }
}

class AdministrationChildState
    extends BaseState<AdministrationChildBloc, AdministrationChildPage>
    with AutomaticKeepAliveClientMixin<AdministrationChildPage>, AdministrationChildView {
  @override
  void initBloc() {
    this.bloc =
        AdministrationChildBloc(context: context, type: this.widget.type, view: this);
  }

  @override
  void onPostFrame() {
    super.onPostFrame();
    this.bloc.listenDataChange();
    this.bloc.getIssues();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
        print("listview total:  ${data.data.length}");
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
            child: Text(StringResource.getText(context, 'no_complain'), style: TextStyle(color: ColorsResource.primaryColor,)
        ),));
      }
    } else if (data.hasData) {
      return SizedBox();
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
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void showPopupError(String message) {
      this.showPopupWithAction(message, actions: [AlertDialogBuilder.button(
        text: StringResource.getText(context, 'agree'),
        onPress: () {
          NavigatorService.back(context);
        },
      )]);
  }
}
