import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restouran_app/provider/restaurant_database.dart';
import 'package:restouran_app/cummon/constant.dart';
import 'package:restouran_app/widget/restaurant_list.dart';

class RestaurantFavoritePage extends StatelessWidget {
  const RestaurantFavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              var restaurant = state.favorites[index];
              return RestaurantCardList(
                restaurant: restaurant,
              );
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.error) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }
}
