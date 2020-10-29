
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/modal_map/area_response.dart';
import 'package:orim/model/area/area_model.dart';
import 'package:orim/repositories/area/area_repo.dart';
import 'package:orim/storage/area/remote/AreaRemote.dart';

class AreaImpRepo implements AreaRepo {
  AreaRemote areaRemote;
  @override
  Future<ResponseObject<AreaModel>> getArea({String latlng, String name}) async {
    ResponseObject<AreaModel> areaResponse = await areaRemote.getArea(latlng: latlng, name: name);
    return areaResponse;
  }
}