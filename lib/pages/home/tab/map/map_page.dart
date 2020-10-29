import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/circle_container.dart';
import 'package:orim/components/container_appbar.dart';
import 'package:orim/components/drawer_toggle.dart';
import 'package:orim/components/loading.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/enum_packages/map.dart';
import 'package:orim/config/imgs_resource.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/entities/category/category.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/pages/home/tab/map/map_bloc.dart';
import 'package:orim/utils/alert_dialog.dart';
import 'package:orim/utils/dialog/dialog_util.dart';
import 'package:orim/utils/gallery_storage/gallery_storage.dart';
import 'package:orim/utils/widget/widget.dart';

class MapPage extends StatefulWidget {
  static const String routeName = 'home_tab';

  const MapPage();

  @override
  State<StatefulWidget> createState() {
    return _MapPageState();
  }
}

class PointObject {
  final Widget child;
  final LatLng location;

  PointObject({this.child, this.location});
}

class _MapPageState extends BaseState<MapBloc, MapPage>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin<MapPage> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void initBloc() {
    bloc = MapBloc(context: context);
  }

  @override
  void onPostFrame() async {
    bloc.getListMarkers();
    bloc.getList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.updateDependencies(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      this.bloc.onMoveCamera();
    }
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }

  @override
  void updateKeepAlive() {}

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(bottom: 10.0, left: 10.0),
            child: ImageView.asset(
              ImageResource.logo,
              color: Theme
                  .of(context)
                  .primaryColor,
              scale: 1.5,
            ),
          ),
          Flexible(
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: StreamBuilder(
                        stream: bloc.markerStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Marker>> snapshot) {
                          return GoogleMap(
                            initialCameraPosition: this.bloc.kGooglePlex,
                            markers: Set.of(this.bloc.markers),
                            onMapCreated: (controller) {
                              bloc.complete(controller);
                            },
                            onCameraMove: (newPosition) {
                              this.bloc.onMoveCamera();
                            },
                            zoomControlsEnabled: false,
                            mapToolbarEnabled: false,
                            myLocationButtonEnabled: false,
                          );
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: this._openModalAttachmentOptions,
                            child: CircleContainer(
                              backgroundColor: Color(0xFF02DAE9),
                              child:
                              Icon(Icons.camera_alt, color: Colors.white, size: 20.0),
                            ),
                          ),
                          InkWell(
                            onTap: bloc.refresh,
                            child: CircleContainer(
                              backgroundColor: Color(0xFF0293E9),
                              padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                              child: Icon(Icons.refresh, color: Colors.white, size: 20.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          Container(
            height: 70,
            margin: EdgeInsets.only(bottom: 10, top: 10),
            child: StreamBuilder(
              stream: bloc.categoriesStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<CategoryData>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Container(width: 10),
                    itemBuilder: (BuildContext context, int index) =>
                        InkWell(
                          onTap: () {
                            this.bloc.gotoSendComplain(snapshot.data[index]);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Column(
                              children: <Widget>[
                                ImageView.network(
                                  snapshot.data[index].icon,
                                  height: 50,
                                  width: 50,
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                ),
                                Text(snapshot.data[index].name)
                              ],
                            ),
                          ),
                        ),
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Container(
                    child: RaisedButton(
                      onPressed: bloc.getList,
                      color: Theme
                          .of(context)
                          .primaryColor,
                      textColor: Colors.white,
                      child: Text(StringResource.getText(context, 'try_again')),
                    ),
                  );
                } else {
                  return Container(
                    child: Center(
                      child: Loading(),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _openModalAttachmentOptions() {
    DialogUtil().showModalAttachmentOptions(
        context,
        openCameraCallback: () {
          this.bloc.gotoAttachmentsPicker(AssetType.camera);
        },
        openVideoViewCallBack: () {
          this.bloc.gotoAttachmentsPicker(AssetType.video);
        },
        openGalleryCallback: () {
          this.bloc.gotoAttachmentsPicker(AssetType.image);
        }
    );
  }

  @override
  get isLightStatus => false;
}

class MapPageTabbar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const MapPageTabbar({
    Key key,
    this.height = DimenResource.heightTabbar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerAppbar(
      isLightStatus: false,
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: DrawerToggle(
          iconColor: Colors.grey,
        ),
        title: Container(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () => NavigatorService.gotoSignIn(context),
            child: Container(
              alignment: Alignment.centerRight,
              height: DimenResource.heightButton - 10,
              width: DimenResource.heightButton * 3.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageResource.button_login_background),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Text(
                  StringResource.getText(context, 'login').toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
