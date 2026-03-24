import 'package:ecommers_app/features/home_screen/data/models/categorys_model.dart';
import 'package:ecommers_app/features/home_screen/presentation/logic/get_category_icon.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel categoryModel;

  final GestureTapCallback? onTap;

  const CategoryItem({
    super.key,
    required this.categoryModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🔵 Icon Container
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              getCategoryIcon(categoryModel.slug),
              size: 26,
              color: colors.primary,
            ),
          ),

          const SizedBox(height: 6),

          SizedBox(
            width: 75,
            child: Text(
              categoryModel.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall!.copyWith(
                fontSize: 12,
                color: colors.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
