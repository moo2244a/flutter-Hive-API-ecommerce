import 'package:ecommers_app/features/category%20screen/presentation/screens/category_screen.dart';
import 'package:ecommers_app/features/home%20screen/data/models/categorys_model.dart';
import 'package:ecommers_app/features/home%20screen/presentation/widgets/category_item.dart';
import 'package:flutter/material.dart';

class CategorysListView extends StatelessWidget {
  const CategorysListView({super.key, required this.allCategorys});
  final List<CategoryModel> allCategorys;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: allCategorys.length,
      itemBuilder: (context, index) {
        final category = allCategorys[index];
        return CategoryItem(
          categoryModel: category,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return CategoryScreen(categoryModel: category);
                },
              ),
            );
          },
        );
      },
    );
  }
}
