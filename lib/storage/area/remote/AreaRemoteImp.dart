import 'dart:convert';

import 'package:http/http.dart';
import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/modal_map/area_request.dart';
import 'package:orim/entities/modal_map/area_response.dart';
import 'package:orim/model/area/area_model.dart';
import 'package:orim/storage/area/remote/AreaRemote.dart';
import 'package:orim/utils/api_service.dart';

class AreaRemoteImp implements AreaRemote {
  ApiService apiService;
  final String _urlGetArea =
      'kong/api/masterdata/v1/area/getAreaFullTextNewFormat';

  @override
  Future<ResponseObject<AreaModel>> getArea(
      {String latlng, String name}) async {
    AreaRequest areaRequest = AreaRequest(latlng: latlng, name: name);
    Response response;
    try {
      response = await apiService.post(_urlGetArea, data: areaRequest.toJson());
      AreaResponse res = AreaResponse.fromJson(json.decode(response.body));
      return res;
    } catch (err) {
      return ResponseObject.initDefault();
    }
  }
}
