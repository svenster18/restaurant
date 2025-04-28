import 'package:flutter/material.dart';

enum RestaurantColors {
  red("Red", Colors.red);

  const RestaurantColors(this.name, this.color);

  final String name;
  final Color color;
}