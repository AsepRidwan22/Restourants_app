import 'package:flutter/material.dart';
import 'package:restouran_app/data/model/restaurant_detail.dart';
import 'package:restouran_app/cummon/style.dart';

class RestaurantDetail extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final Restaurant restaurant;

  const RestaurantDetail({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Hero(
              tag: restaurant.pictureId,
              child: Image.network(
                "https://restaurant-api.dicoding.dev/images/small/" +
                    restaurant.pictureId,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant.name,
                            style: myTextTheme.headline6,
                          ),
                          _sizebox(10),
                          Row(
                            children: [
                              _icon(Icons.location_on, 16, Colors.grey),
                              Text(restaurant.city,
                                  style: myTextTheme.bodyText1),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _icon(Icons.star_rate, 20, Colors.yellow),
                          Text(
                            ' ${restaurant.rating}',
                            style: myTextTheme.headline6,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                _barrierContent(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 10, right: 20, left: 20),
                      child: Text('Description', style: myTextTheme.headline6),
                    ),
                    Container(
                        padding: const EdgeInsets.only(
                            top: 10, right: 20, left: 20, bottom: 20),
                        width: double.infinity,
                        child: Text(restaurant.description,
                            style: myTextTheme.bodyText2)),
                  ],
                ),
                _barrierContent(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    children: [
                      Text('Menu Food', style: myTextTheme.headline6),
                      ListBody(
                        children: restaurant.menus.foods.map((food) {
                          return Text(
                            '- ${food.name}',
                            style: myTextTheme.bodyText2,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                _barrierContent(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    children: [
                      Text('Menu Drink', style: myTextTheme.headline6),
                      ListBody(
                        children: restaurant.menus.drinks.map((drink) {
                          return Text(
                            '- ${drink.name}',
                            style: myTextTheme.bodyText2,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                _barrierContent()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _barrierContent() {
  return Container(
    height: 10,
    color: Colors.grey.shade200,
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
