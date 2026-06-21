import 'package:flutter/material.dart';
import 'package:staj_proje/widgets/app_logo.dart';
import 'package:staj_proje/models/urun.dart';
import 'package:staj_proje/state/sepet_miras.dart';
import 'package:staj_proje/theme/app_colors.dart';
import 'package:staj_proje/widgets/urun_gorseli.dart';

/// Sepetteki ürünlerin listelendiği simülasyon ekranı.
class SepetSayfasi extends StatelessWidget {
  const SepetSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    final sepet = SepetMiras.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const AppLogoBaslik(baslik: 'Sepetim'),
        actions: [
          if (sepet.urunAdedi > 0)
            TextButton(
              onPressed: () {
                sepet.sepetiTemizle();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sepet temizlendi')),
                );
              },
              child: const Text('Temizle'),
            ),
        ],
      ),
      body: sepet.urunAdedi == 0
          ? _BosSepet()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: sepet.sepetUrunleri.length,
                    itemBuilder: (context, index) {
                      final urun = sepet.sepetUrunleri[index];
                      return _SepetOgesi(
                        urun: urun,
                        onKaldir: () => sepet.sepettenCikar(urun),
                      );
                    },
                  ),
                ),
                _SepetOzeti(toplamFiyat: sepet.toplamFiyat),
              ],
            ),
    );
  }
}

/// Sepet boşken gösterilen bilgilendirme alanı.
class _BosSepet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.plumDustSoft,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 48,
                color: AppColors.plumDust,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Sepetiniz boş',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.metinKoyu,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Beğendiğiniz ürünleri sepete ekleyerek burada görebilirsiniz.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.metinOrta, height: 1.5),
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, '/urunler'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.plumDust,
                side: const BorderSide(color: AppColors.plumDust),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Ürünlere Göz At'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sepetteki tek bir ürün satırı.
class _SepetOgesi extends StatelessWidget {
  const _SepetOgesi({required this.urun, required this.onKaldir});

  final Urun urun;
  final VoidCallback onKaldir;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: UrunGorseli(
                yol: urun.gorselUrl,
                width: 72,
                height: 72,
                iconSize: 32,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    urun.ad,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.metinKoyu,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    urun.marka,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.metinAcik,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    urun.fiyatMetni,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.plumDust,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onKaldir,
              icon: const Icon(Icons.close_rounded, size: 20),
              color: AppColors.metinAcik,
              tooltip: 'Kaldır',
            ),
          ],
        ),
      ),
    );
  }
}

/// Sepet altındaki toplam fiyat özeti.
class _SepetOzeti extends StatelessWidget {
  const _SepetOzeti({required this.toplamFiyat});

  final double toplamFiyat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.snow,
        border: Border(top: BorderSide(color: AppColors.snowDark)),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Toplam',
                  style: TextStyle(color: AppColors.metinAcik, fontSize: 13),
                ),
                Text(
                  '${toplamFiyat.toStringAsFixed(2)} ₺',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.plumDustDark,
                  ),
                ),
              ],
            ),
            FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Ödeme simülasyonu — eğitim projesi kapsamında aktif değil.',
                    ),
                  ),
                );
              },
              child: const Text('Ödemeye Geç'),
            ),
          ],
        ),
      ),
    );
  }
}
