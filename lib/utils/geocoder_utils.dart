import 'package:flutter/cupertino.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:orim/config/strings_resource.dart';

class GeocoderUtils {
  static const _kGoogleApiKey = "AIzaSyBNsEPj9AAhs5hbXz2_tFMe-4pZt91fOzo";

  static Future<String> getAddressLine(LatLng position) async {
    try {
      final coordinates = new Coordinates(
          position.latitude, position.longitude);
      List<Address> addresses =
      await Geocoder.local.findAddressesFromCoordinates(coordinates);
//      print(addresses.length);
      if (addresses.length > 0) {
        Address address = addresses.first;
//        print('address.addressLine ${address.addressLine}');
        return address.addressLine;
      }
      return "Unknown";
    } catch (err) {
      throw err;
    }
  }

  static Future<GeoLocation> findLocation(BuildContext context) async {
    Prediction prediction;
    try {
      prediction = await PlacesAutocomplete.show(
          context: context,
          apiKey: _kGoogleApiKey,
          mode: Mode.overlay,
          // Mode.fullscreen
          language: "vi",
          components: [new Component(Component.country, "vn")],
          hint: StringResource.getText(context, 'input_search_location')
      );
    } catch (err) {
      print('PlacesAutocompleteErr ${err}');
    }
    if (prediction != null) {
      print('${prediction.id} - ${prediction.description} - ${prediction
          .structuredFormatting.secondaryText}');
      return GeoLocation(
        description: prediction.description,
        position: await getLatLngByPlaceId(prediction.placeId)
      );
    }
    return null;
  }

  static Future<LatLng> getLatLngByPlaceId(String placeId) async {
    final places = new GoogleMapsPlaces(apiKey: _kGoogleApiKey);
    PlacesDetailsResponse response = await places.getDetailsByPlaceId(placeId);
    Location location = response?.result?.geometry?.location;
    if (location != null) {
      LatLng position = LatLng(location.lat, location.lng);
      return position;
    } else {
      throw 'not found LatLng by place_id - $placeId';
    }
  }
}

class GeoLocation {
  String description;
  LatLng position;

  GeoLocation({ this.description, this.position });
}
