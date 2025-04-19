import 'package:flutter/material.dart';
import 'package:multi_screenapp/modells/category.dart';

class CategoryGriditem extends StatelessWidget {
  const CategoryGriditem(
      {super.key, required this.category, required this.onselectcategory});
  final Category category;
  final void Function() onselectcategory;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onselectcategory,
      splashColor: Theme.of(context).secondaryHeaderColor,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(colors: [
            category.colour.withOpacity(0.55),
            category.colour.withOpacity(0.9),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Text(
          category.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.surface),
        ),
      ),
    );
  }
}
