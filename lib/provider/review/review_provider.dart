import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:restaurant/data/api/api_service.dart';
import 'package:restaurant/data/model/add_review.dart';
import 'package:restaurant/static/add_review_result_state.dart';

class ReviewProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  ReviewProvider(this._apiServices);

  AddReviewResultState _resultState = AddReviewNoneState();

  AddReviewResultState get resultState => _resultState;

  Future<void> addReview(AddReview customerReview) async {
    try {
      _resultState = AddReviewLoadingState();
      notifyListeners();

      final result = await _apiServices.addReview(customerReview);

      if (result.error) {
        _resultState = AddReviewErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = AddReviewLoadedState(result.customerReviews);
        notifyListeners();
      }
    } on SocketException {
      _resultState = AddReviewErrorState("Cannot connect to network, please turn on network settings");
      notifyListeners();
    } on Exception catch (e) {
      _resultState = AddReviewErrorState(e.toString());
      notifyListeners();
    }
  }
}