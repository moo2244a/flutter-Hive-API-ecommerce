import 'package:ecommers_app/core/error/api_error.dart';
import 'package:ecommers_app/features/home%20screen/data/models/categorys_model.dart';
import 'package:ecommers_app/features/home%20screen/data/models/product_model.dart';
import 'package:ecommers_app/features/home%20screen/data/repositry/repositry_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  static ProductCubit get(BuildContext context) => BlocProvider.of(context);
  int currentIndex = 0;
  void setCurrentIndex(int p1) {
    currentIndex = p1;
    emit(SetStateUi());
  }

  Future<void Function()?> favoriteAction({
    required ProductModel product,
    required Box<ProductModel> boxLove,
  }) async {
    final favIndex = boxLove.values.toList().indexWhere(
      (p) => p.id == product.id,
    );

    if (favIndex != -1) {
      await boxLove.deleteAt(favIndex);
    } else {
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
    emit(SetStateUi());
    return null;
  }

  List<ProductModel> allProducts = [];
  List<CategoryModel> allCategorys = [];
  Future<void> loadingDate() async {
    emit(GetDataProductsLoading());
    try {
      allProducts = await RepositryHome.getProducts();
      allCategorys = await RepositryHome.getCategorys();
      emit(
        GetDataProductsSuccessful(
          allProducts: allProducts,
          allCategorys: allCategorys,
        ),
      );
    } on ApiError catch (e) {
      emit(GetDataProductsError(e.message));
    }
  }
}
