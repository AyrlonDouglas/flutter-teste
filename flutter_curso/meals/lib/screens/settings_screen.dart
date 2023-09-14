import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/models/settings.dart';

class SettingsScreen extends StatefulWidget {
  final Function(Settings) onSettingsChanged;
  final Settings settings;

  const SettingsScreen(
      {super.key, required this.onSettingsChanged, required this.settings});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var settings = Settings();

  @override
  void initState() {
    settings = widget.settings;
    super.initState();
  }

  Widget _createSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required void Function(bool) onChanged,
  }) {
    return SwitchListTile.adaptive(
      title: Text(title),
      value: value,
      subtitle: Text(subtitle),
      onChanged: (value) {
        onChanged(value);
        widget.onSettingsChanged(settings);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Configurações',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _createSwitch(
                title: 'Sem glútem',
                subtitle: 'Só exibe refeições sem glútem',
                value: settings.isGlutenFree,
                onChanged: (value) =>
                    setState(() => settings.isGlutenFree = value),
              ),
              _createSwitch(
                title: 'Lactose glútem',
                subtitle: 'Só exibe refeições sem lactose',
                value: settings.isLactoseFree,
                onChanged: (value) =>
                    setState(() => settings.isLactoseFree = value),
              ),
              _createSwitch(
                title: 'Vegana',
                subtitle: 'Só exibe refeições veganas',
                value: settings.isVegan,
                onChanged: (value) => setState(() => settings.isVegan = value),
              ),
              _createSwitch(
                title: 'Vegeriana',
                subtitle: 'Só exibe refeições vegerarianas',
                value: settings.isVegetarian,
                onChanged: (value) {
                  setState(() => settings.isVegetarian = value);
                },
              ),
            ],
          ))
        ],
      ),
    );
  }
}
