import 'package:flutter/material.dart';
import 'package:restaurant/data/model/customer_review.dart';

class ReviewCard extends StatelessWidget {
  final CustomerReview customerReview;

  const ReviewCard({super.key, required this.customerReview});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              customerReview.name,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              customerReview.date,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
            SizedBox(height: 16.0),
            Text('"${customerReview.review}"'),
          ],
        ),
      ),
    );
  }
}
