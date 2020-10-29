import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:orim/model/ward.dart';
import 'package:orim/repositories/ward/ward_repo.dart';
import 'package:orim/utils/api_service.dart';
import 'package:orim/entities/ward/ward_request.dart';
import 'package:orim/entities/ward/ward_response.dart';

class WardImp implements WardRepo {

  ApiService apiService;
  final String subURL = 'kong/api/masterdata/v1/area/getListAreaByTypeAndParentCode';

  @override
  Future<List<WardModel>> getWardByCodeProvince(int codeProvince) async {
    WardRequest request = WardRequest(parentcode: codeProvince);
    Response response = await apiService.post(subURL, data: request.toJson());
    if (response.statusCode >= 200 && response.statusCode < 300) {
      WardResponse wardResponse = WardResponse.fromJson(json.decode(response.body));
      return wardResponse.list.map((e) {
        return WardModel(id: e.id, code: e.code, name: e.name, parentCode: e.parentCode, areaCode: e.areaCode);
      }).toList();
    } else {
      throw response.statusCode;
    }
  }

}