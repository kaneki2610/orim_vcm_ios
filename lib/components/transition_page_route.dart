import 'package:flutter/material.dart';

class TransitionPageRoute extends PageRouteBuilder {
  final Widget page;
  TransitionPageRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionDuration: Duration(microseconds: 0),
  );
}