import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restouran_app/data/model/restaurant_list.dart';
import 'package:restouran_app/data/model/restaurant_search.dart';
import 'package:restouran_app/data/model/restaurant_detail.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantResult> topHeadlines() async {
    final response = await http.get(Uri.parse(_baseUrl + 'list'));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<SearchRestaurantResult> getTextField(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + "search?q=$query"));
    if (response.statusCode == 200) {
      return SearchRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<DetailRestaurantResult> getDetailId(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + 'detail/' + id));
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
