import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StaticPieChart extends StatefulWidget {
  const StaticPieChart({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  StaticPieChartState createState() => StaticPieChartState();
}

class StaticPieChartState extends State<StaticPieChart> {
  late List<ExpenseData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      backgroundColor: Color(0xFF4AAD52),
      tooltipBehavior: _tooltipBehavior,
      series: <CircularSeries>[
        DoughnutSeries<ExpenseData, String>(
          dataSource: _chartData,
          xValueMapper: (ExpenseData data, _) => data.type,
          yValueMapper: (ExpenseData data, _) =>
              int.parse(data.total.substring(1)),
          dataLabelMapper: (ExpenseData data, _) =>
              (data.type + "\n" + data.total),
          dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.top,
              overflowMode: OverflowMode.hide,
              connectorLineSettings: ConnectorLineSettings(width: 0),
              textStyle: TextStyle(color: Color(0xFFE9E7EF))),
          enableTooltip: true,
          animationDelay: 500,
          animationDuration: 2500,
        )
      ],
    );
  }

  List<ExpenseData> getChartData() {
    final List<ExpenseData> chartData = [
      ExpenseData('Education', "\$1600"),
      ExpenseData('Entertainment', "\$2490"),
      ExpenseData('Fees & Adjustments', "\$2900"),
      ExpenseData('Food & Drink', "\$23050"),
      ExpenseData('Gas', "\$24880"),
      ExpenseData('Groceries', "\$34390"),
      ExpenseData('Health & Wellness', "\$1600"),
      ExpenseData('Home', "\$2490"),
      ExpenseData('Personal', "\$2900"),
      ExpenseData('Professional Services', "\$23050"),
      ExpenseData('Shopping', "\$24880"),
      ExpenseData('Travel', "\$34390"),
    ];
    return chartData;
  }
}

class ExpenseData {
  // Transaction Date,Post Date,Description,Category,Type,Amount,Memo
  ExpenseData(this.type, this.total);
  final String type;
  final String total;
  // final Color pointColor;
}