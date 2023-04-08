import 'package:flutter/material.dart';
import 'package:noteapp/components/upload_button.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdcdcc4),
      appBar: AppBar(
        title: const Text('TerpTally'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: 400,
              width: 500,
              child: Image.asset('assets/images/chartStock.gif')),
          SizedBox(
            width: 300.0,
            height: 100.0,
            child: Shimmer.fromColors(
              baseColor: const Color(0xff648767),
              highlightColor: const Color(0xffE1EFF6),
              child: const Text(
                'Discover your spending in intuitive and enlightening ways',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 75),
          const Text("No statement on file",
              style: TextStyle(
                color: Color.fromARGB(255, 194, 43, 32),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),

          //TODO: Implement support for checking cached report.
          const UploadButton(),
        ],
      ),
    );
  }
}
