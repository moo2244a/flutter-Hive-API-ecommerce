import 'package:ecommers_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class Themes {
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,

      primaryColor: AppColors.continerLogoHome,

      scaffoldBackgroundColor: const Color.fromARGB(255, 243, 243, 243),

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black, size: 28),
        actionsIconTheme: IconThemeData(color: Colors.black, size: 26),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.continerLogoHome, width: 1.5),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red, width: 1.2),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),

        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        labelStyle: TextStyle(color: Colors.grey, fontSize: 14),

        prefixIconColor: Colors.grey,
        suffixIconColor: Colors.black,
      ),

      colorScheme: ColorScheme.light(
        primary: AppColors.continerLogoHome,
        primaryContainer: Colors.grey.shade100,
        surface: Colors.white,
        onPrimary: Colors.black,
        onSurface: Colors.white,
      ),

      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 3,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.continerLogoHome,
        unselectedItemColor: Colors.grey,
        elevation: 10,
      ),

      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.black,
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
        ),
        headlineSmall: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
        bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
        bodySmall: TextStyle(fontSize: 12, color: Colors.black45),
      ),

      iconTheme: IconThemeData(color: AppColors.continerLogoHome),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.continerLogoHome,
        foregroundColor: Colors.white,
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.continerLogoHome,
        ),
      ),
    );
  }

  static ThemeData? dark() {
    return ThemeData(
      primaryColor: AppColors.continerCategory,
      appBarTheme: AppBarTheme(
        actionsIconTheme: IconThemeData(size: 30, color: AppColors.kWhite),
        iconTheme: IconThemeData(color: AppColors.darkBlack, size: 35),
        titleTextStyle: TextStyle(),
        backgroundColor: AppColors.darkScaffoldColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.continerCategory,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),

        //  الشكل الأساسي
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        //  عند التركيز (Focus)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.continerLogoHome, width: 1.5),
        ),

        //  قبل التركيز
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.kOffWhiteLigth, width: 1),
        ),

        //  في حالة الخطأ
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red, width: 1.2),
        ),

        //  عند الخطأ + focus
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),

        //  النصوص
        hintStyle: TextStyle(color: AppColors.kOffWhiteLigth, fontSize: 14),

        labelStyle: TextStyle(color: AppColors.kOffWhiteLigth, fontSize: 14),

        //  الأيقونات
        prefixIconColor: AppColors.kOffWhiteLigth,
        suffixIconColor: AppColors.darkBlack,
      ),
      colorScheme: ColorScheme.light(
        primary: AppColors.continerLogoHome,
        primaryContainer: AppColors.continerCategory,
        surface: AppColors.kOffWhiteLigth,
        onPrimary: AppColors.kWhite,
        onSurface: AppColors.darkBlack,
      ),
      cardTheme: CardThemeData(
        color: AppColors.continerCategory,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: AppColors.kWhite,
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: AppColors.kWhite,
        ),
        headlineSmall: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: AppColors.kWhite,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: AppColors.kOffWhiteLigth),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.kOffWhiteLigth),
        bodySmall: TextStyle(fontSize: 12, color: AppColors.kOffWhiteLigth),
      ),
      iconTheme: IconThemeData(color: AppColors.continerLogoHome),
      scaffoldBackgroundColor: AppColors.darkScaffoldColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.continerLogoHome,
        foregroundColor: AppColors.darkBlack,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColors.darkBlack,
          backgroundColor: AppColors.continerLogoHome,
        ),
      ),
    );
  }
}
