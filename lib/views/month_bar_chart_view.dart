import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class MonthBarChart extends StatefulWidget {
  const MonthBarChart({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MonthBarChartState createState() => MonthBarChartState();
}

class MonthBarChartState extends State<MonthBarChart> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      backgroundColor: const Color(0xFF111003),
      isTransposed: false,
      tooltipBehavior: _tooltipBehavior,
      borderWidth: 0,
      enableAxisAnimation: true,
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(isVisible: false),
      series: <ChartSeries<ExpenseData, String>>[
        LineSeries<ExpenseData, String>(
          // Binding the chartData to the dataSource of the bar series.
          dataSource: chartData,
          xValueMapper: (ExpenseData data, _) => data.month.substring(0, 3),
          yValueMapper: (ExpenseData data, _) =>
              int.parse(data.spending.substring(1)),
          dataLabelSettings: const DataLabelSettings(
            isVisible: false,
          ),
          enableTooltip: true,
          animationDelay: 500,
          animationDuration: 2500,
          markerSettings: const MarkerSettings(
              isVisible: true,
              color: Color(0xFF111003),
              shape: DataMarkerType.circle),
        ),
        LineSeries<ExpenseData, String>(
          // Binding the chartData to the dataSource of the bar series.
          dataSource: chartData,
          xValueMapper: (ExpenseData data, _) => data.month.substring(0, 3),
          yValueMapper: (ExpenseData data, _) =>
              int.parse(data.spending.substring(1)) + 1500,
          dataLabelSettings: const DataLabelSettings(
            isVisible: false,
          ),
          enableTooltip: true,
          animationDelay: 500,
          animationDuration: 2500,
          markerSettings: MarkerSettings(
              isVisible: true,
              color: Color(0xFF111003),
              shape: DataMarkerType.diamond),
        )
      ],
    );
  }

  //Initialize the data source
  List<ExpenseData> chartData = <ExpenseData>[
    ExpenseData('January', "\$1600"),
    ExpenseData('February', "\$2490"),
    ExpenseData('March', "\$2900"),
    ExpenseData('April', "\$23050"),
    ExpenseData('May', "\$24880"),
    ExpenseData('June', "\$34390"),
    ExpenseData('July', "\$1600"),
    ExpenseData('August', "\$2490"),
    ExpenseData('September', "\$2900"),
    ExpenseData('October', "\$23050"),
    ExpenseData('November', "\$24880"),
    ExpenseData('December', "\$34390"),
  ];
}

class ExpenseData {
  ExpenseData(this.month, this.spending);
  final String month;
  final String spending;
}
