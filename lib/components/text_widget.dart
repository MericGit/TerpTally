import 'package:flutter/material.dart';

class DataText extends StatelessWidget {
  final int page;

  const DataText({Key? key, required this.page}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    switch (page) {
      case 0:
        return Column(
          children: const [
            SizedBox(
              height: 50,
              child: Text(
                'Your two highest spending months are VAL and VAL',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      case 1:
        return Column(
          children: const [
            SizedBox(
              height: 50,
              child: Text(
                'Compared to the average American you spend x% more on food',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
