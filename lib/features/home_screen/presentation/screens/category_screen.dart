import 'package:ecommers_app/features/home_screen/data/models/categorys_model.dart';
import 'package:ecommers_app/features/home_screen/data/models/product_model.dart';
import 'package:ecommers_app/features/home_screen/data/repositry/repositry_home.dart';
import 'package:ecommers_app/features/home_screen/presentation/widgets/grid_view_products.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryScreen({super.key, required this.categoryModel});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    getCategorieOfProduct(widget.categoryModel);
  }

  bool isLoading = false;
  List<ProductModel> allProducts = [];
  Future<void> getCategorieOfProduct(CategoryModel categoryModel) async {
    isLoading = false;
    setState(() {});

    allProducts = await RepositryHome.getCategorieOfProduct(categoryModel);

    isLoading = true;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryModel.name,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridViewProducts(
              allProducts: allProducts,
              isLoading: isLoading,
            ),
          ),
        ],
      ),
    );
  }
}
