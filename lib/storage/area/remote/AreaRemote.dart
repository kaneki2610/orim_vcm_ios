import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/modal_map/area_response.dart';
import 'package:orim/model/area/area_model.dart';

abstract class AreaRemote {
  Future<ResponseObject<AreaModel>> getArea ({String latlng, String name});
}