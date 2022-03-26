import 'package:flutter/material.dart';
import 'package:restouran_app/data/model/restaurant_detail.dart';
import 'package:restouran_app/widget/restaurant_detail.dart';
import 'package:restouran_app/ui/restaurant_detail_page.dart';
import 'package:restouran_app/widget/splash_screen.dart';
import 'package:restouran_app/ui/restaurant_list_page.dart';
import 'package:restouran_app/cummon/navigations.dart';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        RestaurantListPage.routeName: (context) => RestaurantListPage(),
      },
    );
  }
}
