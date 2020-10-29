import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/imgs_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/notification/notification.dart' as Model;

class NotificationItem extends StatelessWidget {
  final Model.Notification model;
  final Function(Model.Notification) deleteItem;

  const NotificationItem({this.model, this.deleteItem});

  @override
  Widget build(BuildContext context) {
    const double padding = 15.0;
    const double paddingText = 5.0;
    const double paddingtop = 10.0;
    return Slidable(
        actionPane: new SlidableScrollActionPane(),
        actionExtentRatio: 0.25,
        child: new Container(
          padding:
              EdgeInsets.symmetric(horizontal: padding, vertical: paddingtop),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 70.0,
                height: 70.0,
                padding: EdgeInsets.only(right: padding),
                child: Image.asset(ImageResource.megaphone),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      this.model.title,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: ColorsResource.textNotification, fontSize: 16.0),
                    ),
                    SizedBox(
                      height: paddingText,
                    ),
                    Text(
                      this.model.time,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: ColorsResource.textNotification, fontSize: 14.0),
                    ),
                    SizedBox(
                      height: paddingText,
                    ),
                    Text(
                      this.model.content,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: ColorsResource.textNotification, fontSize: 14.0),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: StringResource.getText(context, "delete"),
            color: Colors.red,
            icon: Icons.delete_forever,
            onTap: () {
              print("seto kaibaaa01");
              if (this.deleteItem != null) {
                this.deleteItem(model);
              }
            },
          ),
        ]);
  }

}
