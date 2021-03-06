import 'package:flutter/material.dart';
import 'package:restouran_app/notification/notification_helper.dart';
import 'package:restouran_app/ui/restaurant_detail_page.dart';
import 'package:restouran_app/ui/restaurant_favorite.dart';
import 'package:restouran_app/ui/restaurant_list_page.dart';
import 'package:restouran_app/ui/restaurant_search_page.dart';
import 'package:restouran_app/ui/restaurant_setting_page.dart';

class RestaurantHomePage extends StatefulWidget {
  static const routeName = '/home';
  const RestaurantHomePage({Key? key}) : super(key: key);

  @override
  State<RestaurantHomePage> createState() => _RestaurantHomePageState();
}

class _RestaurantHomePageState extends State<RestaurantHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const RestaurantListPage(),
    const RestaurantSearchPage(),
    const RestaurantFavoritePage(),
    const RestaurantSettingPage()
  ];

  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Restaurant App",
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.grey.shade100,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      unselectedFontSize: 0,
      selectedFontSize: 0,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey.withOpacity(0.5),
      showUnselectedLabels: false,
      showSelectedLabels: false,
      backgroundColor: Colors.white,
      elevation: 0, //ketebalan shadow
      items: const [
        BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.search)),
        BottomNavigationBarItem(label: 'Favorite', icon: Icon(Icons.favorite)),
        BottomNavigationBarItem(
            label: 'Profil', icon: Icon(Icons.account_circle))
      ],
      onTap: (index) {
        _onItemTapped(index);
      },
    );
  }
}
