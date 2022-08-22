import 'package:flutter/material.dart';
import 'package:meal_app/containers/meals/meal_item.dart';
import 'package:meal_app/models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = "/category-meals";

  const CategoryMealsScreen({Key? key, required this.availableMeals})
      : super(key: key);
  final List<Meal> availableMeals;
  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  // final String title;
  String title = "";
  List<Meal> categoryMeals = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    title = routeArgs['title'];
    final id = routeArgs['id'];
    categoryMeals = [
      ...categoryMeals,
      ...widget.availableMeals
          .where((element) => element.categories.contains(id))
          .toList()
    ];
    super.didChangeDependencies();
  }

  void _removeMeal(id) {
    setState(() {
      categoryMeals.removeWhere((meal) => meal.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title recipes'),
        elevation: 5,
      ),
      body: ListView.builder(
          itemBuilder: ((context, index) => MealItem(
                imgUrl: categoryMeals[index].imageUrl,
                title: categoryMeals[index].title,
                duration: categoryMeals[index].duration,
                complexity: categoryMeals[index].complexity,
                affordability: categoryMeals[index].affordability,
                id: categoryMeals[index].id,
                removeMeal: _removeMeal,
              )),
          itemCount: categoryMeals.length),
    );
  }
}
