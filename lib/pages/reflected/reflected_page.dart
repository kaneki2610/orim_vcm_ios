import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/components/bottom_bar/bottom_bar_help.dart';
import 'package:orim/components/reflected_item.dart';
import 'package:orim/model/reflected.dart';

class ReflectedPage extends StatefulWidget {
  static const routeName = 'reflect';

  final String title = "PHẢN ÁNH";

  final List<ReflectedModel> listReflected = [];
  final List<_Category> listCategories = [];
  final List<String> actions = [];

  ReflectedPage() {
    for (var i = 0; i < 10; i++) {
      ReflectedModel newItem = ReflectedModel(
          id: i.toString(),
          title: 'Kẹt xe nghiêm trọng tại đường Phạm Ngọc Thạch',
          image:
          'https://i-vnexpress.vnecdn.net/2020/01/19/0022400013520Still006-15794491-7893-4286-1579449174_r_500x300.jpg',
          location: '42 Phạm Ngọc Thạch, phường 6, quận 3, TPHCM',
          dateText: '21/10/2019',
          timeText: '10:34:55',
          status: i % 4,
          category: 'Giao thông');
      listReflected.add(newItem);
    }
    for (var i = 0; i < 3; i++) {
      _Category category = _Category(
          icon: Icon(
            Icons.directions_car,
            color: Colors.blue,
          ),
          text: 'Hạ tầng');
      listCategories.add(category);
    }
    actions.add('Help');
    actions.add('Contact');
  }

  @override
  _ReflectedPageState createState() {
    return _ReflectedPageState();
  }
}

class _ReflectedPageState extends State<ReflectedPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomBarHelp(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        //`true` if you want Flutter to automatically add Back Button when needed,
        //or `false` if you want to force your own back button every where
        title: Text(widget.title),
//          leading: CustomBackButton(),
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) =>
                widget.actions
                    .map((String e) =>
                    PopupMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ))
                    .toList(),
          )
        ],
      ),
      body: SafeArea(
        child: _content(),
      ),
    );
  }

  _content() {
    return Column(
      children: <Widget>[
        renderCategory(),
        Expanded(
          child: ListView.builder(
            itemCount: widget.listReflected.length + 1,
            itemBuilder: (context, index) =>
                index < widget.listReflected.length ?
                InkWell(
                  child: ReflectedItem(reflected: widget.listReflected[index]),
                  onTap: () => _gotoDetail(widget.listReflected[index]),
                ) : Container(
                  height: 50,
                ),
          ),
        ),
      ],
    );
  }

  Widget renderCategory() {
    return Column(
//      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'CHUYÊN MỤC PHẢN ÁNH',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget.listCategories
                  .map((_Category e) =>
                  RaisedButton.icon(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Theme
                                  .of(context)
                                  .primaryColor)),
                      onPressed: () => onSelectedCategory(e),
                      icon: e.icon,
                      label: Text(
                        e.text,
                        style: TextStyle(color: Theme
                            .of(context)
                            .primaryColor),
                      )))
                  .toList()),
        )
      ],
    );
  }

  void onSelectedCategory(_Category category) {
    print(category);
  }

  void _gotoDetail(ReflectedModel reflected) {
    Navigator.pushNamed(context, 'detail_reflect', arguments: reflected);
  }
}

class _Category {
  Icon icon;
  String text;

  _Category({this.icon, this.text});
}
