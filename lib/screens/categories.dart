import 'package:flutter/material.dart';
import 'package:multi_screenapp/data/dummy_data.dart';
import 'package:multi_screenapp/modells/category.dart';
import 'package:multi_screenapp/modells/meal.dart';
import 'package:multi_screenapp/screens/meals.dart';
import 'package:multi_screenapp/widgets/category_griditem.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 300,
        ),
        lowerBound: 0,
        upperBound: 1);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
//u might recall that in the state objects that belonged to stateful widgets,
// a context property was globally available and could therefore be used in all the methods.
// Here, that's not the case.Therefore, here, we indeed must accept a context value
// which must be of type BuildContext in this select category function here,
// so that we can pass context as a value to push. By the way, alternatively, you can also call Navigator of
// context push and then only pass the route to push.

    final filteredmeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => Mealsscreen(
          title: category.title,
          meals: filteredmeals,
        ),
      ),
    ); //or - navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          for (final category in availableCategories)
            CategoryGriditem(
              category: category,
              onselectcategory: () {
                _selectCategory(context, category);
              },
            )
        ],
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.easeInOut),
        ),
        child: child,
      ),
    );
  }
}
