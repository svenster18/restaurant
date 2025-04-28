import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/provider/home/restaurant_list_provider.dart';
import 'package:restaurant/screen/home/restaurant_card_widget.dart';
import 'package:restaurant/static/navigation_route.dart';
import 'package:restaurant/static/restaurant_list_result_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  String query = "";

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (context.mounted) {
        context.read<RestaurantListProvider>().fetchRestaurantList();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Restaurant"),
            Text(
              "Recommendation restaurant for you!",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      body: Consumer<RestaurantListProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantListLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            RestaurantListLoadedState(data: var restaurantList) =>
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SearchBar(
                        controller: _controller,
                        elevation: WidgetStateProperty.all(0.0),
                        hintText: "Search",
                        trailing: [
                          IconButton(onPressed: () {
                            Future.microtask(() {
                              if (context.mounted) {
                                if (_controller.text.isEmpty) {
                                  context.read<RestaurantListProvider>().fetchRestaurantList();
                                } else {
                                  context.read<RestaurantListProvider>().searchRestaurant(_controller.text);
                                }
                              }
                            });
                            FocusManager.instance.primaryFocus?.unfocus();
                          }, icon: Icon(Icons.search))
                        ],
                        onSubmitted: (String text) {
                          Future.microtask(() {
                            if (context.mounted) {
                              if (text.isEmpty) {
                                context.read<RestaurantListProvider>().fetchRestaurantList();
                              } else {
                                context.read<RestaurantListProvider>().searchRestaurant(text);
                              }
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  SliverList.builder(
                    itemCount: restaurantList.length,
                    itemBuilder: (context, index) {
                      final restaurant = restaurantList[index];

                      return RestaurantCard(
                        restaurant: restaurant,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            NavigationRoute.detailRoute.name,
                            arguments: restaurant.id,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            RestaurantListErrorState(error: var message) => Center(
              child: Text(message),
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
