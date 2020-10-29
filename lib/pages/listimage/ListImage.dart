import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ListImageArguments {
  List<String> list;
  int index;

  ListImageArguments({ this.list, this.index });
}

// ignore: must_be_immutable
class ListImage extends StatelessWidget {
  static const routeName = 'ListImage';

  ListImageArguments listImageArgument;
  PageController _pageController;

  ListImage({this.listImageArgument}) {
    _pageController = PageController(initialPage: this.listImageArgument.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.black,
            child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(listImageArgument.list[index]),
              initialScale: PhotoViewComputedScale.contained,
//              heroAttributes: HeroAttributes(tag: galleryItems[index].id),
            );
          },
          itemCount: listImageArgument.list.length,
          loadingChild: Loading(
              indicator: BallPulseIndicator(),
              size: 100.0,
              color: Colors.black),
          backgroundDecoration: BoxDecoration(
            color: Colors.black
          ),
          pageController: _pageController,
          onPageChanged: (index) {
            print(index);
          },
        )),
      ),
    );
  }
}
