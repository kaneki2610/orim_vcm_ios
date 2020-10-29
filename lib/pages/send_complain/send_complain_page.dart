import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orim/components/attachment_component.dart';
import 'package:orim/components/raised_buttom_custom.dart';
import 'package:orim/components/title_container.dart';
import 'package:orim/config/colors_resource.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/enum_packages/enum_filter_type.dart';
import 'package:orim/config/enum_packages/map.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/entities/category/category.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/send_complain/send_complain_bloc.dart';
import 'package:orim/pages/send_complain/send_complain_view.dart';
import 'package:orim/utils/alert_dialog.dart';
import 'package:orim/utils/dialog/dialog_util.dart';
import 'package:orim/utils/gallery_storage/attachement.dart';

class SendComplainPage extends StatefulWidget {
  static const String routeName = 'SendComplainPage';
  static const String title = 'title_send_complain_page'; // key

  final SendComplainArguments arguments;

  SendComplainPage({this.arguments});

  @override
  State<StatefulWidget> createState() {
    return _SendComplainState();
  }
}

class _SendComplainState extends State<SendComplainPage>
    implements SendComplainView {
  SendComplainBloc _sendComplainBloc;
  StreamSubscription subscribe;

  @override
  void initState() {
    super.initState();
    _sendComplainBloc = SendComplainBloc(
        context: context, arguments: widget.arguments, view: this);
    SchedulerBinding.instance.addPostFrameCallback((Duration duration) async {
      this._sendComplainBloc.getCategory();
      await this._sendComplainBloc.getLocationCurrent();
    });
  }

  void showMap() async {
    _sendComplainBloc.loadInfoSender();
    if (_sendComplainBloc.canContinue) {
      _sendComplainBloc.next();
    } else {
      await _sendComplainBloc.initLocation();
      if (_sendComplainBloc.mapIsReady) {
        _sendComplainBloc.moveToPosition();
      } else {
        if (subscribe == null) {
          subscribe = _sendComplainBloc.listenMapIsReady((bool isReady) {
            _sendComplainBloc.moveToPosition();
          });
        }
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sendComplainBloc.updateDependencies(context);
    if (_sendComplainBloc.canContinue) {
      SchedulerBinding.instance.addPostFrameCallback((Duration duration) async {
        if (_sendComplainBloc.mapIsReady) {
          _sendComplainBloc.moveToPosition();
        } else {
          if (subscribe == null) {
            subscribe = _sendComplainBloc.listenMapIsReady((bool isReady) {
              _sendComplainBloc.moveToPosition();
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleContainer(
          titleText: StringResource.getText(context, SendComplainPage.title),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(DimenResource.paddingContent),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _categories(),
                _contentComplain(),
                _contentLocation(),
                _attachments(),
                RaisedButtonCustom(
                    text: StringResource.getText(context, 'send_complain'),
                    onPressed: () {
                      if (_sendComplainBloc.checkDataIsValid()) {
                        _sendComplainBloc.sendComplain();
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contentComplain() {
    return Column(
      children: <Widget>[
        TitleContainer(
          titleText: StringResource.getText(context, 'content'),
          titleColor: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: DimenResource.textTitleSize,
        ),
        Container(
          height: 10,
        ),
        StreamBuilder(
          stream: _sendComplainBloc.contentStream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextField(
              controller: _sendComplainBloc.contentController,
              focusNode: _sendComplainBloc.contentFocusNode,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: StringResource.getText(context, 'content_hint_text'),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                errorText: snapshot.hasError ? snapshot.error : null,
              ),
            );
          },
        ),
        Container(
          height: DimenResource.paddingContent,
        ),
      ],
    );
  }

  Widget _contentLocation() {
    return Column(
      children: <Widget>[
        TitleContainer(
          titleText: StringResource.getText(context, 'location'),
          titleColor: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: DimenResource.textTitleSize,
        ),
        Container(
          height: 5,
        ),
        InkWell(
          onTap: _sendComplainBloc.showModalMap,
          child: Container(
            margin: EdgeInsets.only(top: 5.0),
            padding: EdgeInsets.all(DimenResource.paddingContent),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: StreamBuilder(
              stream: _sendComplainBloc.locationObserver,
              builder: (context, snapshot) => Container(
                width: double.infinity,
                child: Text(snapshot.hasData
                    ? snapshot.data == EnumFilterType.isEnableGPS
                        ? StringResource.getText(context, "search_issue")
                        : snapshot.data
                    : StringResource.getText(context, 'unknow_location')),
              ),
            ),
          ),
        ),
        Container(
          height: 10,
        ),
        Container(
          height: 200,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                child: StreamBuilder(
                  stream: _sendComplainBloc.markerObserver,
                  builder: (BuildContext context, snapshot) {
                    return GoogleMap(
                      mapType: MapType.normal,
                      compassEnabled: false,
                      mapToolbarEnabled: false,
                      rotateGesturesEnabled: false,
                      scrollGesturesEnabled: false,
                      zoomGesturesEnabled: false,
                      tiltGesturesEnabled: false,
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: false,
                      initialCameraPosition: CameraPosition(
                        target: _sendComplainBloc.position.value,
                        zoom: EnumMap.zoom19,
                      ),
                      markers:
                          snapshot.hasData ? Set.from(snapshot.data) : null,
                      onMapCreated: (GoogleMapController controller) {
                        _sendComplainBloc.complete(controller);
                      },
                    );
                  },
                ),
              ),
              InkWell(
                onTap: _sendComplainBloc.showModalMap,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                ),
              )
            ],
          ),
        ),
        Container(
          height: 20,
        ),
      ],
    );
  }

  Widget _categories() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TitleContainer(
              titleText: StringResource.getText(context, 'field'),
              titleColor: Theme.of(context).primaryColor,
              fontSize: DimenResource.textTitleSize,
            ),
            StreamBuilder(
              stream: _sendComplainBloc.categoryObserver,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return InkWell(
                    onTap: () => _sendComplainBloc.showModalField(),
                    child: Row(
                      children: <Widget>[
                        Text(
                          StringResource.getText(context, 'edit'),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.edit,
                            color: Theme.of(context).primaryColor,
                            size: 15,
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
        StreamBuilder(
          stream: _sendComplainBloc.categoryObserver,
          builder:
              (BuildContext context, AsyncSnapshot<CategoryData> snapshot) {
            if (snapshot.hasData) {
              final CategoryData category = snapshot.data;
//              return Row(
//                mainAxisSize: MainAxisSize.min,
//                children: <Widget>[
//                  Container(
//                    padding: const EdgeInsets.symmetric(
//                        horizontal: 10.0, vertical: 5.0),
//                    decoration: BoxDecoration(
//                      color: Theme.of(context).primaryColor,
//                      borderRadius: BorderRadius.all(
//                        Radius.circular(50.0),
//                      ),
//                    ),
//                    child: Row(
//                      children: <Widget>[
//                        Text(
//                          category.name.toUpperCase(),
//                          style: const TextStyle(
//                            color: ColorsResource.textColorButton,
//                            fontSize: 15.0,
//                            fontWeight: FontWeight.bold,
//                          ),
//                        ),
//                        Container(
//                          margin: const EdgeInsets.only(left: 10.0),
//                          padding: const EdgeInsets.symmetric(
//                              horizontal: 10.0, vertical: 5.0),
//                          child: Text(
//                            '${category.subCategories[0].name.toUpperCase()}',
//                            style: TextStyle(
//                              color: Theme.of(context).primaryColor,
//                              fontSize: 14.0,
//                            ),
//                            overflow: TextOverflow.ellipsis,
//                          ),
////                          color: Theme.of(context).accentColor,
//                          decoration: BoxDecoration(
//                            color: Colors.white,
//                            borderRadius: BorderRadius.all(
//                              Radius.circular(50.0),
//                            ),
//                          ),
//                        )
//                      ],
//                    ),
//                  )
//                ],
//              );
              return Container(
                margin: EdgeInsets.only(
                  top: DimenResource.paddingContent,
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
                child: Text(
                  this._sendComplainBloc.isSelectedCategoryItem
                      ? '${category.name.toUpperCase()} - ${category.subCategories[0].name}'
                      : '${category.name.toUpperCase()}',
                  style: TextStyle(
                    color: ColorsResource.textColorButton,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              return RaisedButtonCustom(
                onPressed: () => _sendComplainBloc.showModalField(),
                text: StringResource.getText(context, 'select_field'),
              );
            }
          },
        ),
        Container(
          height: DimenResource.paddingContent,
        ),
      ],
    );
  }

  Widget _attachments() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TitleContainer(
              titleText:
                  StringResource.getText(context, 'image_video_attachments'),
              titleColor: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: DimenResource.textTitleSize,
            ),
            InkWell(
//              onTap: () => _sendComplainBloc.showModalAttachments(),
              onTap: _openModalAttachmentOptions,
              child: Row(
                children: <Widget>[
                  Text(
                    StringResource.getText(context, 'add_attachments'),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                      size: 15,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Container(
          height: 10,
        ),
        StreamBuilder(
          stream: _sendComplainBloc.attachmentsObserver,
          builder: (context, AsyncSnapshot<List<Attachment>> snapshot) {
            if (snapshot.hasData && snapshot.data.length > 0) {
              return Container(
                height: 80.0,
                width: double.infinity,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Container(
                      width: (MediaQuery.of(context).size.width - 5) * 0.23,
                      height: (MediaQuery.of(context).size.width - 5) * 0.23,
                      child: AttachmentComponent(
                        attachment: snapshot.data[index],
                        onPress: () =>
                            _sendComplainBloc.onTapMedia(snapshot.data[index]),
                        icon: Wrap(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () => _sendComplainBloc
                                    .removeAttachment(snapshot.data[index]),
                                child: Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: DimenResource.padding5,
                    );
                  },
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.horizontal,
                ),
              );
            } else {
              return Container(
                child: Center(
                  child:
                      Text(StringResource.getText(context, 'no_attachments')),
                ),
              );
            }
          },
        ),
        Container(
          height: 20,
        ),
      ],
    );
  }

  void _openModalAttachmentOptions() {
    DialogUtil().showModalAttachmentOptions(
        context,
        openCameraCallback: this._sendComplainBloc.openCameraView,
        openVideoViewCallBack: this._sendComplainBloc.openVideoView,
        openGalleryCallback: this._openModalAttachments,
        openVideoCallback: () {
          this._sendComplainBloc.openVideoMemory();
        }
    );
  }

  _openModalAttachments() async {
    if (NavigatorService.back(context)) {
      _sendComplainBloc.showModalAttachments();
    }
  }

  @override
  void dispose() {
    _sendComplainBloc?.dispose();
    subscribe?.cancel();
    super.dispose();
  }

  @override
  void showToastWithMessage(String msg) {
    Fluttertoast.showToast(msg: StringResource.getText(context, msg));
  }

  @override
  void isEnableGPS() {
    this.showMap();
  }
}

class SendComplainArguments {
  bool gotoPhotoLibrary;
  bool openCameraView;
  bool openVideoView;
  bool openVideoMemory;
  bool gotoCategories;
  CategoryData categoryData;

  SendComplainArguments(
      {this.gotoPhotoLibrary = false,
      this.openCameraView = false,
      this.openVideoView = false,
      this.openVideoMemory = false,
      this.gotoCategories = false,
      this.categoryData});
}
