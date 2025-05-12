import 'package:equatable/equatable.dart';

import '../data/model/restaurant.dart';

sealed class RestaurantListResultState extends Equatable {}

class RestaurantListNoneState extends RestaurantListResultState {

  @override
  List<Object?> get props => [];
}

class RestaurantListLoadingState extends RestaurantListResultState {

  @override
  List<Object?> get props => [];
}

class RestaurantListErrorState extends RestaurantListResultState {
  final String error;

  RestaurantListErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class RestaurantListLoadedState extends RestaurantListResultState {
  final List<Restaurant> data;

  RestaurantListLoadedState(this.data);

  @override
  List<Object?> get props => [data];
}
