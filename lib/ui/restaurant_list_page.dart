import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:restouran_app/data/model/restaurant.dart';
import 'package:restouran_app/menu/detail_page.dart';
import 'package:restouran_app/cummon/style.dart';

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
            return const Center(child: CircularProgressIndicator());
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
              return const CircularProgressIndicator();
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
          //mohon maaf tidak mengunakan sizebox seperti yang di sarankan di submission sebelumnya karena sizebox tidak bisa pake margin
          margin: const EdgeInsets.only(left: 40, top: 5, right: 20, bottom: 5),
          height: 170.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 200, top: 20, right: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 120.0,
                  child: Text(restaurant.name, style: myTextTheme.headline6),
                ),
                _sizebox(10),
                Row(
                  children: [
                    _icon(Icons.location_on, 16, Colors.black),
                    Text(' ${restaurant.city}', style: myTextTheme.bodyText1),
                  ],
                ),
                _sizebox(10),
                Row(
                  children: [
                    _icon(Icons.star_rate, 20, Colors.yellow),
                    Text(
                      ' ${restaurant.rating}',
                      style: myTextTheme.bodyText1,
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

Widget _sizebox(double height) {
  return SizedBox(
    height: height,
  );
}

Widget _icon(IconData icon, double size, Color color) {
  return Icon(
    icon,
    size: size,
    color: color,
  );
}
