
import 'package:orim/entities/change_password/change_pass_response.dart';

abstract class ChangePassRepo {
  Future<bool> changePassword ({String password, String token});
}