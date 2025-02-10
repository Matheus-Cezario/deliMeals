import 'package:deli_meals/data/dummy_data.dart';
import 'package:deli_meals/models/meal.dart';
import 'package:deli_meals/models/setteings.dart';
import 'package:deli_meals/pages/categories_meals_page.dart';
import 'package:deli_meals/pages/settings_page.dart';
import 'package:deli_meals/pages/tabs_page.dart';
import 'package:deli_meals/pages/meal_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:deli_meals/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeals = dummyMeals;
  Settings settings = Settings();
  List<Meal> _favoriteMeals = [];

  void _filterMeals(Settings settings) {
    setState(() {
      _availableMeals = dummyMeals.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;

        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
      this.settings = settings;
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    final ColorScheme colorScheme = theme.colorScheme.copyWith(
      primary: Colors.pink,
      secondary: Colors.amber,
    );
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        colorScheme: colorScheme,
        fontFamily: 'Raleway',
        scaffoldBackgroundColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: theme.textTheme.copyWith(
          titleMedium: TextStyle(
            fontSize: MediaQuery.of(context).textScaler.scale(20),
            fontFamily: 'RobotoCondensed',
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: colorScheme.primary,
          unselectedItemColor: Colors.white,
          selectedItemColor: colorScheme.secondary,
        ),
        appBarTheme: AppBarTheme(
          color: colorScheme.primary,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).textScaler.scale(22),
            fontFamily: 'RobotoCondensed',
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colorScheme.secondary,
          shape: CircleBorder(),
        ),
      ),
      routes: {
        AppRoutes.CATEGORIES_HOME: (ctx) => TabsPage(
              favoriteMeals: _favoriteMeals,
            ),
        AppRoutes.CATEGORIES_MEALS: (ctx) => CategoriesMealsPage(
              meals: _availableMeals,
            ),
        AppRoutes.MEAL_DETAIL: (ctx) => MealDetailPage(
              toggleFavorite: _toggleFavorite,
              isFavorite: _isFavorite,
            ),
        AppRoutes.SETTINGS: (ctx) => SettingsPage(
              onSettingsChange: _filterMeals,
              settings: settings,
            ),
      },
    );
  }
}
