import 'package:flutter/material.dart';
import 'package:meal_app/containers/drawer/filter_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);
  Widget _buildListtile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
      onTap: () {
        tapHandler();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        top: false,
        child: Column(children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).colorScheme.secondary,
            alignment: Alignment.centerLeft,
            child: Text(
              'Cooking up',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          _buildListtile('Meal', (Icons.restaurant),
              () => Navigator.of(context).pushReplacementNamed('/')),
          _buildListtile(
              'Filters',
              Icons.settings,
              () => Navigator.of(context)
                  .pushReplacementNamed(FilterScreen.routeName))
        ]),
      ),
    );
  }
}
