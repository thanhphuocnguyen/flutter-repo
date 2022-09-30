import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:using_native_device/providers/great_places.dart';
import 'package:using_native_device/screens/add_place_screen.dart';
import 'package:using_native_device/screens/detail_place_screen.dart';

class ListPlacesScreen extends StatelessWidget {
  const ListPlacesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: <Widget>[
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<GreatPlace>(context, listen: false).fetchAndSetPlaces(),
        builder: ((context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor))
                : Consumer<GreatPlace>(
                    builder: (context, value, ch) => value.places.isEmpty
                        ? ch!
                        : ListView.builder(
                            itemCount: value.places.length,
                            itemBuilder: ((context, index) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(value.places[index].image),
                                  ),
                                  title: Text(value.places[index].title),
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(DetailPlaceScreen.routeName);
                                  },
                                )),
                          ),
                    child: const Center(
                      child: Text('Got no places yet, start adding one'),
                    ),
                  )),
      ),
    );
  }
}
