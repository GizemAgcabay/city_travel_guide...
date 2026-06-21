import 'package:flutter/material.dart';

/// Uygulama logosu — assets/images/app_logo.png
class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.height = 40,
    this.width,
    this.borderRadius = 10,
  });

  final double height;
  final double? width;
  final double borderRadius;

  static const String assetPath = 'assets/images/app_logo.png';

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        assetPath,
        height: height,
        width: width ?? height,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Icon(
          Icons.spa_outlined,
          size: height * 0.7,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

/// AppBar başlığında logo + metin birlikte gösterir.
class AppLogoBaslik extends StatelessWidget {
  const AppLogoBaslik({
    super.key,
    required this.baslik,
    this.logoBoyutu = 32,
  });

  final String baslik;
  final double logoBoyutu;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppLogo(height: logoBoyutu, borderRadius: 8),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            baslik,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
