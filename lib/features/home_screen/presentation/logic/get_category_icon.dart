import 'package:ecommers_app/features/home_screen/presentation/logic/category_icons.dart';
import 'package:flutter/material.dart';

IconData getCategoryIcon(String category) {
  return categoryIcons[category] ?? Icons.category;
}
