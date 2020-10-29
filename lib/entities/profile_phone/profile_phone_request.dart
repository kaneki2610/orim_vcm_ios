
class ProfilePhoneRequest {
  String phone;
  ProfilePhoneRequest(this.phone);
  String getUrl(){
    return "Phonenumber=" + phone;
  }
}