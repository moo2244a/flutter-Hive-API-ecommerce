import 'package:ecommers_app/core/server/server_api.dart';
import 'package:ecommers_app/features/home_screen/data/models/categorys_model.dart';
import 'package:ecommers_app/features/home_screen/data/models/product_model.dart';

class RepositryHome {
  static Future<List<ProductModel>> getProducts() async {
    return await ServerApi.getProduct();
  }

  static Future<List<CategoryModel>> getCategorys() async {
    return await ServerApi.getCategories();
  }

  static Future<List<ProductModel>> getCategorieOfProduct(
    CategoryModel categoryModel,
  ) async {
    return await ServerApi.getCategorieOfProduct(categoryModel.url);
  }
}
