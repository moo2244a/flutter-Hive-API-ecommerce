import 'package:ecommers_app/core/utils/ui_constant.dart';
import 'package:ecommers_app/features/home_screen/data/models/product_model.dart';
import 'package:ecommers_app/features/home_screen/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GridViewProducts extends StatefulWidget {
  final bool isLoading;
  const GridViewProducts({
    super.key,
    required this.allProducts,
    required this.isLoading,
  });

  final List<ProductModel> allProducts;

  @override
  State<GridViewProducts> createState() => _GridViewProductsState();
}

class _GridViewProductsState extends State<GridViewProducts> {
  @override
  Widget build(BuildContext context) {
    final boxCard = Hive.box<ProductModel>(UiConstant.nameBoxCard);
    return (widget.isLoading)
        ? (widget.allProducts.isNotEmpty)
              ? GridView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: widget.allProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final product = widget.allProducts[index];
                    final boxLove = Hive.box<ProductModel>(
                      UiConstant.nameBoxLove,
                    );
                    bool isContainsKey = boxLove.values.any(
                      (p) => p.id == product.id,
                    );
                    return ProductCard(
                      product: product,
                      isContainsKey: isContainsKey,
                      favoriteIcon: () async {
                        final favIndex = boxLove.values.toList().indexWhere(
                          (p) => p.id == product.id,
                        );

                        if (favIndex != -1) {
                          await boxLove.deleteAt(favIndex);
                        } else {
                          // ✅ COPY بدل نفس الـ instance
                          await boxLove.add(
                            ProductModel(
                              id: product.id,
                              title: product.title,
                              description: product.description,
                              category: product.category,
                              price: product.price,
                              thumbnail: product.thumbnail,
                              images: product.images,
                              quantity: product.quantity,
                            ),
                          );
                        }

                        setState(() {});
                      },

                      // 🛒 Add To Cart
                      iconButtonAdd: () async {
                        final existingIndex = boxCard.values
                            .toList()
                            .indexWhere((p) => p.id == product.id);

                        if (existingIndex != -1) {
                          final existingProduct = boxCard.getAt(existingIndex)!;

                          existingProduct.quantity =
                              (existingProduct.quantity ?? 0) + 1;

                          await existingProduct.save();
                        } else {
                          // ✅ COPY بدل نفس الـ instance
                          await boxCard.add(
                            ProductModel(
                              id: product.id,
                              title: product.title,
                              description: product.description,
                              category: product.category,
                              price: product.price,
                              thumbnail: product.thumbnail,
                              images: product.images,
                              quantity: 1,
                            ),
                          );
                        }

                        setState(() {});
                      },
                    );
                  },
                )
              : Center(child: Text("The Empty Product"))
        : Center(child: CircularProgressIndicator());
  }
}
