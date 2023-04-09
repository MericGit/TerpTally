import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/services/data_download_service.dart';


ChartSeriesController? chartSeriesController;

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
          backgroundColor: Color(0xFF4AAD52),
          isTransposed: false,
          tooltipBehavior: _tooltipBehavior,
          borderWidth: 0,
          primaryXAxis: CategoryAxis(isVisible: false),
          primaryYAxis: NumericAxis(isVisible: false),
          series: <ColumnSeries<ExpenseData, String>>[
            ColumnSeries<ExpenseData, String>(
              // Binding the chartData to the dataSource of the bar series.
              animationDuration: 2000,
              onRendererCreated: (ChartSeriesController controller) {
                chartSeriesController = controller;
              },
              dataSource: snapshot.data!,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              xValueMapper: (ExpenseData data, _) => data.person,
              yValueMapper: (ExpenseData data, _) => data.spending,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
            ),
          ],
        );
      },
    );
  }

  Future<List<ExpenseData>> getChartData() async {
    DataDownload dataDownload = DataDownload();
    Map<String, dynamic> cateTransactions = await dataDownload.getCate();

    List<ExpenseData> ExpenseList = [];
    var category = "Food & Drink";

    double total = 0;
    for (var item in cateTransactions.entries) {
      try {
        if (item.key == category) {
          total = item.value;

        }
      } catch (e) {
        print(e);
      }
    }
    ExpenseList.add(ExpenseData("You", total));
    ExpenseList.add(ExpenseData("Average American", 88000)); // average

    return ExpenseList;
  }
}

class ExpenseData {
  ExpenseData(this.person, this.spending);
  final String person;
  final double spending;
}
