// import 'package:flutter/material.dart';
// import 'package:restouran_app/ui/restaurant_home_page.dart';
// import 'package:restouran_app/widget/splash_screen.dart';

// class BottomNavBar extends StatefulWidget {
//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//       TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   static List<Widget> _widgetOptions = <Widget>[
//     SplashScreen(),
//     Center(
//       child: Text(
//         'Profil',
//         style: optionStyle,
//       ),
//     ),
//     Center(
//       child: Text(
//         'Profil',
//         style: optionStyle,
//       ),
//     ),
//     Center(
//       child: Text(
//         'Profil',
//         style: optionStyle,
//       ),
//     ),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }

//   Widget _buildBottomNavigationBar() {
//     return BottomNavigationBar(
//       unselectedFontSize: 0,
//       selectedFontSize: 0,
//       type: BottomNavigationBarType.fixed,
//       currentIndex: _selectedIndex,
//       selectedItemColor: Colors.black,
//       unselectedItemColor: Colors.grey.withOpacity(0.5),
//       showUnselectedLabels: false,
//       showSelectedLabels: false,
//       backgroundColor: Colors.white,
//       elevation: 0, //ketebalan shadow
//       items: const [
//         BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
//         BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.search)),
//         BottomNavigationBarItem(label: 'Favorite', icon: Icon(Icons.favorite)),
//         BottomNavigationBarItem(
//             label: 'Profil', icon: Icon(Icons.account_circle))
//       ],
//       onTap: (index) {
//         _onItemTapped(index);
//       },
//     );
//   }
// }
