import 'dart:math';
import 'package:flutter/material.dart';
import 'package:orim/config/dimens_resource.dart';
import 'package:orim/model/dashboardarea/services_area.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// Example that shows how to build a datum legend that shows measure values.
///
/// Also shows the option to provide a custom measure formatter.

class PieOutsideLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  PieOutsideLabelChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory PieOutsideLabelChart.withServicesDashBoardData(List<ServicesAreaModel>data) {
    return new PieOutsideLabelChart(
      _createServiceData(data),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 200.0,
      child: new charts.PieChart(seriesList,
          animate: animate,
          defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
            new charts.ArcLabelDecorator(
                labelPosition: charts.ArcLabelPosition.outside),
          ])),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<ServicesAreaModel, double>> _createServiceData(List<ServicesAreaModel>data) {
    List<ServicesAreaModel> list = new List<ServicesAreaModel>();
    final Random _random = Random();
    list = data;
    return [
      new charts.Series<ServicesAreaModel, double>(
        id: 'Sales',
        domainFn: (ServicesAreaModel service, _) => service.number.toDouble(),
        measureFn: (ServicesAreaModel service, _) => service.percent.toDouble(),
        colorFn: (ServicesAreaModel service, _) {
          return new charts.Color(r: service.red, g: service.green, b: service.blue);
        },
        data: list,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (ServicesAreaModel row, _) => '${row.number} - ${row.percent}%',
      )
    ];
  }
}

class DetailChartDashBoard extends StatefulWidget {
  List<ServicesAreaModel> list;
  DetailChartDashBoard({Key key, this.list}) : super(key: key);

  @override
  _DetailChartDashBoardState createState() => _DetailChartDashBoardState();
}

class _DetailChartDashBoardState extends State<DetailChartDashBoard> {
  Map<String, double> dataMap = new Map();
  final List<Color> colorList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> listChipDescription = this.widget.list.map((e){
      return Chip(
        avatar: CircleAvatar(
            backgroundColor: Color.fromRGBO(e.red, e.green, e.blue, 1.0), child: Text('')),
        label: Text(e.name),
      );
    }).toList();
    return Container(
      padding: EdgeInsets.only(left: DimenResource.paddingContent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            PieOutsideLabelChart.withServicesDashBoardData(this.widget.list),
            Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: listChipDescription,
            ),
          ],
        ),
      );
  }
}

