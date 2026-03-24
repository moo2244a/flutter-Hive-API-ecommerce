import 'package:dio/dio.dart';
import 'package:ecommers_app/core/error/api_error.dart';
import 'package:ecommers_app/features/home_screen/data/models/categorys_model.dart';
import 'package:ecommers_app/features/home_screen/data/models/product_model.dart';

class ServerApi {
  static final dio = Dio();
  static final pathProduct = "https://dummyjson.com/products/";
  static Future<List<ProductModel>> getProduct() async {
    try {
      final response = await dio.get(pathProduct);
      final body = response.data;
      final List products = body["products"];
      final productModels = products
          .map((toElement) => ProductModel.fromJson(toElement))
          .toList();

      return productModels;
    } catch (e) {
      throw ApiError(message: "error get data");
    }
  }

  static Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dio.get('${pathProduct}categories');
      final body = response.data;
      final List categorys = body;
      final categoryModels = categorys
          .map((toElement) => CategoryModel.fromJson(toElement))
          .toList();

      return categoryModels;
    } catch (e) {
      throw ApiError(message: "error get data");
    }
  }

  static Future<List<ProductModel>> getCategorieOfProduct(
    String pathProductCategories,
  ) async {
    try {
      final response = await dio.get(pathProductCategories);
      final body = response.data;
      final List products = body["products"];
      final productModels = products
          .map((toElement) => ProductModel.fromJson(toElement))
          .toList();
      return productModels;
    } catch (e) {
      throw ApiError(message: "error get data");
    }
  }
}
