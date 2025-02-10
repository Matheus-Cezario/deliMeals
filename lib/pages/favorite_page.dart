import 'package:deli_meals/components/meal_item.dart';
import 'package:deli_meals/models/meal.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const FavoritePage({super.key, required this.favoriteMeals});

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text('Nenhuma refeição foi marcada como favorita!'),
      );
    }

    return ListView.builder(
      itemCount: favoriteMeals.length,
      itemBuilder: (context, index) {
        return MealItem(meal: favoriteMeals[index]);
      },
    );
  }
}
