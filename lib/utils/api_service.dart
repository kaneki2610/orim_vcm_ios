import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:orim/config/app_config.dart';
import 'package:orim/observer/force_logout.dart';
import 'package:random_string/random_string.dart';

const Map<String, String> _headerDefault = {"Content-Type": "application/json"};

class ApiService {
  ForceLogoutObserver logoutObserver;
  static String _domain = AppConfig.DOMAIN_API;
  final int timeout = 15;
  final int noTimeout = 90;

  Future<http.Response> get(String subURL,
      {Map<String, String> headers = _headerDefault, bool isTimeout = true}) async {
//    print('url $_domain$subURL');
    final headersAPI = {
      ..._headerDefault,
      ...headers,
    };
    print('header ${json.encode(headersAPI)}');
    print('url $_domain$subURL');
    return await http.get('$_domain$subURL', headers: headersAPI).timeout(Duration(seconds: isTimeout ? this.timeout: this.noTimeout));
  }

  Future<http.Response> post(String subURL,
      {Map<String, String> headers = _headerDefault,
      dynamic data,
      Encoding encoding, bool isTimeout = true}) async {
    final headersAPI = {
      ..._headerDefault,
      ...headers,
    };
    print('header ${json.encode(headersAPI)}');
    print('body ${json.encode(data)}');
    print('url $_domain$subURL');
    return await http.post('$_domain$subURL',
        headers: headersAPI, body: json.encode(data)).timeout(Duration(seconds: isTimeout ? this.timeout: this.noTimeout));
  }

  Future<http.Response> uploadFile(
      String subURL, File file, Map<String, String> data, Function(int, int) listener) async {
    final listString = file.path.split('/');
    final fileName = listString[listString.length - 1];
    final name = fileName.split('.').length > 0 ? fileName.split('.')[0] : randomString(20);
    String endpoint = _domain + subURL + name;
    Uri uri = Uri.parse(endpoint);
    http.MultipartRequest request = http.MultipartRequest(
        'POST',
        uri
    );
    request.headers.addAll(Map.from({
      'Content-Type': 'multipart/form-data; boundary=----WebKitFormBoundaryuL67FWkv1CA',
    }));
    request.fields.addAll(data);
    request.files.add(
        await http.MultipartFile.fromPath(
            'data', file.path, filename: name
        )
    );
    StreamSubscription<http.StreamedResponse> subcriptionResponse;
    StreamSubscription<List<int>> streamChunk;
    int progress = 0;
    try {
      Future<http.StreamedResponse> futureResponse = request.send();
      http.StreamedResponse response = await futureResponse;
      http.Response res = await http.Response.fromStream(response);
      subcriptionResponse?.cancel();
      streamChunk?.cancel();
      return res;
    } catch(e) {
      throw (e);
    } finally {
      subcriptionResponse?.cancel();
      streamChunk?.cancel();
    }

  }
}
