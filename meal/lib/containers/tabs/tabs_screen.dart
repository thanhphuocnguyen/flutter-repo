import 'package:flutter/material.dart';
import 'package:meal_app/containers/categoires/categories.dart';
import 'package:meal_app/containers/drawer/main_drawer.dart';
import 'package:meal_app/containers/favourites/favourite_screen.dart';
import 'package:meal_app/models/meal.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key, required this.favouriteMeal}) : super(key: key);
  final List<Meal> favouriteMeal;
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages = [];

  @override
  void initState() {
    _pages = [
      {'page': const CategoriesScreen(), 'title': 'Categories'},
      {
        'page': FavouriteScreen(
          favouriteMeal: widget.favouriteMeal,
        ),
        'title': 'My favourite'
      },
    ];
    super.initState();
  }

  int _index = 0;
  void _selectPage(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_index]['title'] as String),
      ),
      drawer: const MainDrawer(),
      body: _pages[_index]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 4,
        onTap: _selectPage,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        currentIndex: _index,
        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              icon: const Icon(
                Icons.category,
              ),
              label: 'Categories'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              icon: const Icon(
                Icons.start,
              ),
              label: 'Favourites')
        ],
      ),
    );
  }
}
