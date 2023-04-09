import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:noteapp/services/data_download_service.dart';

List<String> typeList = [];
List<String> totalList = [];

class PieChart extends StatefulWidget {
  const PieChart({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  PieChartState createState() => PieChartState();
}

class PieChartState extends State<PieChart> {
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
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text("Error loading data"));
        }
        if (!snapshot.hasData) {
          return const Center(child: Text("No data"));
        }
        return SfCircularChart(
          backgroundColor: const Color(0xFF4AAD52),
          tooltipBehavior: _tooltipBehavior,
          series: <CircularSeries>[
            DoughnutSeries<ExpenseData, String>(
              dataSource: snapshot.data!,
              xValueMapper: (ExpenseData data, _) => data.type,
              yValueMapper: (ExpenseData data, _) => data.total,
              dataLabelMapper: (ExpenseData data, _) => data.type,
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
      },
    );
  }

  Future<List<ExpenseData>> getChartData() async {
    DataDownload dataDownload = DataDownload();
    //print("GETTING DATA");
    Map<String, dynamic> cateTransactions = await dataDownload.getCate();

    List<ExpenseData> ExpenseList = [];

    for (var item in cateTransactions.entries) {
      try {
        ExpenseList.add(ExpenseData(item.key, item.value));
      } catch (e) {
        //print(e);
      }
    }
    return ExpenseList;
  }
}

class ExpenseData {
  ExpenseData(this.type, this.total);

  final String type;
  final double total;
}
