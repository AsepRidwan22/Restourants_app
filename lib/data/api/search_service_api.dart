import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restouran_app/data/model/restaurant_list.dart';

class SearchApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantResult> getTextField(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + "/search?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
