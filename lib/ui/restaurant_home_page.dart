import 'package:flutter/material.dart';
import 'package:restouran_app/ui/restaurant_list_page.dart';
import 'package:restouran_app/ui/restaurant_search_page.dart';

class RestaurantHomePage extends StatefulWidget {
  const RestaurantHomePage({Key? key}) : super(key: key);

  @override
  State<RestaurantHomePage> createState() => _RestaurantHomePageState();
}

class _RestaurantHomePageState extends State<RestaurantHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    const RestaurantListPage(),
    const RestaurantSearchPage(),
    const Center(
      child: Text(
        'Profil',
        style: optionStyle,
      ),
    ),
    const Center(
      child: Text(
        'Profil',
        style: optionStyle,
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
