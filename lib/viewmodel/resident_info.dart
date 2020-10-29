
import 'package:orim/base/viewmodel.dart';
import 'package:orim/model/user_info_data/user_info_data.dart';
import 'package:orim/repositories/userinfo/user_info_repo.dart';

class ResidentInfoViewModel extends BaseViewModel<ResidentInfoData> {

  UserInfoRepo userInfoRepo;

  Future<void> loadDataResident() async {
    if(data == null) {
      try{
        data = await userInfoRepo.loadInfoResident();
      } catch (err){
        print('err $err');
      }
    }
  }

  Future<bool> saveInfoResident(String name, String identify, String phone,
      String enterprise, String address) async {
    if(this.data == null){
      this.data = ResidentInfoData();
    }
    this.data.name = name;
    this.data.phone = phone;
    this.data.address = address;
    this.data.identify = identify;
    this.data.enterprise = enterprise;
    return await userInfoRepo.saveInfoResident(
        name, identify, phone, enterprise, address);
  }

}