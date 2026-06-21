import 'package:flutter/material.dart';
import 'package:staj_proje/data/urun_verisi.dart';
import 'package:staj_proje/models/urun.dart';
import 'package:staj_proje/state/sepet_miras.dart';
import 'package:staj_proje/theme/app_colors.dart';
import 'package:staj_proje/widgets/app_logo.dart';
import 'package:staj_proje/widgets/arama_cubugu.dart';
import 'package:staj_proje/widgets/sezon_banner.dart';
import 'package:staj_proje/screens/urun_detay.dart';
import 'package:staj_proje/widgets/urun_karti.dart';

/// Uygulamanın karşılama ekranı: banner, kategoriler ve öne çıkan ürünler.
class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  List<Urun> _tumUrunler = [];
  bool _yukleniyor = true;

  @override
  void initState() {
    super.initState();
    _verileriYukle();
  }

  /// JSON dosyasından ürün verilerini yükler.
  Future<void> _verileriYukle() async {
    final urunler = await UrunVerisi.urunleriYukle();
    if (mounted) {
      setState(() {
        _tumUrunler = urunler;
        _yukleniyor = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final sepet = SepetMiras.of(context);
    final oneCikanlar = _tumUrunler.take(4).toList();
    final kategoriler = ['Tümü', ...UrunVerisi.kategorileriGetir(_tumUrunler)];

    return Scaffold(
      body: SafeArea(
        child: _yukleniyor
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.plumDust),
              )
            : CustomScrollView(
                slivers: [
                  // —— Üst başlık ve sepet ——
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 8, 0),
                      child: Row(
                        children: [
                          const AppLogo(height: 52, borderRadius: 12),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Güzellik Sepetim',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: AppColors.plumDustDark,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Güzelliğin için özenle seçildi',
                                  style: TextStyle(
                                    color: AppColors.metinOrta,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SepetIkonu(urunAdedi: sepet.urunAdedi),
                        ],
                      ),
                    ),
                  ),

                  // —— Banner alanı ——
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: SezonBanner(tumUrunler: _tumUrunler),
                    ),
                  ),

                  // —— Kategoriler ——
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Kategoriler',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.metinKoyu,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 100,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: kategoriler.length - 1,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                final kategori = kategoriler[index + 1];
                                return _KategoriKarti(
                                  kategori: kategori,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/urunler',
                                      arguments: kategori,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // —— Öne çıkanlar başlığı ——
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Öne Çıkanlar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.metinKoyu,
                            ),
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/urunler'),
                            child: const Text('Tümünü Gör'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // —— Yatay ürün listesi ——
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 260,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: oneCikanlar.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 14),
                        itemBuilder: (context, index) {
                          final urun = oneCikanlar[index];
                          return SizedBox(
                            width: 170,
                            child: UrunKarti(
                              urun: urun,
                              heroEtiketi: 'urun-${urun.id}',
                              onTap: () => UrunDetaySayfasi.git(context, urun),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // —— Keşfet butonu ——
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: FilledButton.icon(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/urunler'),
                        icon: const Icon(Icons.grid_view_rounded),
                        label: const Text('Tüm Ürünleri Keşfet'),
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
      ),
    );
  }
}

/// Tek kategori kutusu — yatay listede gösterilir.
class _KategoriKarti extends StatelessWidget {
  const _KategoriKarti({required this.kategori, required this.onTap});

  final String kategori;
  final VoidCallback onTap;

  IconData get _ikon {
    switch (kategori) {
      case 'Ruj':
        return Icons.brush_outlined;
      case 'Far':
        return Icons.palette_outlined;
      case 'Maskara':
        return Icons.remove_red_eye_outlined;
      case 'Fondöten':
        return Icons.face_retouching_natural_outlined;
      case 'Allık':
        return Icons.favorite_border_rounded;
      case 'Aksesuar':
        return Icons.auto_fix_high_outlined;
      default:
        return Icons.spa_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          width: 88,
          decoration: BoxDecoration(
            color: AppColors.plumDustSoft,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.plumDustMuted),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(_ikon, color: AppColors.plumDust, size: 28),
              const SizedBox(height: 8),
              Text(
                kategori,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.plumDustDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
