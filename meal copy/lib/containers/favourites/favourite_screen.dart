import 'package:flutter/material.dart';
import 'package:meal_app/containers/meals/meal_item.dart';
import 'package:meal_app/models/meal.dart';

class FavouriteScreen extends StatelessWidget {
  final List<Meal> favouriteMeal;
  const FavouriteScreen({
    Key? key,
    required this.favouriteMeal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: favouriteMeal.isEmpty
          ? const Center(
              child: Text(
                  'You dont have any favourite meal yet. Try to add new one'),
            )
          : ListView.builder(
              itemBuilder: ((context, index) => MealItem(
                    imgUrl: favouriteMeal[index].imageUrl,
                    title: favouriteMeal[index].title,
                    duration: favouriteMeal[index].duration,
                    complexity: favouriteMeal[index].complexity,
                    affordability: favouriteMeal[index].affordability,
                    id: favouriteMeal[index].id,
                  )),
              itemCount: favouriteMeal.length),
    );
  }
}
