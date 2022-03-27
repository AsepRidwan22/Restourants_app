import 'dart:async';

import 'package:restouran_app/data/api/detail_service_api.dart';
import 'package:restouran_app/data/model/restaurant_detail.dart';
import 'package:flutter/material.dart';

enum DetailResultState { loading, error, noData, hasData }

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
      _state = DetailResultState.loading;
      notifyListeners();
      final detailRestaurant = await apiService.getDetailId(id);
      if (detailRestaurant.error) {
        _state = DetailResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = DetailResultState.hasData;
        notifyListeners();
        return _detailRestaurant = detailRestaurant;
      }
    } catch (e) {
      _state = DetailResultState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }
}
