import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    Key? key,
    required this.imgUrl,
    required this.title,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.id,
    this.removeMeal,
  }) : super(key: key);
  final String imgUrl;
  final String title;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final String id;
  final Function? removeMeal;

  String get complexityText {
    String text = 'Unknown';
    switch (complexity) {
      case Complexity.Simple:
        text = 'Simple';
        break;
      case Complexity.Challenging:
        text = 'Challenging';
        break;
      case Complexity.Hard:
        text = 'Hard';
        break;
      default:
        break;
    }
    return text;
  }

  String get affordabilityText {
    String text = 'Unknown';
    switch (affordability) {
      case Affordability.Affordable:
        text = 'Affordable';
        break;
      case Affordability.Pricey:
        text = 'Pricey';
        break;
      case Affordability.Luxurious:
        text = 'Luxurious';
        break;
      default:
        break;
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    void _onSelectRecipe() {
      Navigator.of(context)
          .pushNamed('/meal-detail', arguments: id)
          .then((value) {
        if (value != null) {
          removeMeal!(value);
        }
      });
    }

    return InkWell(
      onTap: () {
        _onSelectRecipe();
      },
      child: Card(
        margin: const EdgeInsets.all(15),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  child: Image.network(imgUrl,
                      height: 250,
                      cacheHeight: 250,
                      width: double.infinity,
                      fit: BoxFit.cover),
                ),
                Positioned(
                  bottom: 15,
                  right: 5,
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black45,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline5,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: <Widget>[
                      const Icon(Icons.schedule),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text('$duration min')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.work),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(complexityText)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.money),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(affordabilityText)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
