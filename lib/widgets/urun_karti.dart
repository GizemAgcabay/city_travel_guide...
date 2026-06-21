import 'package:flutter/material.dart';
import 'package:staj_proje/models/urun.dart';
import 'package:staj_proje/theme/app_colors.dart';
import 'package:staj_proje/widgets/urun_gorseli.dart';

/// GridView içinde gösterilen tek ürün kartı.
class UrunKarti extends StatelessWidget {
  const UrunKarti({
    super.key,
    required this.urun,
    required this.onTap,
    this.heroEtiketi,
  });

  final Urun urun;
  final VoidCallback onTap;
  final String? heroEtiketi;

  @override
  Widget build(BuildContext context) {
    final gorsel = ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      child: UrunGorseli(
        yol: urun.gorselUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.snow,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.snowDark),
            boxShadow: const [
              BoxShadow(
                color: AppColors.kartGolge,
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: heroEtiketi != null
                    ? Hero(tag: heroEtiketi!, child: gorsel)
                    : gorsel,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      urun.marka.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                        color: AppColors.plumDustLight,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      urun.ad,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.metinKoyu,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      urun.fiyatMetni,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.plumDust,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
