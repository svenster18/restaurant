import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/data/model/add_review.dart';
import 'package:restaurant/data/model/restaurant_detail.dart';
import 'package:restaurant/screen/detail/review_list_widget.dart';

import '../../provider/review/review_provider.dart';
import '../../static/add_review_result_state.dart';

class Review extends StatefulWidget {
  final RestaurantDetail restaurant;

  const Review({super.key, required this.restaurant});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Review",
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: "Name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        TextField(
          controller: _reviewController,
          keyboardType: TextInputType.multiline,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "Review",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        FilledButton(
          onPressed: () {
            if (_nameController.text.isEmpty ||
                _reviewController.text.isEmpty) {
              SnackBar(content: Text("Please fill all fields"));
              return;
            }
            Future.microtask(() {
              if (context.mounted) {
                context.read<ReviewProvider>().addReview(
                  AddReview(
                    id: widget.restaurant.id,
                    name: _nameController.text,
                    review: _reviewController.text,
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Review added successfully")),
                );
                _nameController.clear();
                _reviewController.clear();
              }
            });
          },
          child: Text("Submit"),
        ),
        const SizedBox(height: 16.0),
        Consumer<ReviewProvider>(
          builder: (context, value, child) {
            return switch (value.resultState) {
              AddReviewNoneState() => ReviewList(
                reviewList: widget.restaurant.customerReviews,
              ),
              AddReviewLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
              AddReviewLoadedState(data: var reviewList) => ReviewList(
                reviewList: reviewList,
              ),
              AddReviewErrorState(error: var message) => Text(message),
            };
          },
        ),
      ],
    );
  }
}
