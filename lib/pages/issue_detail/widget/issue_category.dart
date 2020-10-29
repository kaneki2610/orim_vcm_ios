import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/config/dimens_resource.dart';

class IssueCategoryAndContent extends StatelessWidget {
  const IssueCategoryAndContent(
      {this.subCategory, this.category, this.content});

  final String category, subCategory, content;

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.only(top: DimenResource.padding5, bottom: 5.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.category,
                  color: color,
                ),
                Flexible(
                  child: Text(
                    '$category - $subCategory',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: DimenResource.textTitleSize),
                  ),
                ),
              ],
            ),
          ),
          Text('$content')
        ],
      ),
    );
  }
}
