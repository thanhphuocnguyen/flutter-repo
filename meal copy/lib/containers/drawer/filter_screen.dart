import 'package:flutter/material.dart';
import 'package:meal_app/containers/drawer/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen(
      {Key? key, required this.saveFilter, required this.initFilters})
      : super(key: key);
  static const routeName = '/filters';
  final Function saveFilter;
  final Map<String, bool> initFilters;
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFree = false;
  var _vegan = false;
  var _vegetarian = false;
  var _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.initFilters['gluten']!;
    _vegan = widget.initFilters['vegan']!;
    _vegetarian = widget.initFilters['vegetarian']!;
    _lactoseFree = widget.initFilters['lactose']!;
    super.initState();
  }

  Widget buildSwitchList(
      String title, bool value, Function onChange, String subtitle) {
    return SwitchListTile(
      title: Text(
        title,
      ),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (val) {
        onChange(val);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filters"),
        actions: [
          IconButton(
              onPressed: () => widget.saveFilter({
                    'gluten': _glutenFree,
                    'lactose': _lactoseFree,
                    'vegan': _vegan,
                    'vegetarian': _vegetarian,
                  }),
              icon: const Icon(Icons.save))
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              buildSwitchList(
                'Gluten-free',
                _glutenFree,
                (val) => setState((() => _glutenFree = val)),
                'Only include gluten-free meals',
              ),
              buildSwitchList(
                'Vegetarian',
                _vegetarian,
                (val) => setState((() => _vegetarian = val)),
                'Only include vegetarian meals',
              ),
              buildSwitchList(
                'Vegan',
                _vegan,
                (val) => setState((() => _vegan = val)),
                'Only include vegan meals',
              ),
              buildSwitchList(
                'Lactose-free',
                _lactoseFree,
                (val) => setState((() => _lactoseFree = val)),
                'Only include lactose-free meals',
              ),
            ],
          ))
        ],
      ),
    );
  }
}
