// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';

import 'package:driver_app/pages/login_page.dart';



void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // var db = Mysql();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent)),
      home: LoginPage(),
    );
    
  }
}



