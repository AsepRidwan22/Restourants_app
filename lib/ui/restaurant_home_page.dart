import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:restouran_app/data/model/restaurant_list.dart';
import 'package:restouran_app/widget/bottom_navbar.dart';
import 'package:restouran_app/widget/detail_page.dart';
import 'package:restouran_app/cummon/style.dart';
import 'package:provider/provider.dart';
import 'package:restouran_app/provider/restaurant_list.dart';
import 'package:restouran_app/widget/list_card_restaurant.dart';
import 'package:restouran_app/data/api/service_api.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restauran_list';

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
      body: ChangeNotifierProvider<RestaurantProvider>(
        create: (_) => RestaurantProvider(apiService: ApiService()),
        child: Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.result.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = state.result.restaurants[index];
                  return CardRestaurant(restaurant: restaurant);
                },
              );
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.Error) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text(''));
            }
          },
        ),
      ),
      // bottomNavigationBar: BottomNavBar(),
    );
  }
}
