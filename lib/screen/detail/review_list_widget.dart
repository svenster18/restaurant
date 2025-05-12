import 'package:flutter/material.dart';
import 'package:restaurant/screen/detail/review_card_widget.dart';

import '../../data/model/customer_review.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({super.key, required this.reviewList});

  final List<CustomerReview> reviewList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: reviewList.length,
        itemBuilder: (context, index) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 300,
              minHeight: 130,
              maxWidth: 300,
              maxHeight: 150,
            ),
            child: ReviewCard(customerReview: reviewList[index]),
          );
        },
      ),
    );
  }
}
