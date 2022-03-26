import 'dart:async';

import 'package:restouran_app/data/api/search_service_api.dart';
import 'package:restouran_app/data/model/restaurant_list.dart';
import 'package:flutter/material.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  final SearchApiService apiService;
  final String search;

  RestaurantProvider({required this.apiService, required this.search}) {
    _fetchAllRestaurant(search);
  }

  late RestaurantResult _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantResult get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant(String search) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.getTextField(search);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
