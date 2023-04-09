import 'package:flutter/material.dart';
import 'package:noteapp/views/year_bar_chart_view.dart';
import 'package:noteapp/views/month_bar_chart_view.dart';
import 'package:noteapp/components/text_widget.dart';
import 'package:noteapp/views/pie_chart_view.dart';

class DataView extends StatefulWidget {
  const DataView({super.key});
  @override
  DataViewState createState() => DataViewState();
}

class DataViewState extends State<DataView> {
  PageController pageController = PageController(
    initialPage: 0,
    viewportFraction: 1,
  );
  int currentPage = 0;

  Widget buildDataPage(String title, Color color, bool active) {
    final double blur = active ? 0 : 80;
    //final double offset = active ? 0 : 0;
    //  final double top = active ? 25 : 50;
    final Widget chart;
    final Widget textData;
    switch (currentPage) {
      case 0:
        chart = MonthBarChart(title: title);
        break;
      case 1:
        chart = YearBarChart(title: title);
        break;
      case 2:
        chart = PieChart(title: title);
        break;
      default:
        chart = MonthBarChart(title: title);
    }
    textData = DataText(page: currentPage);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(221, 255, 255, 255),
            blurRadius: blur,
            // offset: Offset(offset, offset),
          ),
        ],
      ),
      child: Column(
        children: [
          textData,
          const SizedBox(height: 320),
          chart,
          const Text(
            "A bitcamp 2023 project",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontStyle: FontStyle.italic,
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    currentPage = pageController.initialPage;
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 62, 92, 225),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              children: [
                buildDataPage('Page 1', Colors.blue, currentPage == 0),
                buildDataPage('Page 2', Colors.green, currentPage == 1),
                buildDataPage('Page 3', Colors.red, currentPage == 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
