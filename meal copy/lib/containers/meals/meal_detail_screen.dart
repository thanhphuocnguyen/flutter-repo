import 'package:flutter/material.dart';
import 'package:meal_app/dummy/feed_data.dart';

class MealDetailScreen extends StatelessWidget {
  final Function toggleFavourite;
  final Function isFavourite;

  const MealDetailScreen({
    Key? key,
    required this.toggleFavourite,
    required this.isFavourite,
  }) : super(key: key);

  static const routeName = '/meal-detail';

  Widget _buildTitleText(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline6,
    );
  }

  Widget _buildContainer(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(10)),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final detail = DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${detail.title} recipe'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(15),
              height: 300,
              width: double.infinity,
              child: Image.network(
                detail.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _buildTitleText(context, 'Ingredients'),
            _buildContainer(
              ListView.builder(
                itemBuilder: ((context, index) => Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      color: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          detail.ingredients[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )),
                itemCount: detail.ingredients.length,
              ),
            ),
            _buildTitleText(context, 'Steps'),
            _buildContainer(
              ListView.builder(
                itemBuilder: ((context, index) => Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Theme.of(context).colorScheme.onBackground,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${index + 1}'),
                      ),
                      title: Text(
                        detail.steps[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ))),
                itemCount: detail.steps.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: isFavourite(mealId)
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border),
        onPressed: () => toggleFavourite(mealId),
        // child: const Icon(Icons.delete),
        // onPressed: () => Navigator.of(context).pop(mealId),
      ),
    );
  }
}
