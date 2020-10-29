import 'package:orim/model/issue/issue.dart';

class PaginationModel {
  int limit = 10;
  int offset = 0;
  PaginationModel({this.offset = 0, this.limit = 10});

  void setIncreaseOffset() {
    this.offset += 10;
  }

  void refreshOffset() {
    this.offset = 0;
  }

  String getPaginationIssueArea() {
    return "limit=${this.limit}&offset=${this.offset}";
  }

  void onLoadMore(int total) {
    this.offset = this.offset + total;
  }

  List<dynamic> addData(
      List<dynamic> dataListTotal, List<dynamic> dataListResponse) {
    if(this.offset == 0) {
      dataListTotal.clear();
      dataListTotal = dataListResponse;
    } else {
      dataListTotal.addAll(dataListResponse);
    }
    return dataListTotal;
  }
}
