import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restouran_app/data/api/service_api.dart';
import 'package:restouran_app/data/db/database_helper.dart';
import 'package:restouran_app/provider/restaurant_database.dart';
import 'package:restouran_app/provider/restaurant_list.dart';
import 'package:restouran_app/provider/restaurant_search.dart';
import 'package:restouran_app/widget/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
        ChangeNotifierProvider(
            create: (_) => RestaurantProvider(apiService: ApiService())),
        ChangeNotifierProvider(
            create: (_) => SearchRestaurantProvider(apiService: ApiService()))
      ],
      child: MaterialApp(
        title: 'Restaurant',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: const SplashScreen(),
      ),
    );
  }
}
