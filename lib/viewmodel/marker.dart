
import 'package:orim/base/base_reponse.dart';
import 'package:orim/base/viewmodel.dart';
import 'package:orim/config/cert.dart';
import 'package:orim/model/auth/auth.dart';
import 'package:orim/model/marker.dart';
import 'package:orim/repositories/auth/auth_repo.dart';
import 'package:orim/repositories/marker/marker_repo.dart';
import 'package:orim/utils/time_util.dart';

class MarkerViewModel extends BaseViewModel<List<MarkerModel>> {

  MarkerRepo markerRepo;
  AuthRepo authRepo;

  Future<ResponseListNew<MarkerModel>> getMarkers() async {
    AuthModel authModel = await authRepo.getAuth();
    String token = (authModel == null ? Cert.superToken : authModel.token);
    DateTime time = new DateTime.now();
    DateTime to = new DateTime(time.year, time.month, time.day + 1);
    DateTime from = new DateTime(time.year, time.month - 1, 1);
    var areaCode = "3";
    ResponseListNew<MarkerModel> res = await markerRepo.getListMarker(token: token, areaCode: areaCode, toDate: TimeUtil.formatYYYYMMDD(to), fromDate: TimeUtil.formatYYYYMMDD(from));
    return res;
  }
}