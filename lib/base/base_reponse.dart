
import 'package:flutter/cupertino.dart';
import 'package:orim/config/strings_resource.dart';

class _BaseResponse {
  int code;
  String msg;
  String msgToken;

  _BaseResponse(this.code, String msg, this.msgToken){
    if(msg == null || msg ==""){
      this.msg = StringResource.getTextResource("try_again_issue");
    }
  }

  bool isSuccess() => code == 1;

  bool isExpired() => code == 2;

  bool isNotPermission() => code == 401;

}

class ResponseObject<T> extends _BaseResponse{
  T data;
  ResponseObject({@required int code, String msg, String msgToken, T data, }) : super(code, msg, msgToken){
    this.data = data;
  }
  factory ResponseObject.initDefault(){
    int code = 0;
    return ResponseObject(code: code);
  }
}

class ResponseListNew<T> extends _BaseResponse{
  List<T> datas;
  int total = 0;
  ResponseListNew({@required int code, String msg, String msgToken, List<T> data, this.total }) : super(code, msg, msgToken){
    this.datas = data;
  }

  factory ResponseListNew.initDefault(){
    int code = 0;
    return ResponseListNew(code: code);
  }

}