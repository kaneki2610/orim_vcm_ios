class BaseResponse<T> {
  int code;
  String msg;
  T data;
  String msgToken;

  BaseResponse({this.code, this.msg, this.data, this.msgToken});

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
      code: json['code'] as int,
      msg: json['msg'] as String,
      data: json['data'] as T,
      msgToken: json['msgToken'] as String);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': this.code,
        'msg': this.msg,
        'data': this.data,
        'msgToken': this.msgToken
      };

  bool isSuccess() => code == 1;

  bool isExpired() => code == 2;

  bool isNotPermission() => code == 401;

}
