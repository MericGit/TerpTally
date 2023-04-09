import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/views/year_bar_chart_view.dart';
import 'package:noteapp/views/month_bar_chart_view.dart';

import 'package:noteapp/views/pie_chart_view.dart';
import 'package:noteapp/views/data_view.dart';
import 'package:noteapp/views/home_view.dart';
import 'package:noteapp/views/login_view.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginView(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/home/': (context) => const HomeView(),
        '/graph/': (context) => const PieChart(title: 'Graph'),
        '/barchart/': (context) => const YearBarChart(title: 'Bar Chart'),
        '/data/': (context) => const DataView(),
        '/monthchart/': (context) => const MonthBarChart(title: 'Month Chart'),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user?.emailVerified ?? false) {
                print('verified user');
              } else {
                print('anon non verified');
              }
              return const Text('Done');
            default:
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}
