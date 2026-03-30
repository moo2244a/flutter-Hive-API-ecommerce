import 'package:ecommers_app/core/utils/ui_constant.dart';
import 'package:ecommers_app/features/card%20screen/presentation/logic/card_provider.dart';
import 'package:ecommers_app/features/home%20screen/data/models/product_model.dart';
import 'package:ecommers_app/features/home%20screen/presentation/logic/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;

  final VoidCallback? onTap;

  const ProductCard({super.key, this.onTap, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: colors.onPrimary,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(widget.product.thumbnail),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors.surface.withValues(alpha: .5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: FittedBox(
                          child: BlocBuilder<ProductCubit, ProductState>(
                            builder: (context, state) {
                              final boxLove = Hive.box<ProductModel>(
                                UiConstant.nameBoxLove,
                              );

                              final isFav = boxLove.values.any(
                                (p) => p.id == widget.product.id,
                              );

                              return GestureDetector(
                                onTap: () async {
                                  await ProductCubit.get(
                                    context,
                                  ).favoriteAction(
                                    product: widget.product,
                                    boxLove: boxLove,
                                  );
                                },
                                child: Icon(
                                  isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 30,
                                  color: isFav ? Colors.red : colors.onPrimary,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Flexible(
                        child: FittedBox(
                          child: Text(
                            "\$${widget.product.price}",
                            maxLines: 1,

                            style: theme.textTheme.headlineLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      IconButton(
                        onPressed: () async {
                          await Provider.of<CardProvider>(
                            context,
                            listen: false,
                          ).addProductCard(product: widget.product);
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
