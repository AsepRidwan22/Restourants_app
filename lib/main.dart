import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:restouran_app/data/model/restaurant.dart';
import 'package:restouran_app/menu/detail_page.dart';
import 'package:restouran_app/constant/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: RestaurantListPage.routeName,
      routes: {
        RestaurantListPage.routeName: (context) => SplashScreen(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restauran_list';

  const RestaurantListPage({Key? key}) : super(key: key);

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
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              var jsonMap = jsonDecode(snapshot.data!);
              var restaurant = Welcome.fromJson(jsonMap);
              return ListView.builder(
                itemCount: restaurant.restaurants.length,
                itemBuilder: (context, index) {
                  return _buildRestaurantItem(
                      context, restaurant.restaurants[index]);
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return CircularProgressIndicator();
            }
          }
        },
      ),
    );
  }
}

Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, RestaurantDetailPage.routeName,
          arguments: restaurant);
    },
    child: Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 40, top: 5, right: 20, bottom: 5),
          height: 170.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 200, top: 20, right: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 120.0,
                  child: Text(restaurant.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                    ),
                    Text(
                      ' ${restaurant.city}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_rate,
                      size: 20,
                      color: Colors.yellow,
                    ),
                    Text(
                      ' ${restaurant.rating}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 20.0,
          top: 15.0,
          bottom: 15.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Hero(
              tag: restaurant.pictureId,
              child: Image.network(
                restaurant.pictureId,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
