import 'package:flutter/material.dart';
import 'package:orim/config/enum_packages/dashboard_list_type.dart';
import 'package:orim/config/strings_resource.dart';
import 'package:orim/model/dashboardarea/dashboard_area.dart';

class DashBoardItem extends StatelessWidget {
  DashBoardAreaModel objModel = DashBoardAreaModel();
  Function(DashBoardAreaModel) areaNameClicked;
  Function(DashBoardAreaModel, DashboardListEnum ) processClicked;

  DashBoardItem(
      {Key key, this.objModel, this.areaNameClicked, this.processClicked})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    int maxLineNameArea = 2;
    int maxLineNumberIssue = 1;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              this.areaNameClicked(this.objModel);
            },
            child: Text(
              this.objModel.nameArea,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: maxLineNameArea,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            StringResource.getText(context, 'dashboard_sum_of_issues') +
                this.objModel.sumIssue.toString(),
            maxLines: maxLineNumberIssue,
          ),
          SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              this.processClicked(this.objModel, DashboardListEnum.PROCESSED);
            },
            child: Text(
              StringResource.getText(context, 'dashboard_processed_issues') +
                  this.objModel.processed.toString() +
                  "(" +
                  '${this.calculatorPercents(this.objModel.processed, this.objModel.sumIssue)}' +
                  "%)",
              maxLines: maxLineNumberIssue,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              this.processClicked(this.objModel, DashboardListEnum.PROCESSING);
            },
            child: Text(
              StringResource.getText(context, 'dashboard_processing_issues') +
                  this.objModel.processing.toString() +
                  "(" +
                  '${this.calculatorPercents(
                      this.objModel.processing,
                      this.objModel.sumIssue)}' +
                  "%)",
              maxLines: maxLineNumberIssue,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  int calculatorPercents(int a, int b) {
    if (b > 0) {
      return ((a / b) * 100).round();
    } else {
      return 0;
    }
  }
}
