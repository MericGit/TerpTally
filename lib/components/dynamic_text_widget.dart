import 'package:flutter/material.dart';
import 'package:noteapp/services/data_download_service.dart';

class DynamicTextWidget extends StatelessWidget {
  final DataDownload dataDownload = DataDownload();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: dataDownload.getFreq("TACO"),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return Center(
          child: Text(
            'You visited ${snapshot.data} times last year!',
            style: TextStyle(color: Color(0xFF393659), fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
