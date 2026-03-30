import 'package:ecommers_app/core/utils/ui_constant.dart';
import 'package:ecommers_app/features/home%20screen/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CardProvider extends ChangeNotifier {
  Box<ProductModel> getProductsBox() {
    final boxCard = Hive.box<ProductModel>(UiConstant.nameBoxCard);

    return boxCard;
  }

  List<ProductModel> allProductsCard = [];
  List<ProductModel> getProductsCard() {
    allProductsCard = getProductsBox().values.toList();
    return allProductsCard;
  }

  double counterPriceProductInCart() {
    double total = 0;
    for (var product in allProductsCard) {
      total += product.quantity! * product.price;
    }
    return total;
  }

  int calculateProductInCart() {
    final allProductsCard = getProductsCard();
    int total = 0;
    for (var product in allProductsCard) {
      total += product.quantity!;
    }
    return total;
  }

  Future<void> addProductCard({required ProductModel product}) async {
    final boxCard = Hive.box<ProductModel>(UiConstant.nameBoxCard);
    final existingIndex = boxCard.values.toList().indexWhere(
      (p) => p.id == product.id,
    );

    if (existingIndex != -1) {
      final existingProduct = boxCard.getAt(existingIndex)!;

      existingProduct.quantity = (existingProduct.quantity ?? 0) + 1;

      await existingProduct.save();
    } else {
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

    notifyListeners();
  }

  void decreaseCount({required ProductModel product}) {
    final box = getProductsBox();

    int currentQuantity = product.quantity ?? 0;

    if (currentQuantity <= 1) {
      box.delete(product.key);
    } else {
      product.quantity = currentQuantity - 1;
      box.put(product.key, product);
    }

    notifyListeners();
  }

  void increaseCount({required ProductModel product}) {
    final box = getProductsBox();

    int currentQuantity = product.quantity ?? 0;

    product.quantity = currentQuantity + 1;

    box.put(product.key, product);

    notifyListeners();
  }
}
