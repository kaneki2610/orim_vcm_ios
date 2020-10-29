import 'package:orim/base/base_reponse.dart';
import 'package:orim/entities/signin/sign_in_request.dart';
import 'package:orim/entities/signin/sign_in_response.dart';
import 'package:orim/entities/logout/logout_request.dart';
import 'package:orim/entities/logout/logout_response.dart';

abstract class AuthRemote {
  Future<ResponseObject<SignInModel>> login({SignInRequest request});
  Future<LogoutResponse> logout({LogoutRequest request, String token });
}