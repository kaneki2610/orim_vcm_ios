
import 'package:orim/base/base_reponse.dart';
import 'package:orim/model/marker.dart';
import 'package:orim/repositories/marker/marker_repo.dart';
import 'package:orim/storage/marker/remote/marker_remote_imp.dart';

class MarkerImp implements MarkerRepo{
  MarkerRemoteImp markerRemoteImp;
  @override
  Future<ResponseListNew<MarkerModel>> getListMarker({String token, String areaCode, String fromDate, String toDate}) async {
    ResponseListNew<MarkerModel> issues =
        await markerRemoteImp.getListMarker(token: token, areaCode: areaCode, toDate: toDate, fromDate: fromDate);
    return issues;
  }

}