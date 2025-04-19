import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_screenapp/provider/meals_provider.dart';

enum Filter {
  glutenfree,
  lactoseFree,
  vegetarian,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenfree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
        });

  void setFilters(Map<Filter, bool> chosenFilter, bool ischecked) {
    state = chosenFilter;
  }

  void setfilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) => FilterNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activeFilters[Filter.glutenfree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
