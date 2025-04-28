import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/model/category.dart';

class MenusCard extends StatelessWidget {
  final Category menus;

  const MenusCard({super.key, required this.menus});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Center(child: Text(menus.name,
          style: Theme.of(context).textTheme.bodyMedium,
        ),)
      ),
    );
  }
}
