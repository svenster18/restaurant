import 'package:mocktail/mocktail.dart';
import 'package:restaurant/data/api/api_service.dart';
import 'package:restaurant/data/model/restaurant.dart';
import 'package:restaurant/data/model/restaurant_list_response.dart';
import 'package:restaurant/provider/home/restaurant_list_provider.dart';
import 'package:restaurant/static/restaurant_list_result_state.dart';
import 'package:test/test.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late MockApiServices apiServices;
  late RestaurantListProvider restaurantListProvider;
  RestaurantListResponse restaurantListResponseSuccess = RestaurantListResponse(
    error: false,
    message: "success",
    count: 1,
    restaurants: [
      Restaurant(
        id: "rqdv5juczeskfw1e867",
        name: "Melting Pot",
        description:
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
        pictureId: "14",
        city: "Medan",
        rating: 4.2,
      ),
    ],
  );

  const String restaurantListResponseError = "Failed to load restaurant list";

  setUp(() {
    apiServices = MockApiServices();
    restaurantListProvider = RestaurantListProvider(apiServices);
  });

  group("restaurant list provider", () {
    test('should return RestaurantListNonSate when provider initialize.', () {
      final initState = restaurantListProvider.resultState;

      expect(initState, RestaurantListNoneState());
    });

    test(
      'should return restaurant list when get restaurant list success.',
      () async {
        when(() => apiServices.getRestaurantList())
            .thenAnswer((_) async => restaurantListResponseSuccess);

        await restaurantListProvider.fetchRestaurantList();
        final state = restaurantListProvider.resultState;

        expect(state, isA<RestaurantListLoadedState>());
        final loadedState = state as RestaurantListLoadedState;
        expect(loadedState.data, restaurantListResponseSuccess.restaurants);
      },
    );

    test(
      'should return "Failed to load restaurant list" when get restaurant list failed', () async {
        when(() => apiServices.getRestaurantList())
            .thenThrow(Exception(restaurantListResponseError));

        await restaurantListProvider.fetchRestaurantList();
        final state = restaurantListProvider.resultState;

        expect(state, isA<RestaurantListErrorState>());
        final errorState = state as RestaurantListErrorState;
        expect(errorState.error, "Exception: $restaurantListResponseError");
    });
  });
}
