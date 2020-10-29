import 'package:flutter/material.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/area/area_model.dart';

class WardComponent extends StatefulWidget {
  final Function(CurrentWard item) callback;
  final List<CurrentWard> wards;
  final String code;

  WardComponent(this.wards, this.code, {this.callback});

  @override
  State<StatefulWidget> createState() => _WardComponentState();
}

class _WardComponentState extends State<WardComponent>
    with AutomaticKeepAliveClientMixin {
  List<CurrentWard> wards = List();

  @override
  void initState() {
    super.initState();
    wards = widget.wards;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Text(StringResource.getText(context, "select_street"),
                style: TextStyle(
                    color: ColorsResource.lineAdministration, fontSize: 16.0))),
        Container(height: 1, color: ColorsResource.lineGray),
        Expanded(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: wards.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  widget.callback(wards[index]);
                },
                child: Container(
                  padding: EdgeInsets.all(DimenResource.paddingButton),
                  child: Text(wards[index].name, style: TextStyle(fontSize: 14, color: widget.code == wards[index].code ? ColorsResource.primaryColor : ColorsResource.lineAdministration)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
