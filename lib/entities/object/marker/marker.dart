import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:orim/entities/object/contact/contact.dart';
part 'marker.g.dart';

@JsonSerializable()
class Marker {
    Marker();

    String areadetail;
    Contact contact;
    String content;
    String createdOn;
    String location;
    num status;
    String updatedOn;
    
    factory Marker.fromJson(Map<String,dynamic> json) => _$MarkerFromJson(json);
    Map<String, dynamic> toJson() => _$MarkerToJson(this);

    Position get position {
        final List<String> stringPosition = location.split(',');
        if (stringPosition.length == 2) {
            final double latitude = double.parse(stringPosition[0]);
            final double longitude = double.parse(stringPosition[1]);
            Position postition = Position(latitude: latitude, longitude: longitude);
            return postition;
        } else {
            throw ('error $location');
        }
    }
}

