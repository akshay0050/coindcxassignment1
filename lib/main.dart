import 'package:coin_dcx_assignment/network_calls/env.dart';
import 'package:coin_dcx_assignment/ui_classes/currency_list.dart';
import 'package:coin_dcx_assignment/ui_classes/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  Env.setEnvironment(Environment.PROD);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coin DCX',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home:
      WelcomeScreen()
    );
  }
}

