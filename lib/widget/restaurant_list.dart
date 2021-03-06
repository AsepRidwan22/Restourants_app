import 'package:flutter/material.dart';
import 'package:restouran_app/data/model/restaurant_list.dart';
import 'package:restouran_app/cummon/style.dart';
import 'package:restouran_app/ui/restaurant_detail_page.dart';

class RestaurantCardList extends StatelessWidget {
  final Restaurantlist restaurant;

  const RestaurantCardList({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return RestaurantDetailPage(
            restaurantlist: restaurant,
          );
        }));
      },
      child: Stack(
        children: <Widget>[
          Container(
            margin:
                const EdgeInsets.only(left: 40, top: 5, right: 20, bottom: 5),
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
                  "https://restaurant-api.dicoding.dev/images/small/" +
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
