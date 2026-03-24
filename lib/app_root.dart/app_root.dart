import 'package:ecommers_app/core/utils/themes.dart';
import 'package:ecommers_app/features/home_screen/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
