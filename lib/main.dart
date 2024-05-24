import 'package:flutter/material.dart';
import 'utama/login_page.dart';
import 'utama/register_page.dart';
import 'utama/dashboard.dart';
//import 'history_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan tulisan "Debug" di pojok kanan atas
      title: 'Flutter Run',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginApp(),
        '/register': (context) => RegisterApp(),
        '/dashboard' : (context) => DashboardApp(),
        //'/history' : (context) => HistoryPage(),
      },
    );
  }
}