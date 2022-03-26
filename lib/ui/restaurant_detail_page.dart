import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:restouran_app/data/model/restaurant_detail.dart';
import 'package:restouran_app/widget/restaurant_detail.dart';
import 'package:restouran_app/cummon/style.dart';
import 'package:provider/provider.dart';
import 'package:restouran_app/provider/restaurant_detail.dart';
import 'package:restouran_app/data/api/detail_service_api.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restauran_detail';
  final String id_resto;
  RestaurantDetailPage({required this.id_resto});

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
        create: (_) => DetailRestaurantProvider(
            apiService: DetailApiService(), id: id_resto),
        child: Consumer<DetailRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == DetailResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == DetailResultState.HasData) {
              final restaurants = state.result.restaurants;
              return RestaurantDetail(
                restaurant: restaurants,
              );
            } else if (state.state == DetailResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == DetailResultState.Error) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}
