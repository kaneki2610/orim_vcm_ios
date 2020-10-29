import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/loading.dart';
import 'package:orim/components/refresher.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/utils/alert_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../config/strings_resource.dart';
import '../../../../model/issue/issue.dart';
import '../../../../navigator_service.dart';
import 'handle_complain_child_bloc.dart';
import 'handle_complain_list_view.dart';
import 'handle_complain_list_bloc.dart';
import 'handle_complain_list_item.dart';
import 'mobx/handle_complain_mobx.dart';

class HandleComplainList extends StatefulWidget {
  HandleComplainListType type;
  ComplainMobx _complainMobx;
  int indexTabParent = 0;
  ScrollController scrollController;

  HandleComplainList(
      {Key key,
      HandleComplainListType type,
      ComplainMobx mobx,
      int indexTabParent,
      ScrollController scrollController})
      : this.type = type,
        this._complainMobx = mobx,
        this.indexTabParent = indexTabParent,
        this.scrollController = scrollController,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HandleComplainListState();
  }
}

class HandleComplainListState
    extends BaseState<HandleComplainListBloc, HandleComplainList>
    with AutomaticKeepAliveClientMixin<HandleComplainList>, HandlecomplainListView {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void initBloc() {
    this.bloc = HandleComplainListBloc(
        context,
        this.widget.type,
        this.widget.indexTabParent,
        this.widget._complainMobx,
        this.widget.scrollController, this);
  }

  @override
  void onPostFrame() {
    super.onPostFrame();
    this.bloc.listenDataChange();
    this.bloc.getIssues();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.updateDependencies(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return Scaffold(
      body: StreamBuilder(
        stream: this.bloc.streamComplains,
        builder: (context, AsyncSnapshot<List<IssueModel>> data) {
          return Refresher(
            onRefresh: bloc.onRefresh,
            onLoadMore: bloc.onLoading,
            contentView: Container(
              color: Colors.white,
              child: getWidget(data),
            ),
          );
        },
      ),
    );
  }
  getWidget(AsyncSnapshot<List<IssueModel>> data) {
    if (data.hasData) {
      if (data.data.length > 0) {
        return ListView.separated(
            controller: this.bloc.scrollController,
            itemBuilder: (context, index) {
              final IssueModel model = data.data[index];
              return ComplainItem(model: model, onPressed: () => this.bloc.goDetailComplain(model), isShowResolvedComment: this.bloc.isShowResolvedComment(),);
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
    } else if(data.hasError){
      return SizedBox();
    }else {
      return Center(
        child: Loading(
          circleColor: ColorsResource.primaryColor,
          backgroundColor: Colors.white,
        ),
      );
    }
  }

  @override
  void updateKeepAlive() {}

  @override
  bool get wantKeepAlive => true;

  @override
  void showPopupError(String message) {
    this.showPopupWithAction(message, actions: [AlertDialogBuilder.button(
      text: StringResource.getText(context, 'agree'),
      onPress: () {
        NavigatorService.back(context);
      },
    )]);  }
}
