import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_screenapp/data/dummy_data.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});
