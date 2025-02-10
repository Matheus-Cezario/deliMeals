import 'package:deli_meals/components/main_drawer.dart';
import 'package:deli_meals/models/setteings.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final Function(Settings) onSettingsChange;
  final Settings settings;
  const SettingsPage({
    super.key,
    required this.onSettingsChange,
    required this.settings,
  });

  Widget _createSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile.adaptive(
      value: value,
      onChanged: (value) {
        onChanged(value);
        onSettingsChange(settings);
      },
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Configurações',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _createSwitch(
                  'Sem Glutén',
                  'Só exibe refeições sem Glutén',
                  settings.isGlutenFree,
                  (value) {
                    settings.isGlutenFree = value;
                  },
                ),
                _createSwitch(
                  'Sem Lactose',
                  'Só exibe refeições sem Lactose',
                  settings.isLactoseFree,
                  (value) {
                    settings.isLactoseFree = value;
                  },
                ),
                _createSwitch(
                  'Vegana',
                  'Só exibe refeições Veganas',
                  settings.isVegan,
                  (value) {
                    settings.isVegan = value;
                  },
                ),
                _createSwitch(
                  'Vegetariana',
                  'Só exibe refeições Vegetariana',
                  settings.isVegetarian,
                  (value) {
                    settings.isVegetarian = value;
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
