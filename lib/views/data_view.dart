import 'dart:io';

import 'package:flutter/material.dart';
import 'package:noteapp/views/year_bar_chart_view.dart';
import 'package:noteapp/views/month_bar_chart_view.dart';
import 'package:noteapp/components/text_widget.dart';
import 'package:noteapp/views/pie_chart_view.dart';
import 'package:noteapp/views/category_bar_chart_view.dart';
import 'package:noteapp/views/catShop.dart';

import '../components/data_button.dart';

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
        chart = PieChart(title: title);
        break;
      case 1:
        chart = CategoryBarChart(title: title);
        break;
      case 2:
        chart = PieChart(title: title);
        break;
      case 3:
        chart = CatShop(title: title);
        break;
      case 4:
        chart = MonthBarChart(title: title);
        break;
      default:
        chart = CategoryBarChart(title: title);
    }
    textData = DataText(page: currentPage);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD9E5E8),
            blurRadius: blur,
            // offset: Offset(offset, offset),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 50),
          const Text(
            "Spending Journey",
            style: TextStyle(
              color: Color.fromARGB(255, 32, 150, 201),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          chart,
          textData,
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
        body: GestureDetector(
          onTapDown: (details) => _onTapDown(details),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
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
                    buildDataPage('Page 4', Colors.yellow, currentPage == 3),
                    buildDataPage('page 5', Colors.orange, currentPage == 4),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    if (dx < screenWidth / 5) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
      );
    } else if (dx > screenWidth / 5 * 4) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
      );
    }
  }
}
