import 'package:flutter/material.dart';
import 'package:restaurant/screen/home/icon_text_widget.dart';
import 'package:restaurant/static/endpoint.dart';

import '../../data/model/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final Function() onTap;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 80,
                minHeight: 80,
                maxWidth: 120,
                maxHeight: 120,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  "${Endpoint.smallImage.url}${restaurant.pictureId}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox.square(dimension: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox.square(dimension: 4.0),
                  IconText(
                    icon: const Icon(Icons.pin_drop, color: Colors.grey),
                    text: Text(
                      restaurant.city,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                  ),
                  const SizedBox.square(dimension: 6.0),
                  IconText(
                    icon: const Icon(Icons.star, color: Colors.yellow),
                    text: Text(
                      restaurant.rating.toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
