import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/components/StarRating.dart';
import 'package:orim/components/raised_buttom_custom.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/enum_packages/enum_issue.dart';
import 'package:orim/config/strings_resource.dart';

class IssueRating extends StatelessWidget {
  IssueRating(
      {this.ratingObserver,
      this.ownerObserver,
      this.ratingComment,
      this.onRatingChanged,
      this.contentRatingFocusNode,
      this.contentRatingController,
      this.onPressSendFeedback,
      this.status});

  final Future<bool> ownerObserver;
  final Stream<double> ratingObserver;
  final String ratingComment;
  final Function(double) onRatingChanged;
  final TextEditingController contentRatingController;
  final FocusNode contentRatingFocusNode;
  final Function onPressSendFeedback;
  final int status;

  @override
  Widget build(BuildContext context) {
    Widget content;
    content = FutureBuilder(
      future: ownerObserver,
      builder: (context, AsyncSnapshot<bool> snapshotIsOwn) {
        if (snapshotIsOwn.hasData && snapshotIsOwn.data) {
          return this._view(context, true, _ratingMyOwn());
        } else {
          return this._view(context, false, _ratingOwnOther());
        }
      },
    );
    return content;
  }

  Widget _view(BuildContext context, bool isOwn, Widget child){
    Color color = Theme.of(context).primaryColor;
    return  this.status != IssueStatusEnum.ApprovedComplete || ratingComment == null ? SizedBox() : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.rate_review,
              color: color,
            ),
            Container(
              padding: EdgeInsets.only(left: 5.0),
              child: Text(
                StringResource.getText(context, 'rating'),
                style: TextStyle(
                    fontSize: DimenResource.textTitleSize,
                    fontWeight: FontWeight.bold,
                    color: color),
              ),
            ),
          ],
        ),
        child
      ],
    );
  }
  Widget _ratingMyOwn() {
    return StreamBuilder(
      stream: ratingObserver,
      builder: (context, AsyncSnapshot<double> snapshot) {
        return this.status != IssueStatusEnum.ApprovedComplete ? SizedBox() : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Center(
                child: StarRating(
                  spacing: 1.0,
                  rating: snapshot.hasData ? snapshot.data : 3,
                  onRatingChanged:
                      ratingComment == null ? onRatingChanged : null,
                ),
              ),
            ),
            ratingComment != null && this.status == IssueStatusEnum.ApprovedComplete
                ? Container(
                    padding: EdgeInsets.only(top: DimenResource.paddingContent, bottom: DimenResource.paddingContent),
                    child: Text('$ratingComment', textAlign: TextAlign.left,),
                  )
                : TextField(
                    controller: contentRatingController,
                    focusNode: contentRatingFocusNode,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText:
                          StringResource.getText(context, 'content_hint_text'),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                  ),
            ratingComment == null && this.status == IssueStatusEnum.ApprovedComplete
                ? RaisedButtonCustom(
                    text: StringResource.getText(context, 'send_feedback'),
                    onPressed: onPressSendFeedback,
                  )
                : Container()
          ],
        );
      },
    );
  }

  Widget _ratingOwnOther() {
    return StreamBuilder(
      stream: ratingObserver,
      builder: (context, AsyncSnapshot<double> snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              Container(
                child: Center(
                  child: StarRating(
                    spacing: 1.0,
                    rating: snapshot.data,
                  ),
                ),
              ),
              Text('$ratingComment'),
            ],
          );
        } else {
          return Container(
            padding: EdgeInsets.only(
                top: DimenResource.paddingContent,
                bottom: DimenResource.paddingContent),
            child: Center(
              child: Text(StringResource.getText(context, 'no_rating')),
            ),
          );
        }
      },
    );
  }
}
