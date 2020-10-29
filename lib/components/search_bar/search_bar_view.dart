import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/components/transition_page_route.dart';
import 'package:orim/config/dimens_resource.dart';

class _SearchBarView extends StatefulWidget {
  const _SearchBarView({this.data, this.title});

  final List<String> data;
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _SearchBarState();
  }
}

class _SearchBarState extends State<_SearchBarView> {
  final TextEditingController textEditingController = TextEditingController();
  List<String> dataDisplay;

  @override
  void initState() {
    super.initState();
    dataDisplay = List<String>.from(widget.data);
    textEditingController.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Material(
                elevation: 5.0,
                child: Container(
                  padding: EdgeInsets.all(DimenResource.paddingContent),
                  child: TextField(
                    controller: textEditingController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: _clearText,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.5),
                      ),
                      hintText: 'Tìm kiếm'),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: _renderItem,
                    separatorBuilder: _renderSeparator,
                    itemCount: dataDisplay.length),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.removeListener(listener);
    textEditingController.dispose();
    super.dispose();
  }

  Widget _renderSeparator(BuildContext context, int index) {
    return Container(
      height: 10,
    );
  }

  Widget _renderItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        final idx = widget.data.indexOf(dataDisplay[index]);
        Navigator.pop(context, idx);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Text(
          dataDisplay[index],
          style:
              TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.0),
        ),
      ),
    );
  }

  void listener() {
    if (mounted) {
      List<String> temp = widget.data.where((item) {
        String text = textEditingController.value.text.toLowerCase();
        String textItem = item.toLowerCase();
        return textItem.contains(text);
      }).toList();
      setState(() {
        dataDisplay = temp;
      });
    }
  }

  void _clearText() {
    textEditingController.clear();
  }
}

Future<int> selectItem(BuildContext context,
    {List<String> data, String title}) async {
  assert(data != null);
  final result = await Navigator.push(
      context,
      TransitionPageRoute(page: _SearchBarView(
        data: data,
        title: title,
      )));
  return result;
}

