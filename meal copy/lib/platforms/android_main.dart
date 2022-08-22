import 'package:flutter/material.dart';
import 'package:meal_app/containers/categoires/categories.dart';
import 'package:meal_app/containers/categoires/category_meals_screen.dart';
import 'package:meal_app/containers/drawer/filter_screen.dart';
import 'package:meal_app/containers/meals/meal_detail_screen.dart';
import 'package:meal_app/containers/tabs/tabs_screen.dart';
import 'package:meal_app/dummy/feed_data.dart';
import 'package:meal_app/models/meal.dart';

class AndroidHome extends StatefulWidget {
  const AndroidHome({Key? key}) : super(key: key);

  @override
  State<AndroidHome> createState() => _AndroidHomeState();
}

class _AndroidHomeState extends State<AndroidHome> {
  List<Meal> _availableMeals = DUMMY_MEALS;
  final List<Meal> _favouriteMeal = [];
  Map<String, bool> _filters = {
    'vegan': false,
    'vegetarian': false,
    'lactose': false,
    'gluten': false,
  };
  void _saveFilter(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((element) {
        if (_filters['gluten']! && !element.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !element.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !element.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !element.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final existingMeal =
        _favouriteMeal.indexWhere((element) => element.id == mealId);
    if (existingMeal > -1) {
      setState(() {
        _favouriteMeal.removeAt(existingMeal);
      });
    } else {
      setState(() {
        _favouriteMeal
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool _isMealFavourite(String mealId) {
    return _favouriteMeal.any((element) => element.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DeliMeals",
      theme: ThemeData(
          primaryColor: Colors.brown.shade50,
          primarySwatch: Colors.green,
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline6: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
                headline5: const TextStyle(
                  fontSize: 26,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
          colorScheme: ColorScheme(
            secondary: Colors.red.shade200,
            background: Colors.indigo.shade500,
            brightness: Brightness.light,
            error: Colors.red.shade700,
            onBackground: Colors.indigo.shade100,
            primary: Colors.indigo.shade400,
            onError: Colors.red.shade700,
            onPrimary: Colors.white,
            onSecondary: Colors.indigo.shade400,
            onSurface: Colors.white,
            surface: Colors.white,
          )),
      initialRoute: "/",
      routes: {
        '/': (context) => TabsScreen(favouriteMeal: _favouriteMeal),
        CategoryMealsScreen.routeName: ((context) => CategoryMealsScreen(
              availableMeals: _availableMeals,
            )),
        MealDetailScreen.routeName: (context) => MealDetailScreen(
            toggleFavourite: _toggleFavourite, isFavourite: _isMealFavourite),
        FilterScreen.routeName: (context) => FilterScreen(
              saveFilter: _saveFilter,
              initFilters: _filters,
            ),
      },
      onGenerateRoute: ((settings) {
        return MaterialPageRoute(
          builder: ((context) => const CategoriesScreen()),
        );
      }),
      onUnknownRoute: (settings) => MaterialPageRoute(
          builder: ((context) => Image.asset('assets/images/404.png'))),
      // Scaffold(
      //   appBar: AppBar(
      //     title: const Text("Deli Meals"),
      //   ),
      //   body: const Center(child: MyHomePage()),
      // ),
    );
  }
}
