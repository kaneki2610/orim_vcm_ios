
import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/marker.dart';

abstract class MarkerRepo {

  Future<ResponseListNew<MarkerModel>> getListMarker({String token, String areaCode, String fromDate, String toDate});
}