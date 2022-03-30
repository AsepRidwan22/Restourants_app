import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restouran_app/data/api/service_api.dart';
import 'package:restouran_app/provider/restaurant_search.dart';
import 'package:restouran_app/widget/card_search.dart';
import 'package:restouran_app/cummon/constant.dart';

class RestaurantSearchPage extends StatefulWidget {
  const RestaurantSearchPage({Key? key}) : super(key: key);
  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  TextEditingController controller = TextEditingController();
  String hasil = "";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchRestaurantProvider>(
      create: (_) => SearchRestaurantProvider(apiService: ApiService()),
      child: Consumer<SearchRestaurantProvider>(builder: (context, state, _) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Positioned(
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 10),
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
                    ? const Center(
                        child: Text('Tuliskan apa yang ingin dicari!'),
                      )
                    : Consumer<SearchRestaurantProvider>(
                        builder: (context, state, _) {
                          if (state.state == ResultState.loading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state.state == ResultState.hasData) {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.result!.restaurants.length,
                              itemBuilder: (context, index) {
                                var restaurant =
                                    state.result!.restaurants[index];
                                return CardSearch(restaurant: restaurant);
                              },
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
              ],
            ),
          ),
        );
      }),
    );
  }
}
