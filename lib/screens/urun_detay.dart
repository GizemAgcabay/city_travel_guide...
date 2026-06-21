import 'package:flutter/material.dart';
import 'package:staj_proje/models/urun.dart';
import 'package:staj_proje/state/sepet_miras.dart';
import 'package:staj_proje/theme/app_colors.dart';
import 'package:staj_proje/widgets/urun_gorseli.dart';

/// Seçilen ürünün detaylı bilgilerinin gösterildiği ekran.
class UrunDetaySayfasi extends StatefulWidget {
  const UrunDetaySayfasi({super.key});

  /// Navigator.push ile ürün detayına gider (Route Arguments).
  static void git(BuildContext context, Urun urun) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const UrunDetaySayfasi(),
        settings: RouteSettings(arguments: urun),
      ),
    );
  }

  @override
  State<UrunDetaySayfasi> createState() => _UrunDetaySayfasiState();
}

class _UrunDetaySayfasiState extends State<UrunDetaySayfasi> {
  bool _sepeteEklendi = false;
  late final PageController _galeriController;
  int _aktifGorsel = 0;
  String? _seciliRenk;

  @override
  void initState() {
    super.initState();
    _galeriController = PageController();
  }

  @override
  void dispose() {
    _galeriController.dispose();
    super.dispose();
  }

  void _renkSec(Urun urun, String renkAdi) {
    if (_seciliRenk == renkAdi) return;
    setState(() {
      _seciliRenk = renkAdi;
      _aktifGorsel = 0;
    });
    _galeriController.jumpToPage(0);
  }

  @override
  Widget build(BuildContext context) {
    final urun = ModalRoute.of(context)!.settings.arguments as Urun;
    final sepet = SepetMiras.of(context);
    final sepetteVar = sepet.sepetUrunleri.any((u) => u.id == urun.id);
    final seciliRenk = _seciliRenk ?? urun.renk;
    final gorseller = urun.gorsellerForRenk(seciliRenk);
    final gosterilecekFiyat = urun.fiyatMetniForRenk(seciliRenk);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 380,
            pinned: true,
            backgroundColor: AppColors.snow,
            foregroundColor: AppColors.plumDustDark,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  PageView.builder(
                    controller: _galeriController,
                    itemCount: gorseller.length,
                    onPageChanged: (index) {
                      setState(() => _aktifGorsel = index);
                    },
                    itemBuilder: (context, index) {
                      final gorsel = UrunGorseli(
                        yol: gorseller[index],
                        iconSize: 80,
                      );

                      if (index == 0) {
                        return Hero(
                          tag: 'urun-${urun.id}',
                          child: gorsel,
                        );
                      }
                      return gorsel;
                    },
                  ),
                  if (gorseller.length > 1)
                    Positioned(
                      bottom: 12,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          gorseller.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: _aktifGorsel == index ? 18 : 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: _aktifGorsel == index
                                  ? AppColors.snow
                                  : AppColors.snow.withValues(alpha: 0.55),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    urun.marka.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                      color: AppColors.plumDustLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    urun.ad,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.metinKoyu,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.plumDustSoft,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          urun.kategori,
                          style: const TextStyle(
                            color: AppColors.plumDustDark,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      if (seciliRenk != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.snowDark,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.plumDustMuted),
                          ),
                          child: Text(
                            seciliRenk,
                            style: const TextStyle(
                              color: AppColors.metinOrta,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    gosterilecekFiyat,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.plumDust,
                    ),
                  ),
                  if (urun.renkSecenekleri.length > 1) ...[
                    const SizedBox(height: 24),
                    Text(
                      'Renk Seçenekleri (${urun.renkSecenekleri.length})',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.metinKoyu,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 92,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: urun.renkSecenekleri.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final secenek = urun.renkSecenekleri[index];
                          final secili = seciliRenk != null &&
                              secenek.ad.toLowerCase() ==
                                  seciliRenk.toLowerCase();
                          return InkWell(
                            onTap: () => _renkSec(urun, secenek.ad),
                            borderRadius: BorderRadius.circular(12),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 68,
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: secili
                                      ? AppColors.plumDust
                                      : AppColors.snowDark,
                                  width: secili ? 2 : 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: UrunGorseli(
                                        yol: secenek.gorselUrl,
                                        iconSize: 24,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    secenek.ad,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: secili
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: secili
                                          ? AppColors.plumDustDark
                                          : AppColors.metinOrta,
                                      height: 1.1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  if (gorseller.length > 1) ...[
                    const SizedBox(height: 24),
                    Text(
                      'Ürün Görselleri (${gorseller.length})',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.metinKoyu,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 72,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: gorseller.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final secili = _aktifGorsel == index;
                          return GestureDetector(
                            onTap: () {
                              _galeriController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeOut,
                              );
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 72,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: secili
                                      ? AppColors.plumDust
                                      : AppColors.snowDark,
                                  width: secili ? 2 : 1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: UrunGorseli(
                                  yol: gorseller[index],
                                  iconSize: 24,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  const Text(
                    'Ürün Açıklaması',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.metinKoyu,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    urun.aciklama,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.metinOrta,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        decoration: BoxDecoration(
          color: AppColors.snow,
          boxShadow: [
            BoxShadow(
              color: AppColors.kartGolge,
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: FilledButton.icon(
            onPressed: sepetteVar
                ? null
                : () {
                    sepet.sepeteEkle(urun);
                    setState(() => _sepeteEklendi = true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${urun.ad} sepete eklendi'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
            icon: Icon(
              sepetteVar || _sepeteEklendi
                  ? Icons.check_rounded
                  : Icons.shopping_bag_outlined,
            ),
            label: Text(
              sepetteVar || _sepeteEklendi ? 'Sepette' : 'Sepete Ekle',
            ),
          ),
        ),
      ),
    );
  }
}
