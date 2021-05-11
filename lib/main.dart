import 'package:flutter/material.dart';
import 'mainPage.dart';
import 'const.dart';

void main() => runApp(Root());

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: kPrimary,
        scaffoldBackgroundColor: kPrimary,
      ),
      routes: {
        '/': (context) => MainPage(),
      },
      initialRoute: '/',
    );
  }
}
