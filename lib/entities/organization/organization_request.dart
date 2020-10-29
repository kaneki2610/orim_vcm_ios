
class OrganizationRequest {
  String areaCode;

  OrganizationRequest(this.areaCode);

  String getUrl() {
    return "code=" + this.areaCode;
  }
}