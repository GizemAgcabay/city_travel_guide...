import 'package:flutter/material.dart';
import 'package:staj_proje/theme/app_colors.dart';

/// Ürün arama ve filtreleme için kullanılan arama çubuğu.
class AramaCubugu extends StatelessWidget {
  const AramaCubugu({
    super.key,
    required this.controller,
    required this.onChanged,
    this.ipucu = 'Ürün veya marka ara...',
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String ipucu;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: ipucu,
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close_rounded, size: 20),
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
              )
            : null,
      ),
    );
  }
}

/// Yatay kaydırılabilir kategori seçim chip'leri.
class KategoriFiltreleri extends StatelessWidget {
  const KategoriFiltreleri({
    super.key,
    required this.kategoriler,
    required this.seciliKategori,
    required this.onSecim,
  });

  final List<String> kategoriler;
  final String seciliKategori;
  final ValueChanged<String> onSecim;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: kategoriler.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final kategori = kategoriler[index];
          final secili = kategori == seciliKategori;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: FilterChip(
              label: Text(kategori),
              selected: secili,
              onSelected: (_) => onSecim(kategori),
              showCheckmark: false,
              labelStyle: TextStyle(
                color: secili ? AppColors.plumDustDark : AppColors.metinOrta,
                fontWeight: secili ? FontWeight.w600 : FontWeight.w500,
              ),
              backgroundColor: AppColors.snowDark,
              selectedColor: AppColors.plumDustSoft,
              side: BorderSide(
                color: secili ? AppColors.plumDust : AppColors.plumDustMuted,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// AppBar'da sepet ikonu ve ürün adedi rozeti.
class SepetIkonu extends StatelessWidget {
  const SepetIkonu({super.key, required this.urunAdedi});

  final int urunAdedi;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: () => Navigator.pushNamed(context, '/sepet'),
          icon: const Icon(Icons.shopping_bag_outlined),
          tooltip: 'Sepetim',
        ),
        if (urunAdedi > 0)
          Positioned(
            right: 6,
            top: 6,
            child: AnimatedScale(
              scale: urunAdedi > 0 ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.plumDust,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                child: Text(
                  urunAdedi > 9 ? '9+' : '$urunAdedi',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.snow,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
