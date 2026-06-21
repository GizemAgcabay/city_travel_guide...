import 'package:flutter/material.dart';
import 'package:staj_proje/theme/app_colors.dart';

/// Yerel asset üzerinden ürün görseli gösterir.
class UrunGorseli extends StatelessWidget {
  const UrunGorseli({
    super.key,
    required this.yol,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.iconSize = 48,
  });

  final String yol;
  final BoxFit fit;
  final double? width;
  final double? height;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      yol,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (_, __, ___) => Container(
        width: width,
        height: height,
        color: AppColors.plumDustSoft,
        child: Icon(
          Icons.spa_outlined,
          size: iconSize,
          color: AppColors.plumDustLight,
        ),
      ),
    );
  }
}
