import 'package:flutter/material.dart';
import 'package:restouran_app/data/model/restaurant_list.dart';
import 'package:restouran_app/widget/restaurant_detail.dart';
import 'package:provider/provider.dart';
import 'package:restouran_app/provider/restaurant_detail.dart';
import 'package:restouran_app/data/api/service_api.dart';
import 'package:restouran_app/cummon/constant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restauran_detail';
  final String idResto;
  final Restaurantlist? restaurantlist;

  const RestaurantDetailPage(
      {Key? key, required this.idResto, this.restaurantlist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          "Restaurant App",
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: ChangeNotifierProvider<DetailRestaurantProvider>(
        create: (_) =>
            DetailRestaurantProvider(apiService: ApiService(), id: idResto),
        child: Consumer<DetailRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              return RestaurantDetail(
                restaurant: state.result.restaurants,
                restaurantlist: restaurantlist!,
              );
            } else if (state.state == ResultState.noData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.error) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}
