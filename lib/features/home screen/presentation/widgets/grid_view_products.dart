import 'package:ecommers_app/features/home%20screen/data/models/product_model.dart';
import 'package:ecommers_app/features/home%20screen/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';

class GridViewProducts extends StatelessWidget {
  const GridViewProducts({super.key, required this.allProducts});

  final List<ProductModel> allProducts;

  @override
  Widget build(BuildContext context) {
    return (allProducts.isNotEmpty)
        ? GridView.builder(
            padding: EdgeInsets.all(12),
            itemCount: allProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final product = allProducts[index];

              return ProductCard(product: product);
            },
          )
        : Center(child: Text("The Empty Product"));
  }
}
