class DeviceVcmRequest {
  String deviceId;
  String plushKey;

  DeviceVcmRequest({this.deviceId, this.plushKey});

  DeviceVcmRequest fromJson(Map<String, dynamic> json) {
    return DeviceVcmRequest(
      deviceId: json['deviceId'],
      plushKey: json['plushKey'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'deviceId': this.deviceId,
        'plushKey': this.plushKey,
      };
}
