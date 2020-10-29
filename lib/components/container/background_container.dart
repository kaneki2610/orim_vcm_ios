import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/imgs_resource.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;

  BackgroundContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageResource.update_info_bg),
                    fit: BoxFit.fill)),
          ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.only(
                  left: DimenResource.paddingContent,
                  right: DimenResource.paddingContent),
              child: SingleChildScrollView(
                child: this.child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundContainerForm extends StatelessWidget {
  final Widget child;

  BackgroundContainerForm({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageResource.update_info_bg_form),
              fit: BoxFit.cover)),
      child: this.child,
    );
  }
}