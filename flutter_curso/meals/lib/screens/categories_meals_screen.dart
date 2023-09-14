import 'package:flutter/material.dart';
import 'package:meals/components/meal_item.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

class CategoriesMealsScreen extends StatelessWidget {
  final List<Meal> meals;

  const CategoriesMealsScreen({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    final Category category =
        ModalRoute.of(context)?.settings.arguments as Category;

    final categoryMeals =
        meals.where((meal) => meal.categories.contains(category.id)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(meal: categoryMeals[index]);
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
