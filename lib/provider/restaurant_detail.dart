import 'dart:async';

import 'package:restouran_app/data/api/detail_service_api.dart';
import 'package:restouran_app/data/model/restaurant_detail.dart';
import 'package:flutter/material.dart';

enum DetailResultState { Loading, Error, NoData, HasData }

class DetailRestaurantProvider extends ChangeNotifier {
  final DetailApiService apiService;
  final String id;

  late DetailRestaurantResult _detailRestaurant;
  late DetailResultState _state;
  String _message = '';

  DetailRestaurantProvider({required this.id, required this.apiService}) {
    _getDetailRestaurant(id);
  }

  String get message => _message;
  DetailRestaurantResult get result => _detailRestaurant;
  DetailResultState get state => _state;

  Future<dynamic> _getDetailRestaurant(String id) async {
    try {
      _state = DetailResultState.Loading;
      notifyListeners();
      final detailRestaurant = await apiService.getDetailId(id);
      if (detailRestaurant.error) {
        _state = DetailResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = DetailResultState.HasData;
        notifyListeners();
        return _detailRestaurant = detailRestaurant;
      }
    } catch (e) {
      _state = DetailResultState.Error;
      notifyListeners();
      return _message = e.toString();
    }
  }
}
