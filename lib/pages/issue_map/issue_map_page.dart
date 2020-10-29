import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/pages/issue_map/issue_map_bloc.dart';

class IssueMapPage extends StatefulWidget {
  static const routeName = 'IssueMapPage';

  final IssueMapPageArguments arguments;

  const IssueMapPage({@required this.arguments});

  @override
  State<StatefulWidget> createState() {
    return _IssueMapState();
  }
}

class _IssueMapState extends State<IssueMapPage> {
  IssueMapBloc _bloc;

  @override
  void initState() {
    _bloc = IssueMapBloc(
        context: context,
        position: widget.arguments.position,
        location: widget.arguments.location);
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
      _bloc.createMarker();
      _bloc.moveToPosition();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc.updateDependencies(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Text(StringResource.getText(context, "issue_administration_detail_location"))
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: StreamBuilder(
            stream: _bloc.markerStream,
            builder: (context, AsyncSnapshot<Marker> snapshot) {
              List<Marker> list = [];
              if (snapshot.hasData) {
                list.add(snapshot.data);
              }
              return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _bloc.cameraPosition,
                myLocationButtonEnabled: false,
                markers: Set.from(list),
                onMapCreated: (GoogleMapController controller) {
                  _bloc.complete(controller);
                },
              );
            },
          ),
        ));
  }
}

class IssueMapPageArguments {
  String location;
  Position position;

  IssueMapPageArguments({this.location, this.position});
}
