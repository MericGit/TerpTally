import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteapp/components/dynamic_text_widget.dart';
import 'package:noteapp/services/data_download_service.dart';
import 'package:noteapp/components/d2.dart';

class DataText extends StatelessWidget {
  final int page;

  DataText({Key? key, required this.page}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    switch (page) {
      case 0:
        return Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              height: 200,
              child: Text(
                'Compare your spending against the average American',
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    color: Color(0xFF393659),
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),

              // SizedBox(DynamicTextWidget()),
            ),
            const SizedBox(height: 10),
          ],
        );
      case 1:
        return Column(
          children: [
            SizedBox(
              height: 50,
              child: Text(
                'Data sourced from the Consumer Expenditure Survey',
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    color: Colors.blue,
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: Text(
                'Compare your food spending',
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    color: Colors.blue,
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: Text(
                'You certainly like to eat cheap!',
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    color: Colors.blue,
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        );
      case 2:
        return Column(
          children: [
            SizedBox(
              height: 200,
              child: Text(
                'Your biggest splurge: Tacobell',
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    color: Colors.blue,
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            DynamicTextWidget(),
            d2(),
          ],
        );
      case 3:
        return Column(
          children: [
            SizedBox(
              height: 50,
              child: Text(
                'Data sourced from the Consumer Expenditure Survey',
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    color: Colors.blue,
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: Text(
                'Compare your shopping!',
                style: GoogleFonts.playfairDisplay(
                  textStyle: const TextStyle(
                    color: Colors.blue,
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
