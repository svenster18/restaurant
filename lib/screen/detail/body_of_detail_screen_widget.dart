import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/data/model/restaurant_detail.dart';
import 'package:restaurant/screen/detail/menus_card_widget.dart';
import 'package:restaurant/screen/home/icon_text_widget.dart';
import 'package:restaurant/static/endpoint.dart';

class BodyOfDetailScreenWidget extends StatelessWidget {
  const BodyOfDetailScreenWidget({super.key, required this.restaurant});

  final RestaurantDetail restaurant;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
          ),
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: FlexibleSpaceBar(
            background: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: Hero(
                tag: restaurant.pictureId,
                child: Image.network(
                  "${Endpoint.mediumImage.url}${restaurant.pictureId}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 8.0),
                IconText(
                  icon: Icon(Icons.pin_drop, color: Colors.grey),
                  text: Text(
                    "${restaurant.address}, ${restaurant.city}",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 8.0),
                IconText(
                  icon: Icon(Icons.star, color: Colors.yellow),
                  text: Text(
                    "${restaurant.rating}",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: restaurant.categories.length,
                    itemBuilder: (context, index) {
                      return MenusCard(menus: restaurant.categories[index]);
                    },
                  ),
                ),
                const SizedBox(height: 24.0),
                Text(
                  "Description",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8.0),
                Text(
                  restaurant.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 24.0),
                Text("Menus", style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold
                )),
                const SizedBox(height: 16.0),
                Text("Foods", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: restaurant.menus.foods.length,
                    itemBuilder: (context, index) {
                      return MenusCard(menus: restaurant.menus.foods[index]);
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Text("Drinks", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: restaurant.menus.drinks.length,
                    itemBuilder: (context, index) {
                      return MenusCard(menus: restaurant.menus.drinks[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
