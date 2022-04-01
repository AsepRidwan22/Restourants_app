import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restouran_app/data/model/restaurant_list.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restouran_app/cummon/navigation.dart';
import 'package:restouran_app/data/model/restaurant_list.dart';
import 'package:rxdart/subjects.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(Uri.parse(url));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantResult restaurantlist) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "asep ridwan";
    var bigPicturePath = await _downloadAndSaveFile(
        'https://restaurant-api.dicoding.dev/images/medium/${restaurantlist.restaurants[0].pictureId}',
        'bigPicture');
    var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(bigPicturePath),
      contentTitle: restaurantlist.restaurants[0].name,
      htmlFormatContentTitle: true,
      summaryText:
          "Restoran di ${restaurantlist.restaurants[0].city} dengan rating ${restaurantlist.restaurants[0].rating}",
      htmlFormatSummaryText: true,
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName,
        channelDescription: _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: bigPictureStyleInformation);

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var titleNotification = restaurantlist.restaurants[0].name;
    var titleNews = restaurantlist.restaurants[0].description;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleNews, platformChannelSpecifics,
        payload: json.encode(restaurantlist.toJson()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = RestaurantResult.fromJson(json.decode(payload));
        var restaurant = data.restaurants[0];
        var restaurantId = data.restaurants[0].id;
        Navigation.intentWithData(restaurantId, restaurant);
      },
    );
  }
}
