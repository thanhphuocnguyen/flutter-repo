import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:using_native_device/providers/great_places.dart';
import 'package:using_native_device/screens/add_place_screen.dart';
import 'package:using_native_device/screens/list_place_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlace(),
      child: MaterialApp(
        title: 'Using native deivice',
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            colorScheme: ColorScheme.fromSwatch(
              accentColor: Colors.lime,
              primarySwatch: Colors.teal,
            )),
        home: const ListPlacesScreen(),
        routes: {
          AddPlaceScreen.routeName: ((context) => const AddPlaceScreen()),
        },
      ),
    );
  }
}
