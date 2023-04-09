import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/services/auth_services.dart';
import 'package:noteapp/services/data_download_service.dart';
import 'package:noteapp/views/home_view.dart';

class DataButton extends StatelessWidget {
  const DataButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final DataDownload dataDownload = DataDownload();
        print(await dataDownload.getCate());
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
          "Test Run",
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
