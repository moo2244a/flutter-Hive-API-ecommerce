part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class GetDataProductsSuccessful extends ProductState {
  final List<ProductModel> allProducts;
  final List<CategoryModel> allCategorys;

  GetDataProductsSuccessful({
    required this.allProducts,
    required this.allCategorys,
  });
}

final class GetDataProductsError extends ProductState {
  final String message;

  GetDataProductsError(this.message);
}

final class GetDataProductsLoading extends ProductState {}

final class SetStateUi extends ProductState {}
