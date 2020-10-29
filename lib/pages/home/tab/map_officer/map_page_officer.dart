import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/circle_container.dart';
import 'package:orim/components/container_appbar.dart';
import 'package:orim/components/drawer_toggle.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/enum_packages/map.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/pages/home/tab/map_officer/map_bloc_officer.dart';
import 'package:orim/utils/alert_dialog.dart';
import 'package:orim/utils/dialog/dialog_util.dart';
import 'package:orim/utils/gallery_storage/gallery_storage.dart';
import 'package:orim/utils/geocoder_utils.dart';

class MapOfficerPage extends StatefulWidget {
  static const String routeName = 'home_tab';

  const MapOfficerPage();

  @override
  State<StatefulWidget> createState() {
    return _MapOfficerPageState();
  }
}

class _MapOfficerPageState extends BaseState<MapBlocOfficer, MapOfficerPage>
    with AutomaticKeepAliveClientMixin<MapOfficerPage> {
  ScrollController scrollController = ScrollController();

  @override
  get isLightStatus => false;

  @override
  void initBloc() {
    bloc = MapBlocOfficer(context: context);
  }

  @override
  void onPostFrame() async {
    bloc.getListMarkers();
    await bloc.getList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.updateDependencies(context);
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
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: StreamBuilder(
              stream: bloc.markerStream,
              builder: (BuildContext context, AsyncSnapshot<List<Marker>> snapshot) {
                print("seto kai ba");
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
                    child: Icon(Icons.camera_alt, color: Colors.white, size: 20.0),
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
                InkWell(
                  onTap: bloc.gotoSendComplain,
                  child: CircleContainer(
                    padding: EdgeInsets.only(top: 10.0),
                    backgroundColor: Colors.redAccent,
                    child: Icon(Icons.near_me, color: Colors.white, size: 20.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            width: double.infinity,
            color: Colors.white,
            margin: EdgeInsets.only(
              left: DimenResource.paddingContent,
              right: DimenResource.paddingContent,
              top: DimenResource.paddingContent,
            ),
            child: Material(
              elevation: 5.0,
              child: InkWell(
                onTap: () async {
                  GeoLocation geoLocation =
                  await GeocoderUtils.findLocation(context);
                  if(geoLocation != null){
                    this.bloc.onUpdateLocation(geoLocation.position);

                  }
                },
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(
                      right: DimenResource.paddingContent),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(Icons.location_on,
                            color: Colors.black),
                        padding: EdgeInsets.only(
                            left: DimenResource.paddingContent,
                            right: DimenResource.paddingContent),
                      ),
                      Expanded(
                        child: StreamBuilder(
                          stream: this.bloc.addressObserver,
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            return Text(
                              snapshot.hasData
                                  ? snapshot.data
                                  : StringResource.getText(context,
                                  'input_search_location'),
                              style: TextStyle(
                                  color: snapshot.hasData
                                      ? Colors.black
                                      : Colors.grey),
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              maxLines: 1,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
        },
        openVideoCallback: () {
          this.bloc.gotoAttachmentsPicker(AssetType.video_memory);
        }
    );
  }
}

class MapOfficerTabbar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const MapOfficerTabbar({
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
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
