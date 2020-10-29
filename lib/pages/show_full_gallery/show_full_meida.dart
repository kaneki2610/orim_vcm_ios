import 'package:flutter/material.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/pages/show_full_gallery/show_full_media_bloc.dart';
import 'package:orim/pages/show_full_gallery/video_player_custom.dart';
import 'package:orim/utils/gallery_storage/attachement.dart';
import 'package:orim/utils/widget/widget.dart';
import 'package:video_player/video_player.dart';

const duration = 400;

class ShowFullGallery extends StatefulWidget {
  static const routeName = 'show_full_gallery';
  final ShowFullMediaArguments arguments;

  ShowFullGallery({@required this.arguments});

  @override
  State<StatefulWidget> createState() {
    return ImageSlider();
  }
}

class ImageSlider extends State<ShowFullGallery> with WidgetsBindingObserver {
  ShowFullGalleryBloc _showFullGalleryBloc;

  @override
  void initState() {
    super.initState();
    this._showFullGalleryBloc = ShowFullGalleryBloc(
        context: context,
        position: widget.arguments.positionSelect,
        medias: widget.arguments.medias);
    this
        ._showFullGalleryBloc
        .createPageViewWithIndex(widget.arguments.positionSelect);
  }

  @override
  Widget build(BuildContext context) {
//    Size size = MediaQuery.of(context).size;
    if (this._showFullGalleryBloc.isNullPageView()) {
      this._showFullGalleryBloc.pageView = _buildPageView(context);
    }
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            this._showFullGalleryBloc.pageView,
            _buildDotIndicator(context),
          ],
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(ShowFullGallery oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (this._showFullGalleryBloc.isFirst) {
      this._showFullGalleryBloc.isFirst = false;
      this._showFullGalleryBloc.pageController.animateToPage(
            this.widget.arguments.positionSelect,
            curve: Curves.easeIn,
            duration: Duration(milliseconds: duration),
          );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      this._showFullGalleryBloc.pauseVideo();
    }
  }

  Widget _buildPageView(BuildContext context) => new PageView(
        children: _buildPageViewChildren(context),
        onPageChanged: this.onPageChanged(),
        controller: this._showFullGalleryBloc.pageController,
      );

  List<Widget> _buildPageViewChildren(BuildContext context) {
    this._showFullGalleryBloc.player = [];
    return this
        .widget
        .arguments
        .medias
        .map((Attachment media) => _renderAttach(media))
        .toList();
  }

  Widget _renderAttach(Attachment attachment) {
    if (attachment.file != null) {
      if (attachment.isImage()) {
        return ImageView.file(attachment.file);
      } else {
        VideoPlayerController controller =
            VideoPlayerController.file(attachment.file);
        VideoPlayerCustom player = VideoPlayerCustom(
          videoPlayerController: controller,
          looping: true,
//          aspectRatio: 16 / 9,
        );
        this._showFullGalleryBloc.player.add(player);
        return player;
      }
    } else if (attachment.url != null) {
      if (attachment.isImage()) {
        return ImageView.network(attachment.url,
            filterQuality: FilterQuality.medium);
      } else {
        VideoPlayerController controller =
            VideoPlayerController.network(attachment.url);
        VideoPlayerCustom player = VideoPlayerCustom(
          videoPlayerController: controller,
          looping: true,
          // aspectRatio: 16 / 9
        );
        this._showFullGalleryBloc.player.add(player);
        return player;
      }
    } else if (attachment.thumbnailData != null) {
      if (attachment.isImage()) {
        return ImageView.memory(
          attachment.thumbnailData,
          filterQuality: FilterQuality.medium,
        );
      } else {
        return Container(
          child: Text('Video thumbnail'),
        );
      }
    }
    return Container();
  }

  Widget _buildDotIndicator(BuildContext context) {
    return new Positioned(
      bottom: 20.0,
      child: StreamBuilder(
        stream: this._showFullGalleryBloc.posObserver,
        builder: (context, AsyncSnapshot<int> snapshot) {
          return new Center(
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              children: _buildDots(context),
            ),
          );
        },
      ),
      left: 0,
      right: 0,
    );
  }

  List<Widget> _buildDots(BuildContext context) {
    List<Widget> widgets = [];
    int index = 0;
    this.widget.arguments.medias.forEach((element) {
      final isSelected = index == this._showFullGalleryBloc.pos;
      var color = isSelected ? ColorsResource.primaryColor : Colors.grey;
      widgets.add(Container(
        decoration: new BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        width: 10.0,
        height: 10.0,
        margin: EdgeInsets.only(left: 3.0, right: 3.0),
      ));
      index++;
    });
    return widgets;
  }

  ValueChanged<int> onPageChanged() => (int pos) {
        this._showFullGalleryBloc.setPos(pos);
        this._showFullGalleryBloc.pauseVideo();
      };

  @override
  void dispose() {
    super.dispose();
    this._showFullGalleryBloc.dispose();
  }
}

class ShowFullMediaArguments {
  List<Attachment> medias = [];
  int positionSelect = 0;

  ShowFullMediaArguments(
      {@required this.medias, @required this.positionSelect});
}
