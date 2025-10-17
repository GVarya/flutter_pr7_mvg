import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green,
        primary: Colors.green.shade700,
        secondary: Colors.green.shade500,
        tertiary: Colors.lightGreen.shade300,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),
      useMaterial3: true,

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),


      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade700,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.green.shade700,
          textStyle: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green.shade700, width: 2),
        ),
        labelStyle: TextStyle(color: Colors.green.shade700),
        floatingLabelStyle: TextStyle(color: Colors.green.shade700),
        filled: true,
        fillColor: Colors.green.shade50,
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: Colors.green.shade700,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.green.shade700,
        contentTextStyle: TextStyle(color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),


      dividerTheme: DividerThemeData(
        color: Colors.green.shade200,
        thickness: 1,
        space: 1,
      ),

      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        iconColor: Colors.green.shade700,
      ),
    );
  }


}
