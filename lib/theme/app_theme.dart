import 'package:flutter/material.dart';
import 'package:staj_proje/theme/app_colors.dart';

/// Güzellik Sepetim için Material 3 teması oluşturur.
ThemeData buildAppTheme() {
  const renkSemasi = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.plumDust,
    onPrimary: AppColors.snow,
    primaryContainer: AppColors.plumDustSoft,
    onPrimaryContainer: AppColors.plumDustDark,
    secondary: AppColors.plumDustLight,
    onSecondary: AppColors.snow,
    secondaryContainer: AppColors.plumDustMuted,
    onSecondaryContainer: AppColors.plumDustDark,
    surface: AppColors.snow,
    onSurface: AppColors.metinKoyu,
    onSurfaceVariant: AppColors.metinOrta,
    outline: AppColors.plumDustMuted,
    outlineVariant: AppColors.snowDark,
    error: AppColors.hata,
    onError: AppColors.snow,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: renkSemasi,
    scaffoldBackgroundColor: AppColors.snow,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 2,
      centerTitle: false,
      backgroundColor: AppColors.snow,
      foregroundColor: AppColors.plumDustDark,
      titleTextStyle: TextStyle(
        color: AppColors.plumDustDark,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: AppColors.snow,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.snowDark, width: 1),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.plumDust,
        foregroundColor: AppColors.snow,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.plumDust,
        foregroundColor: AppColors.snow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.snowDark,
      hintStyle: const TextStyle(color: AppColors.metinAcik),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.plumDustMuted, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.plumDust, width: 1.5),
      ),
      prefixIconColor: AppColors.plumDust,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.snowDark,
      selectedColor: AppColors.plumDustSoft,
      labelStyle: const TextStyle(color: AppColors.metinKoyu),
      secondaryLabelStyle: const TextStyle(color: AppColors.plumDustDark),
      side: const BorderSide(color: AppColors.plumDustMuted),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.plumDust,
      foregroundColor: AppColors.snow,
      elevation: 4,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.plumDustDark,
      contentTextStyle: const TextStyle(color: AppColors.snow),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.snowDark,
      thickness: 1,
    ),
  );
}
