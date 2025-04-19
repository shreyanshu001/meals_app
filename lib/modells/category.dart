import 'package:flutter/material.dart';

class Category {
  const Category(
      {this.colour = Colors.orange, required this.id, required this.title});
  final String title;
  final String id;
  final Color colour;
}
