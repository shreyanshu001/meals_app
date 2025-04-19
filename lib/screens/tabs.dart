import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_screenapp/provider/favourites_provider.dart';
import 'package:multi_screenapp/screens/categories.dart';
import 'package:multi_screenapp/screens/filters.dart';
import 'package:multi_screenapp/provider/filters_provider.dart';
import 'package:multi_screenapp/widgets/drawer.dart';
import 'package:multi_screenapp/screens/meals.dart';

const kInitialFilters = {
  Filter.glutenfree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});
  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const Filters(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'categories';
    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(FavouriteMealsProvider);
      activePage = Mealsscreen(
        meals: favouriteMeals,
      );
      activePageTitle = 'your favourites';
    }
    return Scaffold(
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex:
            _selectedPageIndex, //it is because only first tap was getting highlighted but not second.It is to resolve that problem
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'favourites')
        ],
      ),
    );
  }
}
