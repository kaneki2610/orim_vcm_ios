import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orim/base/page.dart';
import 'package:orim/components/circle_container.dart';
import 'package:orim/components/title_container.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/config/enum_packages/enum_area_type.dart';
import 'package:orim/config/enum_packages/map.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/entities/modal_map/area_response.dart';
import 'package:orim/model/area/area_model.dart';
import 'package:orim/pages/send_complain/modal/modal_map/modal_map_bloc.dart';
import 'package:orim/pages/send_complain/modal/modal_map/modal_map_view.dart';
import 'package:orim/utils/geocoder_utils.dart';

class ModalMap extends StatefulWidget {
  static const String routeName = 'ModalMap';

  final LatLng position;
  final String locationName;
  final CurrentProvince currentProvince;
  final CurrentDistrict currentDistrict;
  final CurrentWard currentWard;
  final Function(LatLng, String, CurrentProvince, CurrentDistrict, CurrentWard)
      callback;

  ModalMap(
      {@required this.position, @required this.locationName, @required this.currentProvince, @required this.currentDistrict, @required this.currentWard, this.callback});

  @override
  State<StatefulWidget> createState() {
    return ModalMapState();
  }
}

class ModalMapState extends BaseState<ModalMapBloc, ModalMap>
    implements ModalMapView {
  @override
  void initBloc() {
    this.bloc = ModalMapBloc(
        context: context,
        locationName: widget.locationName,
        position: widget.position,
        dis: widget.currentDistrict,
        ward: widget.currentWard,
        province: widget.currentProvince,
        view: this);
  }

  @override
  void onPostFrame() {
    this.bloc.createMarker();
    this.bloc.moveToPosition();
    this.bloc.setData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.bloc.updateDependencies(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.callback(
            this.bloc.position,
            this.bloc.locationName,
            this.bloc.currentProvince,
            this.bloc.currentDistrict,
            this.bloc.currentWard);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            title: TitleContainer(
              titleText:
                  StringResource.getText(context, 'select_location_title'),
            )),
        body: SafeArea(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 3,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: StreamBuilder(
                        stream: this.bloc.markerObserver,
                        builder: (BuildContext context,
                            AsyncSnapshot<Marker> snapshot) {
                          List<Marker> list = [];
                          if (snapshot.hasData) {
                            list.add(snapshot.data);
                          }
                          return GoogleMap(
                            mapType: MapType.normal,
                            onTap: _handleTapMap,
                            initialCameraPosition: CameraPosition(
                              target: this.bloc.position,
                              zoom: EnumMap.zoom19,
                            ),
                            markers: Set.of(list),
                            myLocationButtonEnabled: false,
                            onMapCreated: (GoogleMapController controller) {
                              this.bloc.complete(controller);
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 10.0),
                      child: InkWell(
                        onTap: _getLocationCurrent,
                        child: CircleContainer(
                          backgroundColor: Color(0xFFD80097),
                          child: Icon(Icons.my_location,
                              color: Colors.white, size: 30),
                        ),
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
//                          print('${geoLocation.position.latitude} - ${geoLocation.position.longitude}');
                            this.bloc.onUpdateLocation(geoLocation.position);
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
                                    stream: this.bloc.adressObserver,
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
              ),
              Flexible(
                  flex: 2,
                  child: Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          StreamBuilder(
                              stream: this.bloc.provincesStream,
                              builder: (context,
                                  AsyncSnapshot<CurrentProvince> snapshot) {
                                if (snapshot.hasData) {
                                  CurrentProvince provinces;
                                  provinces = snapshot.data;
                                  return this._selectAreaWidget(provinces.name,
                                      EnumFilterAreaType.filterProvince, "");
                                } else {
                                  return this._selectAreaWidget("",
                                      EnumFilterAreaType.filterProvince, "");
                                }
                              }),
                          SizedBox(height: 8),
                          StreamBuilder(
                              stream: this.bloc.districtsStream,
                              builder: (context,
                                  AsyncSnapshot<CurrentDistrict> snapshot) {
                                if (snapshot.hasData) {
                                  CurrentDistrict districts;
                                  districts = snapshot.data;
                                  return this._selectAreaWidget(districts.name,
                                      EnumFilterAreaType.filterDistrict, "");
                                } else {
                                  return this._selectAreaWidget("",
                                      EnumFilterAreaType.filterDistrict, "0");
                                }
                              }),
                          SizedBox(height: 8),
                          StreamBuilder(
                              stream: this.bloc.wardStream,
                              builder: (context,
                                  AsyncSnapshot<CurrentWard> snapshot) {
                                if (snapshot.hasData) {
                                  CurrentWard ward;
                                  ward = snapshot.data;
                                  return this._selectAreaWidget(ward.name,
                                      EnumFilterAreaType.filterWard, ward.id);
                                } else {
                                  return this._selectAreaWidget("",
                                      EnumFilterAreaType.filterWard, "0");
                                }
                              }),
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectAreaWidget(String name, String type, String id) {
    return Container(
      margin: EdgeInsets.only(
        left: DimenResource.paddingContent,
        right: DimenResource.paddingContent,
      ),
      width: double.infinity,
      height: 60.0,
      child: RaisedButton(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey[350]),
            borderRadius:
                BorderRadius.circular(DimenResource.borderRadiusButton),
          ),
          onPressed: EnumFilterAreaType.filterProvince == type
              ? null
              : () {
                  if (EnumFilterAreaType.filterDistrict == type) {
                    this.bloc.selectDistrict();
                  } else {
                    this.bloc.selectWard();
                  }
                },
          color: Colors.white,
          textColor: Colors.black,
          disabledColor: Colors.white,
          disabledTextColor: Colors.grey,
          padding: EdgeInsets.all(DimenResource.paddingInput),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                EnumFilterAreaType.filterProvince == type
                    ? name == "" ? StringResource.getText(context, "select_province") : name
                    : id == "0" && EnumFilterAreaType.filterDistrict == type  ? StringResource.getText(context, "select_ward")
                    : id == "0" && EnumFilterAreaType.filterWard == type ? StringResource.getText(context, "select_street") : name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 25,
                color: Colors.grey,
              )
            ],
          )),
    );
  }

  void _getLocationCurrent() async {
    if (await this.bloc.turnOnGPS()) {
      this.bloc.checkLocationPermissionIsNotShow().then((res) async {
        if (res) {
          this.bloc.showNoticeWhenPermissionNotGrant();
        } else {
          if (await this.bloc.requestLocationPermission()) {
            this.bloc.getCurrentLocation();
          }
        }
      });
    }
  }

  _handleTapMap(LatLng point) {
    this.bloc.onUpdateLocation(point);
  }

  @override
  void dispose() {
    this.bloc?.dispose();
    super.dispose();
  }

  @override
  Future<bool> hideLoading() async {
    await this.progressDialogLoading.hide();
    return true;
  }

  @override
  Future<bool> showLoading() async {
    await this.progressDialogLoading.show();
    return true;
  }

  @override
  void showToastWithMessage(String msg) {
    Fluttertoast.showToast(msg: StringResource.getText(context, msg));
  }
}

class ModalMapArguments {
  final LatLng position;
  final String locationName;
  final CurrentProvince currentProvince;
  final CurrentDistrict currentDistrict;
  final CurrentWard currentWard;
  final Function(LatLng, String, CurrentProvince, CurrentDistrict, CurrentWard)
      callback;

  ModalMapArguments({this.position, this.locationName, this.currentProvince, this.currentDistrict, this.currentWard, this.callback});
}
