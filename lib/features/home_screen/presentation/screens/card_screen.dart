import 'package:ecommers_app/core/utils/ui_constant.dart';
import 'package:ecommers_app/features/home_screen/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {
    super.initState();
  }

  List<ProductModel> allProductsCard = [];

  double counterPriceProductInCart() {
    double total = 0;
    for (var product in allProductsCard) {
      total += product.quantity! * product.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<ProductModel>(UiConstant.nameBoxCard);
    allProductsCard = box.values.toList();
    return Scaffold(
      bottomSheet: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: .min,
          children: [
            Text(
              'Order Summary',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 8),

            _buildSummaryRow(
              'Total Amount',
              '\$${counterPriceProductInCart().toStringAsFixed(2)}',
            ),
          ],
        ),
      ),
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: allProductsCard.length,
        itemBuilder: (context, index) {
          final product = allProductsCard[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    color: Theme.of(context).colorScheme.onPrimary,
                    child: Column(
                      children: [
                        Image.network(product.thumbnail, width: 70, height: 70),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          "\$${product.price}",
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          product.quantity = product.quantity! - 1;

                          if (product.quantity == 0) {
                            box.delete(product.key);
                          } else {
                            box.put(product.key, product);
                          }
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.remove,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),

                        child: Text(
                          product.quantity.toString(),
                          style: Theme.of(context).textTheme.headlineSmall!,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          product.quantity = product.quantity! + 1;
                          box.put(product.key, product);
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
