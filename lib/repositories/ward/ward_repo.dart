import 'package:orim/model/ward.dart';

abstract class WardRepo {
  Future<List<WardModel>> getWardByCodeProvince(int codeProvince);
}