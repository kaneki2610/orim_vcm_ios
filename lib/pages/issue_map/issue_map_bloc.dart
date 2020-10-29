import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/config/enum_packages/map.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/base/subject.dart';

class IssueMapBloc extends BaseBloc {
  IssueMapBloc({@required BuildContext context, this.position, this.location})
      : cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: EnumMap.zoom19,
        ),
        super(context: context) {
    print('${this.position.latitude} - ${this.position.longitude}');
  }

  final Position position;
  final String location;
  final MarkerId _markerId = MarkerId('happening');
  final CameraPosition cameraPosition;
  Completer<GoogleMapController> _controller = Completer();
  Marker marker;
  
  BehaviorSubject<Marker> _markerSubject = BehaviorSubject();
  Stream<Marker> get markerStream => _markerSubject.stream;

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
  }

  @override
  void dispose() {
    _markerSubject.close();
  }

  void complete(GoogleMapController controller) {
    _controller.complete(controller);
  }

  createMarker() {
    marker = Marker(
        markerId: _markerId,
        draggable: false,
        infoWindow: InfoWindow(
            title: StringResource.getText(context, 'location_happening'),
            snippet: location),
        position: LatLng(position.latitude, position.longitude));
    _markerSubject.value = marker;
  }

  Future<void> moveToPosition() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}
