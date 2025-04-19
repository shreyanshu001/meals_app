import 'package:flutter/material.dart';
import 'package:multi_screenapp/modells/meal.dart';
import 'package:multi_screenapp/screens/meal_detail.dart';
import 'package:multi_screenapp/widgets/meal_item.dart';

class Mealsscreen extends StatelessWidget {
  const Mealsscreen({super.key, this.title, required this.meals});
  final String? title;
  final List<Meal> meals;
  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'uh oh...nothing to show here',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.surface),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'try selecting a different category..',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.surface),
          )
        ],
      ),
    );
    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          onSelectMeal: (buildContext, meal) {
            selectMeal(buildContext, meal);
          },
        ),
      );
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
