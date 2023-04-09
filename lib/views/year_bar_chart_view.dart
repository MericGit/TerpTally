import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class YearBarChart extends StatefulWidget {
  const YearBarChart({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  BarChartState createState() => BarChartState();
}

class BarChartState extends State<YearBarChart> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      backgroundColor: Color(0xFF111003),
      isTransposed: false,
      tooltipBehavior: _tooltipBehavior,
      borderWidth: 0,
      primaryXAxis: CategoryAxis(isVisible: false),
      primaryYAxis: NumericAxis(isVisible: false),
      series: <ColumnSeries<ExpenseData, String>>[
        ColumnSeries<ExpenseData, String>(
          // Binding the chartData to the dataSource of the bar series.
          dataSource: chartData,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          xValueMapper: (ExpenseData data, _) => data.person,
          yValueMapper: (ExpenseData data, _) => int.parse(data.spending.substring(1)),
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }

  //Initialize the data source
  List<ExpenseData> chartData = <ExpenseData>[
    ExpenseData('You', '\$84452'),
    ExpenseData('Average', '\$77774'),
  ];
}

class ExpenseData {
  ExpenseData(this.person, this.spending);
  final String person;
  final String spending;
}
