import 'package:flutter/material.dart';
import 'package:sgm/src/views/splash-view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Gas Monitor',
      theme: ThemeData(
        fontFamily: 'Inter',
        canvasColor: Color.fromARGB(255, 255, 255, 255),
        dividerColor: Color.fromARGB(255, 225, 225, 225),
        disabledColor: Color.fromARGB(255, 175, 175, 175),
        shadowColor: Color.fromARGB(51, 155, 155, 155),
        unselectedWidgetColor: Color.fromARGB(255, 127, 127, 127),
        indicatorColor: Color.fromARGB(255, 110, 110, 110),
        hintColor: Color.fromARGB(255, 60, 60, 60),
        primaryColor: Color.fromARGB(255, 18, 167, 95),
      ),
      initialRoute: '/',
      routes: {'/': (context) => SplashView(context)},
    );
  }
}
