import 'dart:convert';

import 'package:http/http.dart';
import 'package:orim/entities/province/province_request.dart';
import 'package:orim/entities/province/province_response.dart';
import 'package:orim/model/province.dart';
import 'package:orim/repositories/province/province_repo.dart';
import 'package:orim/utils/api_service.dart';

class ProvinceImp implements ProvinceRepo {

  final String subURL = 'kong/api/masterdata/v1/area/getListAreaByType';
  ApiService apiService;

  @override
  Future<List<ProvinceModel>> getProvinces() async {
    ProvinceRequest request = ProvinceRequest();
    Response response = await apiService.post(subURL, data: request.toJson());
    if (response.statusCode >= 200 && response.statusCode < 300) {
      ProvinceResponse provinceResponse =
          ProvinceResponse.fromJson(json.decode(response.body));
      if (provinceResponse.error == 0) {
        return provinceResponse.list
            .map((item) => ProvinceModel(code: item.code, name: item.name))
            .toList();
      } else {
        throw provinceResponse.msg;
      }
    } else {
      throw response.statusCode;
    }
  }
}
