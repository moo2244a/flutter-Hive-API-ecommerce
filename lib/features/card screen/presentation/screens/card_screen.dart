import 'package:ecommers_app/features/card%20screen/presentation/logic/card_provider.dart';
import 'package:ecommers_app/features/home%20screen/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

            BuildSummaryRowTotalAmount(
              title: 'Total Amount',
              value:
                  '\$${Provider.of<CardProvider>(context).counterPriceProductInCart().toStringAsFixed(2)}',
            ),
          ],
        ),
      ),
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: Provider.of<CardProvider>(context).allProductsCard.length,
        itemBuilder: (context, index) {
          final ProductModel product = Provider.of<CardProvider>(
            context,
          ).allProductsCard[index];
          return CardItemListView(product: product);
        },
      ),
    );
  }
}

class CardItemListView extends StatelessWidget {
  const CardItemListView({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
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
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => Provider.of<CardProvider>(
                    context,
                    listen: false,
                  ).decreaseCount(product: product),
                  icon: Icon(
                    Icons.remove,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),

                  child: Text(
                    product.quantity.toString(),
                    style: Theme.of(context).textTheme.headlineSmall!,
                  ),
                ),
                IconButton(
                  onPressed: () => Provider.of<CardProvider>(
                    context,
                    listen: false,
                  ).increaseCount(product: product),
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
  }
}

class BuildSummaryRowTotalAmount extends StatelessWidget {
  const BuildSummaryRowTotalAmount({
    super.key,
    required this.title,
    required this.value,
  });
  final String title, value;

  @override
  Widget build(BuildContext context) {
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
