import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restouran_app/cummon/navigation.dart';
import 'package:restouran_app/cummon/preferences_helper.dart';
import 'package:restouran_app/data/api/service_api.dart';
import 'package:restouran_app/data/db/database_helper.dart';
import 'package:restouran_app/data/model/restaurant_list.dart';
import 'package:restouran_app/provider/restaurant_database.dart';
import 'package:restouran_app/provider/restaurant_list.dart';
import 'package:restouran_app/provider/restaurant_search.dart';
import 'package:restouran_app/provider/scheduling_provider.dart';
import 'package:restouran_app/ui/restaurant_detail_page.dart';
import 'package:restouran_app/ui/restaurant_home_page.dart';
import 'package:restouran_app/ui/restaurant_list_page.dart';
import 'package:restouran_app/widget/splash_screen.dart';
import 'package:restouran_app/notification/notification_helper.dart';
import 'package:restouran_app/notification/background_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  await AndroidAlarmManager.initialize();
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

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
            create: (_) => SearchRestaurantProvider(apiService: ApiService())),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Restaurant',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: const SplashScreen(),
        initialRoute: RestaurantHomePage.routeName,
        routes: {
          RestaurantHomePage.routeName: (context) => const RestaurantHomePage(),
          RestaurantListPage.routeName: (context) => const RestaurantListPage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                restaurantlist: ModalRoute.of(context)?.settings.arguments
                    as Restaurantlist,
              ),
        },
      ),
    );
  }
}
