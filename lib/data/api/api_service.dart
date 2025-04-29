import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant/data/model/add_review.dart';
import 'package:restaurant/data/model/add_review_response.dart';
import 'package:restaurant/data/model/restaurant_detail_response.dart';
import 'package:restaurant/data/model/restaurant_list_response.dart';
import 'package:restaurant/data/model/restaurant_search_response.dart';

class ApiServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/";

  Future<RestaurantListResponse> getRestaurantList() async {
    var response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load restaurant list");
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load restaurant detail");
    }
  }

  Future<RestaurantSearchResponse> searchRestaurant(String query) async {
    var response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));

    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load restaurant list");
    }
  }

  Future<AddReviewResponse> addReview(AddReview review) async {
    var response = await http.post(
      Uri.parse("$_baseUrl/review"),
      body: review.toJson(),
    );

    if (response.statusCode == 201) {
      return AddReviewResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to add review");
    }
  }
}
