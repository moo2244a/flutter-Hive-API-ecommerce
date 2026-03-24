import 'package:ecommers_app/core/utils/ui_constant.dart';

import 'package:ecommers_app/features/home_screen/data/models/product_model.dart';

import 'package:ecommers_app/features/home_screen/presentation/widgets/grid_view_products.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  void getFavoriteProduct() {
    final box = Hive.box<ProductModel>(UiConstant.nameBoxLove);
    allProductsFavorite = box.values.toList();
  }

  List<ProductModel> allProductsFavorite = [];

  @override
  Widget build(BuildContext context) {
    getFavoriteProduct();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          UiConstant.favoriteScreen,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridViewProducts(
              allProducts: allProductsFavorite,
              isLoading: true,
            ),
          ),
        ],
      ),
    );
  }
}
