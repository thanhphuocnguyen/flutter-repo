import 'package:flutter/material.dart';
import 'package:meal_app/containers/categoires/cateogory_item.dart';
import 'package:meal_app/dummy/feed_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: <Widget>[
        ...DUMMY_CATEGORIES
            .map((e) => CategoryItem(
                  key: ValueKey(e.id),
                  color: e.color,
                  title: e.title,
                  id: e.id,
                ))
            .toList()
      ],
    );
  }
}
