
import 'package:flutter/material.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/pages/show_full_gallery/video_player_custom.dart';
import 'package:orim/utils/gallery_storage/attachement.dart';

class ShowFullGalleryBloc extends BaseBloc{
  int pos = 0;
  bool isFirst = true;
  List<VideoPlayerCustom> player = [];
  Widget pageView;
  PageController pageController = PageController();
  List<Attachment> medias;

  BehaviorSubject<int> _posSubject = BehaviorSubject();
  Stream<int> get posObserver => _posSubject.stream;


  ShowFullGalleryBloc({BuildContext context, int position, List<Attachment> medias})
      : this.pos = position,
        this.medias = medias,
        super(context: context);


  createPageViewWithIndex(int index){
    this.pos = index;
    this.pageController = PageController(initialPage: this.pos);
  }

  bool isNullPageView(){
    return this.pageView == null;
  }

  pauseVideo(){
    this.player.forEach((player) {
      player.pauseVideo();
    });
  }

  setPos(int position){
    this.pos = position;
    this._posSubject.value = this.pos;
  }

  @override
  void dispose() {
    this._posSubject.close();
    this.player.forEach((player) {
      player.dispose();
    });
    this.pageController.dispose();
  }
}