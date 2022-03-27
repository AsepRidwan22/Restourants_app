import 'dart:async';
import 'package:restouran_app/data/api/search_service_api.dart';
import 'package:restouran_app/data/model/restaurant_search.dart';
import 'package:flutter/material.dart';

enum SearchResultState { Loading, NoData, HasData, Error }

class SearchRestaurantProvider extends ChangeNotifier {
  final SearchApiService apiService;

  SearchRestaurantProvider({required this.apiService}) {
    fetchAllRestaurant(search);
  }

  SearchRestaurantResult? _restaurantResult;
  SearchResultState? _state;
  String _message = '';
  String _search = '';

  String get message => _message;

  SearchRestaurantResult? get result => _restaurantResult;

  String get search => _search;

  SearchResultState? get state => _state;

  Future<dynamic> fetchAllRestaurant(String search) async {
    try {
      if (search.isNotEmpty) {
        _state = SearchResultState.Loading;
        _search = search;
        notifyListeners();
        final restaurant = await apiService.getTextField(search);
        if (restaurant.restaurants.isEmpty) {
          _state = SearchResultState.NoData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _state = SearchResultState.HasData;
          notifyListeners();
          return _restaurantResult = restaurant;
        }
      } else {
        return _message = 'text null';
      }
    } catch (e) {
      _state = SearchResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
