import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/model/reflected.dart';
import 'package:orim/utils/widget/widget.dart';

class ReflectedItem extends StatelessWidget {
  final ReflectedModel reflected;

  const ReflectedItem({this.reflected});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(2.0),
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: ImageView.network(reflected.image),
                ),
                Positioned(
                  bottom: -20,
                  right: 0,
                  child: Container(
                    child: RaisedButton.icon(
                      color: Theme.of(context).primaryColor,
                      disabledColor: Theme.of(context).primaryColor,
                      onPressed: null,
                      icon: Icon(Icons.directions_car,
                          size: 20, color: Color(0xFFFFFFFF)),
                      label: Text(
                        reflected.category,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Icon(
                  Icons.insert_drive_file,
                  size: 20,
                  color: Color(0xff797979),
                ),
              ),
              Flexible(
                child: Text(
                  reflected.title,
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 14),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.location_on,
                size: 20,
                color: Color(0xff797979),
              ),
              Flexible(
                child: Text(
                  reflected.location,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Row(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.calendar_today,
                          size: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            reflected.dateText,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            size: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              reflected.timeText,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.share,
                        size: 20,
                        color: reflected.statusColor,
                      ),
                    ),
                    Text(
                      reflected.statusText,
                      style: TextStyle(color: reflected.statusColor),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
