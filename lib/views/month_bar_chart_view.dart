import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/services/data_download_service.dart';

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
    return FutureBuilder<List<ExpenseData>>(
      future: getChartData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error loading data"));
        }
        if (!snapshot.hasData) {
          return Center(child: Text("No data"));
        }
        return SfCartesianChart(
          backgroundColor: const Color(0xFF4AAD52),
          isTransposed: false,
          tooltipBehavior: _tooltipBehavior,
          borderWidth: 0,
          enableAxisAnimation: true,
          primaryXAxis: NumericAxis(
            majorGridLines: MajorGridLines(width: 0),
          ),
          primaryYAxis: NumericAxis(isVisible: false),
          series: <ChartSeries<ExpenseData, String>>[
            LineSeries<ExpenseData, String>(
              // Binding the chartData to the dataSource of the bar series.
              dataSource: chartData,
              xValueMapper: (ExpenseData data, _) => data.month.toString(),
              yValueMapper: (ExpenseData data, _) => data.spending,
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
              xValueMapper: (ExpenseData data, _) => data.month.toString(),
              yValueMapper: (ExpenseData data, _) => data.spending,
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
      },
    );
  }

  Future<List<ExpenseData>> getChartData() async {
    DataDownload dataDownload = DataDownload();
    List<num> transactions = [1];
    print("PRE");
    try {
      transactions = await dataDownload.getInstances2(" ");
    } catch (e) {
      print(e);
    }

    List<ExpenseData> ExpenseList = [];

    for (var item in transactions) {
      print(item);
    }

    // ExpenseList.add(ExpenseData("You", total));

    return ExpenseList;
  }
}

// Average American data
List<ExpenseData> chartData = <ExpenseData>[
  ExpenseData(1, 1600),
  ExpenseData(2, 2490),
  ExpenseData(3, 2900),
  ExpenseData(4, 23050),
  ExpenseData(5, 24880),
  ExpenseData(6, 34390),
  ExpenseData(7, 1600),
  ExpenseData(8, 2490),
  ExpenseData(9, 2900),
  ExpenseData(10, 23050),
  ExpenseData(11, 24880),
  ExpenseData(12, 34390),
];

class ExpenseData {
  ExpenseData(this.month, this.spending);
  final double month;
  final double spending;
}
