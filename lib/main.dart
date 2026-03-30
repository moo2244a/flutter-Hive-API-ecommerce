import 'package:ecommers_app/app_root.dart/app_root.dart';
import 'package:ecommers_app/core/utils/ui_constant.dart';
import 'package:ecommers_app/features/home%20screen/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  await Hive.openBox<ProductModel>(UiConstant.nameBoxCard);

  await Hive.openBox<ProductModel>(UiConstant.nameBoxLove);

  runApp(AppRoot());
}
