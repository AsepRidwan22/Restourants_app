import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restouran_app/data/model/restaurant_list.dart';
import 'package:restouran_app/data/model/restaurant_search.dart';
import 'package:restouran_app/provider/restaurant_search.dart';
import 'package:restouran_app/ui/restaurant_detail_page.dart';
import 'package:restouran_app/cummon/style.dart';

class RestaurantSearchPage extends StatefulWidget {
  const RestaurantSearchPage({Key? key}) : super(key: key);
  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  TextEditingController controller = TextEditingController();
  String hasil = "";
  SearchRestaurantResult? restaurantSearch;
  Restaurantlist? restaurantlist;

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(builder: (context, state, _) {
      return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Positioned(
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 10),
                            blurRadius: 50,
                            color: Colors.grey.shade500.withOpacity(0.23))
                      ]),
                  child: TextField(
                    controller: controller,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.23)),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    onChanged: (String query) {
                      if (query.isNotEmpty) {
                        setState(() {
                          hasil = query;
                        });
                        state.fetchAllRestaurant(hasil);
                      }
                    },
                  ),
                ),
              ),
              (hasil.isEmpty)
                  ? const Center(
                      child: Text('Tuliskan apa yang ingin dicari!'),
                    )
                  : buildSearch(context)
            ],
          ),
        ),
      );
    });
  }
}

Widget buildSearch(BuildContext context) {
  return Consumer<SearchRestaurantProvider>(
    builder: (context, state, _) {
      if (state.state == SearchResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.state == SearchResultState.hasData) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.result!.restaurants.length,
          itemBuilder: (context, index) {
            var restaurant = state.result!.restaurants[index];
            return buildRestaurantItem(context, restaurant);
          },
        );
      } else if (state.state == SearchResultState.noData) {
        return Center(child: Text(state.message));
      } else if (state.state == SearchResultState.error) {
        return Center(child: Text(state.message));
      } else {
        return const Center(child: Text(''));
      }
    },
  );
}

Widget buildRestaurantItem(BuildContext context, RestaurantSearch restaurant) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return RestaurantDetailPage(idResto: restaurant.id);
      }));
    },
    child: Stack(
      children: <Widget>[
        Container(
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
