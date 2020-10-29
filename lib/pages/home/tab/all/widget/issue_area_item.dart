import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/enum_packages/enum_issue.dart';
import 'package:orim/config/imgs_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/issue/issue.dart';
import 'package:orim/utils/widget/widget.dart';

class IssueAreaItem extends StatelessWidget {
  final double padding3 = 2.0;
  const IssueAreaItem(
      {IssueModel item,
        this.paddingBottom = 0.0,
        this.onPressed,
        String icon,
        this.isFromHistoryPage})
      : _model = item, _icon = icon;

  final IssueModel _model;
  final double paddingBottom;
  final Function(IssueModel) onPressed;
  final bool isFromHistoryPage;
  final String _icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: DimenResource.paddingContent,
            right: DimenResource.paddingContent,
          ),
          child: Container(
            color: ColorsResource.textColorTitle,
            child: InkWell(
              onTap: _onPressed,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _renderBanner(context),
                    _content(child: _renderLocation(context)),
                    _content(child: _renderSubCategory(context)),
                    this._model.resolvedComment == null ||
                        this._model.resolvedComment == ""
                        ? SizedBox()
                        : _content(child: _renderResolvedComment(context)),
                    this.isFromHistoryPage == false
                        ? SizedBox()
                        : _content(child: _renderSender(context)),
                    _content(child: _renderTimeIssues(context)),
                    _content(child: _renderStatus(context)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _renderBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      height: DimenResource.heightBanner,
      padding: EdgeInsets.all(DimenResource.paddingContent),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ImageView.network(
            _model.background,
            fit: BoxFit.cover,
          ),
          Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5.0),
                  color: Theme.of(context).primaryColor,
                  child: Text('${_model.category}',
                      style: TextStyle(
                        color: ColorsResource.textColorTitle,
                      )),
                ),
              ])
        ],
      ),
    );
  }

  Widget _renderLocation(BuildContext context) {
    Color color = Color(0xFF7E3D92);
    return Container(
      padding: EdgeInsets.only(bottom: this.padding3),
      child:_baseWidget(
          color: color, icon: Icons.location_on, content: _model.location),
    );
  }

  Widget _renderSubCategory(BuildContext context) {
    Color color = Colors.redAccent;
    return Container(
      padding: EdgeInsets.only(bottom: this.padding3),
      child:_categoryIconWidget(
          color: color, icon: _icon, content: _model.content) ,
    );
  }

  Widget _renderSender(BuildContext context) {
    Color color = Colors.grey[700];
    return Container(
      padding: EdgeInsets.only(bottom: this.padding3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('${StringResource.getText(context, 'sender')}: ',
              style: TextStyle(color: color, fontWeight: FontWeight.normal)),
          Flexible(
            child: Text(
              '${_model?.sender?.phoneNumber != null ? '${_model?.sender?.phoneNumber} - ' : ''}${_model?.sender?.name ?? ""}',
              style: TextStyle(color: color, fontWeight: FontWeight.normal),
            ),
          )
        ],
      ) ,
    );
  }

  Widget _renderResolvedComment(BuildContext context) {
    Color color = Colors.redAccent;
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(bottom: this.padding3),
      child: Text(
        '${_model.resolvedComment}',
        style: TextStyle(color: color, fontWeight: FontWeight.normal),
        softWrap: true,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  Widget _renderTimeIssues(BuildContext context) {
    Color color = Colors.grey[700];
    final double padding = 5.0;
    return Container(
      padding: EdgeInsets.only(bottom: this.padding3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            (StringResource.getText(context, 'issue_area_item_time_created') +
                '${_model.dateText} ${_model.timeText}'),
            style: TextStyle(fontWeight: FontWeight.normal, color: color),
          ),
          SizedBox(
            height: padding,
          ),
          _model.dateResolved != "" && _model.timeResolved != "" ?
          Text(
            (StringResource.getText(context, 'issue_area_item_time_resolved') +
                '${_model.dateResolved} ${_model.timeResolved}'),
            style: TextStyle(fontWeight: FontWeight.normal, color: color),
          ) : SizedBox(),
        ],
      ),
    );
  }

  Widget _renderStatus(BuildContext context) {
    Color color = IssueStatusEnum.getColorByStatus(_model.status);
    return Container(
      padding: EdgeInsets.only(
////          top: DimenResource.paddingContent,
          bottom: DimenResource.paddingContent),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
//          Flexible(
//            child: Row(
//              children: <Widget>[
//                Flexible(
//                  child: Text(
//                    '${_model.dateText} ${_model.timeText}', style: TextStyle(fontWeight: FontWeight.normal),
//                  ),
//                )
//              ],
//            ),
//          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  MdiIcons.stateMachine,
                  color: color,
                ),
                Flexible(
                  child: Text(
                    getNameStatus(_model.status),
                    style: TextStyle(color: color),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _baseWidget({Color color, IconData icon, String content}) {
    final double size = 20.0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: color,
          size: size,
        ),
        Flexible(
          child: Text(
            content,
            style: TextStyle(color: color, fontWeight: FontWeight.normal),
          ),
        )
      ],
    );
  }

  Widget _categoryIconWidget({Color color, String icon, String content}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        FadeInImage.assetNetwork(
            width: 20,
            height: 20,
            placeholder: ImageResource.city_admin,
            image:
            icon != null || icon != "" ? icon : ""),
        SizedBox(width: 4),
        Flexible(
          child: Text(
            content,
            style: TextStyle(color: color, fontWeight: FontWeight.normal),
          ),
        )
      ],
    );
  }

  Widget _content({Widget child}) {
    return Container(
      padding: EdgeInsets.only(
        left: DimenResource.paddingContent,
        right: DimenResource.paddingContent,
        bottom: 2.0,
        top: 2.0,
      ),
      child: child,
    );
  }

  void _onPressed() {
    if (onPressed != null) {
      onPressed(_model);
    }
  }

  String getNameStatus(int status) {
    String str =
    StringResource.getTextResource('issue_area_item_handling_state');
    if (status == IssueStatusEnum.ApprovedComplete) {
      str = StringResource.getTextResource('issue_area_item_completed_state');
    } else if (status == IssueStatusEnum.RecycleIssue) {
      str = StringResource.getTextResource('issue_area_item_spam_state');
    } else if (status == IssueStatusEnum.NewIssue) {
      str = StringResource.getTextResource('issue_area_item_new_state');
    }
    return str;
  }
}
