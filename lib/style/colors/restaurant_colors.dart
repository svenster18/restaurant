import 'package:flutter/material.dart';

enum RestaurantColors {
  blue("Red", Colors.blue);

  const RestaurantColors(this.name, this.color);

  final String name;
  final Color color;
}
