import 'package:ecommers_app/core/utils/themes.dart';
import 'package:ecommers_app/features/card%20screen/presentation/logic/card_provider.dart';
import 'package:ecommers_app/features/home%20screen/presentation/logic/cubit/product_cubit.dart';
import 'package:ecommers_app/features/home%20screen/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (context) => ProductCubit()..loadingDate()),
        ChangeNotifierProvider(
          create: (_) => CardProvider()..getProductsCard(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.light(),
        darkTheme: Themes.dark(),
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

        home: HomeScreen(
          onDark: () {
            isDark = !isDark;
            setState(() {});
          },
        ),
      ),
    );
  }
}
