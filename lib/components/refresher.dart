import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Refresher extends StatefulWidget {
  Function onRefresh;
  Function onLoadMore;
  Widget contentView;
  bool isLoadMore = true;

  Refresher(
      {this.onRefresh,
      this.onLoadMore,
      @required this.contentView,
      this.isLoadMore = true});

  @override
  State<StatefulWidget> createState() {
    return _RefresherState();
  }
}

class _RefresherState extends State<Refresher> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  onRefresh() async {
    if (widget.onRefresh != null) {
      await widget.onRefresh();
      refreshController.refreshCompleted();
    } else {
      refreshController.refreshCompleted();
    }
  }

  onLoading() async {
    if (!this.widget.isLoadMore) {
      refreshController.loadComplete();
    } else {
      if (widget.onLoadMore != null) {
        await widget.onLoadMore();
        refreshController.loadComplete();
      } else {
        refreshController.loadComplete();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(
        complete: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.done,
              color: Colors.grey,
            ),
            Container(
              width: 15.0,
            ),
            Text(
              StringResource.getText(context, 'refresh_complete'),
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          if (!this.widget.isLoadMore) {
            return SizedBox();
          }
          Widget body;
          body = CupertinoActivityIndicator();
          if (mode == LoadStatus.failed || mode == LoadStatus.idle) {
            body = Container();
          }
          return Container(
            height: 20.0,
            child: Center(child: body),
          );
        },
      ),
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: widget.contentView,
    );
  }
}
