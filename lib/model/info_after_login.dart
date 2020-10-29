import 'auth/auth.dart';
import 'department/department.dart';
import 'personal_info/personal_info.dart';

class InfoAfterLogin {
  AuthModel authModel;
  List<DepartmentModel> departments;
  PersonalInfoModel personalInfoModel;

  InfoAfterLogin({this.authModel, this.departments, this.personalInfoModel});
}
