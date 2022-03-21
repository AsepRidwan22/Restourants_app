import 'package:flutter/material.dart';
import 'package:restouran_app/data/model/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final Restaurant restaurant;

  const RestaurantDetailPage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Hero(
              tag: restaurant.pictureId,
              child: Image.network(
                restaurant.pictureId,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant.name,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
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
                                '${restaurant.city}',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
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
                _barrierContent(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                      child: Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, right: 20, left: 20, bottom: 20),
                      width: double.infinity,
                      child: Text(
                        restaurant.description,
                        style: TextStyle(fontSize: 14, height: 1.2),
                      ),
                    ),
                  ],
                ),
                _barrierContent(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          'Menu Food',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListBody(
                        children: restaurant.menus.foods.map((food) {
                          return Text(
                            '- ${food.name}',
                            style: TextStyle(fontSize: 14, height: 1.5),
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
                      Container(
                        child: Text(
                          'Menu Drink',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListBody(
                        children: restaurant.menus.drinks.map((drink) {
                          return Text(
                            '- ${drink.name}',
                            style: TextStyle(fontSize: 14, height: 1.5),
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
