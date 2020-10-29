import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orim/base/subject.dart';
import 'package:orim/base/bloc.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/user_info_data/user_info_data.dart';
import 'package:orim/viewmodel/resident_info.dart';
import 'package:orim/viewmodel/user_info.dart';
import 'package:provider/provider.dart';

class InfoBloc extends BaseBloc {
  bool isBack = false;
  InfoBloc({BuildContext context, this.isBack = false}) : super(context: context);

  UserInfoViewModel _userInfo;
  ResidentInfoViewModel _residentInfoViewModel;

  StreamSubscription<UserInfoData> _streamSubscription;
  StreamSubscription<ResidentInfoData> _streamResidentSubscription;

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

  loadData() {
//    _userInfo.loadData();
    _residentInfoViewModel.loadDataResident();
    _streamResidentSubscription = _residentInfoViewModel.listener(
        onDataChange: onDataChange,
        onDone: () => {'Done'},
        onError: (err) => print(err));
  }

  onDataChange(ResidentInfoData userData) {
    nameController.text = userData.name;
    identifyController.text = userData.identify;
    phoneController.text = userData.phone;
    enterpriseController.text = userData.enterprise;
    addressController.text = userData.address;
  }

  Future<bool> saveInfo() async {
    bool isSuccess = false;
    String name = nameController.text;
    String id = identifyController.text;
    String phone = phoneController.text;
    String enterprise = enterpriseController.text;
    String address = addressController.text;
    if (this._dataIsValid()) {
      bool isUpdateInfoSuccess = false;
      isUpdateInfoSuccess =
          await this._userInfo?.saveInfo(name, id, phone, enterprise, address);
      bool isUpdated = await this._residentInfoViewModel?.saveInfoResident(
          name, id, phone, enterprise, address);
      var phoneOld = this._residentInfoViewModel.data.phone;
      print("Boolen: " + isUpdated.toString());
      if (isUpdateInfoSuccess) {
        this._userInfo.createUserAccount(phone, name, this.helperViewModel.appConfigModel.areaCodeCurrent, phoneOld != phone);
        isSuccess = true;
      }
    }
    return isSuccess;
  }

  bool _dataIsValid() {
    String name = nameController.text;
    String phone = phoneController.text;
    String enterprise = enterpriseController.text;
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
    _streamSubscription.cancel();
    _streamResidentSubscription.cancel();
  }

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    _userInfo = Provider.of<UserInfoViewModel>(context);
    _residentInfoViewModel = Provider.of<ResidentInfoViewModel>(context);
  }
}
