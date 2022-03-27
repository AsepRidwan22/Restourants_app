import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:restouran_app/cummon/style.dart';
import 'package:provider/provider.dart';
import 'package:restouran_app/data/api/search_service_api.dart';
import 'package:restouran_app/data/model/restaurant_list.dart';
import 'package:restouran_app/provider/restaurant_list.dart';
import 'package:restouran_app/data/api/service_api.dart';
import 'package:restouran_app/provider/restaurant_search.dart';
import 'package:restouran_app/widget/card_search.dart';
import 'package:restouran_app/widget/restaurant_list.dart';

class RestaurantSearchPage extends StatefulWidget {
  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  TextEditingController controller = TextEditingController();
  String hasil = "";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchRestaurantProvider>(
      create: (_) => SearchRestaurantProvider(apiService: SearchApiService()),
      child: Consumer<SearchRestaurantProvider>(builder: (context, state, _) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Positioned(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(15.0),
                    padding: EdgeInsets.only(left: 20, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Colors.grey.shade500.withOpacity(0.23))
                        ]),
                    child: TextField(
                      controller: controller,
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.23)),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      onChanged: (String query) {
                        if (query.isNotEmpty) {
                          setState(() {
                            hasil = query;
                          });
                          state.fetchAllRestaurant(hasil);
                        }
                      },
                    ),
                  ),
                ),
                (hasil.isEmpty)
                    ? Center(
                        child: Text('Tuliskan apa yang ingin dicari!'),
                      )
                    : Consumer<SearchRestaurantProvider>(
                        builder: (context, state, _) {
                          if (state.state == SearchResultState.Loading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state.state == SearchResultState.HasData) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.result!.restaurants.length,
                              itemBuilder: (context, index) {
                                var restaurant =
                                    state.result!.restaurants[index];
                                return CardSearch(restaurant: restaurant);
                              },
                            );
                          } else if (state.state == SearchResultState.NoData) {
                            return Center(child: Text(state.message));
                          } else if (state.state == SearchResultState.Error) {
                            return Center(child: Text(state.message));
                          } else {
                            return Center(child: Text(''));
                          }
                        },
                      ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
