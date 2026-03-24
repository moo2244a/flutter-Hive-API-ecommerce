import 'package:ecommers_app/features/home_screen/data/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;

  final VoidCallback? onTap;
  final VoidCallback? iconButtonAdd;
  final VoidCallback? favoriteIcon;
  final bool isContainsKey;
  const ProductCard({
    super.key,

    this.onTap,
    this.iconButtonAdd,
    required this.product,
    this.favoriteIcon,
    required this.isContainsKey,
  });

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
                          child: GestureDetector(
                            onTap: widget.favoriteIcon,
                            child: Icon(
                              widget.isContainsKey
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 30,
                              color: widget.isContainsKey
                                  ? Colors.red
                                  : colors.onPrimary,
                            ),
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
                        onPressed: widget.iconButtonAdd,
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
