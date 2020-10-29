import 'package:flutter/material.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/area/area_model.dart';

class DistrictComponent extends StatefulWidget {
  final Function(CurrentDistrict item) callback;
  final List<CurrentDistrict> districts;
  final String name;

  DistrictComponent(this.districts, this.name, {this.callback});

  @override
  State<StatefulWidget> createState() => _DistrictComponentState();
}

class _DistrictComponentState extends State<DistrictComponent>
    with AutomaticKeepAliveClientMixin {
  List<CurrentDistrict> districts = List();

  @override
  void initState() {
    super.initState();
    districts = widget.districts;
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
            padding: EdgeInsets.only(bottom: DimenResource.padding5),
            color: ColorsResource.textColorTitle,
            alignment: Alignment.center,
            child: Text(StringResource.getText(context, "select_ward"),
                style: TextStyle(
                    color: ColorsResource.lineAdministration, fontSize: 16.0))),
        Container(height: 1, color: ColorsResource.lineGray),
        Expanded(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: districts.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  widget.callback(districts[index]);
                },
                child: Container(
                    padding: EdgeInsets.all(DimenResource.paddingButton),
                    child: Text(
                      districts[index].name,
                      style: TextStyle(fontSize: 14, color: widget.name == districts[index].code ? ColorsResource.primaryColor : ColorsResource.lineAdministration),
                    )),
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
