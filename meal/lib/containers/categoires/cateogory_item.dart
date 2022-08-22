import 'package:flutter/material.dart';
import 'package:meal_app/containers/categoires/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.color,
    required this.title,
    required this.id,
  }) : super(key: key);
  final String title;
  final String id;
  final Color color;

  void _onSelectRecipeItem(BuildContext context) {
    Navigator.of(context).pushNamed(CategoryMealsScreen.routeName, arguments: {
      'title': title,
      'color': color,
      'id': id,
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onSelectRecipeItem(context);
      },
      borderRadius: BorderRadius.circular(15),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.7), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
