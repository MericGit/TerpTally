import 'package:flutter/material.dart';
import 'package:noteapp/services/auth_services.dart';
import 'package:noteapp/services/convert_file_service.dart';
import 'package:noteapp/views/data_view.dart';
import 'package:noteapp/views/home_view.dart';
import 'package:noteapp/views/login_view.dart';
import 'package:noteapp/views/year_bar_chart_view.dart';
import 'package:noteapp/views/month_bar_chart_view.dart';

import '../services/file_upload_service.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 600),
            pageBuilder: (context, animation, secondaryAnimation) => DataView(),
            //const BarChart(title: 'title'),
            //const PieChart(title: 'title'),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
        );
        ConvertFileService().convertFile();
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: const Color(0xff5F9EAB),
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Center(
            child: Text(
          "Upload Bank Statement",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
