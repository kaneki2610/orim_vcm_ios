import 'package:flutter/cupertino.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/viewmodel/resident_info.dart';
import 'package:orim/viewmodel/user_info.dart';
import 'package:provider/provider.dart';
import 'package:orim/base/subject.dart';

class ModalInfoBloc extends BaseBloc {
  ModalInfoBloc({BuildContext context}) : super(context: context);

  UserInfoViewModel _userInfoViewModel;
  ResidentInfoViewModel _residentInfoViewModel;

  TextEditingController nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  BehaviorSubject<String> _errorName = BehaviorSubject<String>();

  Stream<String> get errorName => _errorName.stream;

  TextEditingController phoneController = TextEditingController();
  FocusNode phoneFocusNode = FocusNode();
  BehaviorSubject<String> _errorPhone = BehaviorSubject<String>();

  Stream<String> get errorPhone => _errorPhone.stream;

  @override
  void dispose() {
    _errorName.close();
    _errorPhone.close();
  }

  Future<bool> submit() async {
    String name = nameController.value.text;
    String phone = phoneController.value.text;
    bool res = true;
    if (name.length == 0) {
      _errorName.addError(StringResource.getText(context, 'name_blank'));
      res = res && false;
    } else {
      _errorName.value = '';
    }
    if (phone.length == 0) {
      _errorPhone.addError(StringResource.getText(context, 'phone_blank'));
      res = res && false;
    } else {
      _errorPhone.value = '';
    }
    if (res) {
      bool isSaveInfoSuccess = false;
      isSaveInfoSuccess =
          await this._userInfoViewModel.saveInfo(name, "", phone, "", "");
      bool isSaved = await this._residentInfoViewModel.saveInfoResident(name, "", phone, "", "");
      print("Saved:" + isSaved.toString());
      if (isSaveInfoSuccess) {
        this._userInfoViewModel.createUserAccount(phone, name, this.helperViewModel.appConfigModel.areaCodeCurrent, false);
      }
    }
    return res;
  }

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    _userInfoViewModel = Provider.of<UserInfoViewModel>(context);
    _residentInfoViewModel = Provider.of<ResidentInfoViewModel>(context);
  }

  bool back() {
    return NavigatorService.back(context);
  }
}
