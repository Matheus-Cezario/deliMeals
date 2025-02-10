import 'package:deli_meals/components/meal_item.dart';
import 'package:deli_meals/models/category.dart';
import 'package:deli_meals/models/meal.dart';
import 'package:flutter/material.dart';

class CategoriesMealsPage extends StatelessWidget {
  final List<Meal> meals;
  const CategoriesMealsPage({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    final Category category =
        ModalRoute.of(context)?.settings.arguments as Category;
    final categoryMeals = meals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (ctx, index) {
          return MealItem(
            meal: categoryMeals[index],
          );
        },
      ),
    );
  }
}
