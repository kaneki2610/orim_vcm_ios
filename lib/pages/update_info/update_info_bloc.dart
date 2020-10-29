import 'package:flutter/cupertino.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/navigator_service.dart';
import 'package:orim/viewmodel/resident_info.dart';
import 'package:orim/viewmodel/splash.dart';
import 'package:orim/viewmodel/user_info.dart';
import 'package:provider/provider.dart';
import 'package:orim/base/subject.dart';

class UpdateInfoBloc extends BaseBloc {
  UpdateInfoBloc({@required BuildContext context}) : super(context: context);

  UserInfoViewModel _userInfo;
  ResidentInfoViewModel _residentInfoViewModel;
  SplashViewModel _splashViewModel;

  TextEditingController nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();

  TextEditingController identifyController = TextEditingController();
  FocusNode identifyFocusNode = FocusNode();

  TextEditingController phoneController = TextEditingController();
  FocusNode phoneFocusNode = FocusNode();

  TextEditingController enterpriseController = TextEditingController();
  FocusNode enterpriseFocusNode = FocusNode();

  TextEditingController addressController = TextEditingController();
  FocusNode addressFocusNode = FocusNode();

  BehaviorSubject<String> _errorName = BehaviorSubject<String>();
  BehaviorSubject<String> _errorIdentify = BehaviorSubject<String>();
  BehaviorSubject<String> _errorPhone = BehaviorSubject<String>();
  BehaviorSubject<String> _errorEnterprise = BehaviorSubject<String>();

  Stream<String> get errorName => _errorName.stream;

  Stream<String> get errorIdentify => _errorIdentify.stream;

  Stream<String> get errorPhone => _errorPhone.stream;

  Stream<String> get errorEnterprise => _errorEnterprise.stream;

  Future<bool> updateInfo() async {
    bool isSuccess = false;
    if (this._dataIsValid()) {
      String name = nameController.text;
      String id = identifyController.text;
      String phone = phoneController.text;
      String enterprise = enterpriseController.text;
      String address = addressController.text;

      bool isUpdateInfoSuccess = false;
      isUpdateInfoSuccess =
          await this._residentInfoViewModel.saveInfoResident(name, id, phone, enterprise, address);
      if (isUpdateInfoSuccess) {
        this._userInfo.createUserAccount(phone, name, this.helperViewModel.appConfigModel.areaCodeCurrent, false);
        isSuccess = true;
      }
    }
    return isSuccess;
  }

  bool _dataIsValid() {
    String name = nameController.text;
    String phone = phoneController.text;
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

//    if (enterprise.length == 0) {
//      _errorEnterprise
//          .addError(StringResource.getText(context, 'enterprise_blank'));
//      res = res && false;
//    } else {
//      _errorEnterprise.value = '';
//    }

    return res;
  }

  @override
  void dispose() {
    nameController.dispose();
    nameFocusNode.dispose();
    identifyController.dispose();
    identifyFocusNode.dispose();
    phoneController.dispose();
    phoneFocusNode.dispose();
    enterpriseController.dispose();
    enterpriseFocusNode.dispose();
    addressController.dispose();
    addressFocusNode.dispose();
    _errorName.close();
    _errorIdentify.close();
    _errorPhone.close();
    _errorEnterprise.close();
  }

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    _userInfo = Provider.of<UserInfoViewModel>(context);
    _residentInfoViewModel = Provider.of<ResidentInfoViewModel>(context);
    _splashViewModel = Provider.of<SplashViewModel>(context);
  }

  void gotoHome() {
    NavigatorService.gotoHome(context);
  }

  Future<void> userIsReadIntro() async {
    await _splashViewModel.setUserReadIntro();
  }
}
