import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_screenapp/modells/meal.dart';

class FavouriteMealsNotifier extends StateNotifier<
    List<
        Meal>> //this extended class is the class works with StateNotifierProvider() class-line 17th, it is extended by ur class name.
//it is a generic class so we need to tell which type of data will be managed by this class.
{
  //you're not allowed to edit an existing value in memory, instead you must always create a new one.
  // That's simply a pattern enforced by this package. Therefore, we're not allowed to reach out to this list and call add or remove as we did before. This would not be allowed.
  FavouriteMealsNotifier() : super([]);
  bool toggleMealFavouriteStatus(Meal meal) {
    final mealIsFavourite = state.contains(meal);
    if (mealIsFavourite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
      //three dot is used to add iterables to a list.
    }
  }
}

final FavouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) {
  return FavouriteMealsNotifier();
});//StateNotifierProvider() is a class we use in place of provider class if data is dynamic and can change.

