import 'package:restaurant/data/model/restaurant.dart';

import 'category.dart';
import 'customer_review.dart';
import 'menus.dart';

class RestaurantDetail extends Restaurant {
  final String address;
  final List<Category> categories;
  final Menus menus;
  final List<CustomerReview> customerReviews;


  RestaurantDetail({required super.id, required super.name, required super.description, required super.city, required super.pictureId, required super.rating, required this.address, required this.categories, required this.menus,
      required this.customerReviews});

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) => RestaurantDetail(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    city: json["city"],
    address: json["address"],
    pictureId: json["pictureId"],
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    menus: Menus.fromJson(json["menus"]),
    rating: json["rating"]?.toDouble(),
    customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
  );

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "city": city,
    "address": address,
    "pictureId": pictureId,
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    "menus": menus.toJson(),
    "rating": rating,
    "customerReviews": List<dynamic>.from(customerReviews.map((x) => x.toJson())),
  };
}