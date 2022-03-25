import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restouran_app/data/model/restaurant_list.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String _category = 'list';

  Future<RestaurantResult> topHeadlines() async {
    final response = await http.get(Uri.parse(_baseUrl + _category));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
