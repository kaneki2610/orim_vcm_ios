import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orim/components/raised_buttom_custom.dart';
import 'package:orim/components/title_container.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/entities/category/category.dart';
import 'package:orim/pages/send_complain/modal/modal_fields/modal_field_bloc.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ModalField extends StatefulWidget {
  static const String routeName = 'ModalField';

  final Function({String parentCode, String code}) callback;

  CategoryData categoryData;

  ModalField({this.categoryData, @required this.callback});

  @override
  State<StatefulWidget> createState() {
    return ModalFieldState();
  }
}

class ModalFieldState extends State<ModalField> {
  ModalFieldBloc _modalFieldBloc;

  @override
  void initState() {
    _modalFieldBloc = ModalFieldBloc(context: context, categoryData: widget.categoryData);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _modalFieldBloc.updateDependencies(context);
    _modalFieldBloc.getCategory();
    _modalFieldBloc.initListener();
    _modalFieldBloc.loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TitleContainer(
        titleText: StringResource.getText(context, 'select_field_title'),
      )),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
              left: DimenResource.paddingContent,
              right: DimenResource.paddingContent,
              top: DimenResource.paddingContent),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextField(
                controller: _modalFieldBloc.searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      left: DimenResource.paddingContent, right: DimenResource.paddingContent),
                  border: OutlineInputBorder(),
                  hintText: StringResource.getText(context, 'search_field'),
                ),
              ),
              Container(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.only(left: 4),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    StringResource.getText(context, "category_selected"),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )),
              SizedBox(height: 8),
              Container(
                alignment: Alignment.centerLeft,
                child: StreamBuilder(
                  stream: this._modalFieldBloc.categoryNameStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Visibility(
                        visible: snapshot.data != "" ? true : false,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                          ),
                          child: Text(
                            snapshot.data.toString().toUpperCase(),
                            style: TextStyle(
                              color: ColorsResource.textColorButton,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              Container(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: _modalFieldBloc.dataStream,
                  builder: (BuildContext context, AsyncSnapshot<List<Field>> snapshot) {
                    return ListView.builder(
                      itemCount: snapshot.hasData ? snapshot.data.length : 0,
                      itemBuilder: (BuildContext context, int index) {
                        return StickyHeader(
                          header: Container(
                            color: ColorsResource.backgroundContainer,
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              snapshot.data[index].name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          content: Container(
                            child: Wrap(
                              spacing: 10.0,
                              children: snapshot.data[index].subField.map((Field field) {
                                return InkWell(
                                  onTap: () {
                                    _modalFieldBloc.selecteItem(field, snapshot.data[index].name);
                                  },
                                  child: Chip(
                                    label: Container(
                                      child: Text(field.name),
                                    ),
                                    backgroundColor: field.selected
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey,
                                    labelStyle: TextStyle(color: ColorsResource.textColorButton),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              RaisedButtonCustom(
                onPressed: () async {
                  final Field field = await _modalFieldBloc.itemSelected();
                  if (field != null) {
                    widget.callback(parentCode: field.parentCode, code: field.code);
                    Navigator.of(context).pop();
                  } else {
                    Fluttertoast.showToast(msg: StringResource.getText(context, 'missing_field'));
                  }
                },
                text: StringResource.getText(context, 'confirm'),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _modalFieldBloc.dispose();
    super.dispose();
  }
}

class ModalFieldArguments {
  CategoryData categoryData;
  Function({String parentCode, String code}) callback;

  ModalFieldArguments({this.categoryData, this.callback});
}
