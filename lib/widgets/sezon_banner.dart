import 'dart:async';

import 'package:flutter/material.dart';
import 'package:staj_proje/data/kategori_hikaye_verisi.dart';
import 'package:staj_proje/models/urun.dart';
import 'package:staj_proje/screens/koleksiyon_hikayesi.dart';
import 'package:staj_proje/theme/app_colors.dart';
import 'package:staj_proje/widgets/urun_gorseli.dart';

/// Ana sayfadaki animasyonlu yeni sezon banner kartı.
class SezonBanner extends StatefulWidget {
  const SezonBanner({super.key, required this.tumUrunler});

  final List<Urun> tumUrunler;

  @override
  State<SezonBanner> createState() => _SezonBannerState();
}

class _SezonBannerState extends State<SezonBanner>
    with SingleTickerProviderStateMixin {
  late final List<Urun> _bannerUrunleri;
  late final AnimationController _nefesKontrol;
  Timer? _sahneZamanlayici;
  int _aktifSahne = 0;

  static const _sahneSayisi = 3;
  static const _sahneBekleme = Duration(seconds: 4);

  @override
  void initState() {
    super.initState();
    _bannerUrunleri = KategoriHikayeVerisi.bannerUrunleri(widget.tumUrunler);

    _nefesKontrol = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat(reverse: true);

    _sahneZamanlayici = Timer.periodic(_sahneBekleme, (_) {
      if (!mounted) return;
      setState(() => _aktifSahne = (_aktifSahne + 1) % _sahneSayisi);
    });
  }

  @override
  void dispose() {
    _sahneZamanlayici?.cancel();
    _nefesKontrol.dispose();
    super.dispose();
  }

  void _hikayeyiAc() {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        opaque: false,
        barrierColor: Colors.black87,
        pageBuilder: (_, __, ___) =>
            KoleksiyonHikayesi(tumUrunler: widget.tumUrunler),
        transitionsBuilder: (_, animasyon, __, cocuk) {
          return FadeTransition(opacity: animasyon, child: cocuk);
        },
        transitionDuration: const Duration(milliseconds: 350),
        reverseTransitionDuration: const Duration(milliseconds: 280),
      ),
    );
  }

  List<Urun> _sahneUrunleri(int sahne) {
    if (_bannerUrunleri.isEmpty) return const [];
    final n = _bannerUrunleri.length;
    return List.generate(3, (i) => _bannerUrunleri[(sahne * 2 + i) % n]);
  }

  @override
  Widget build(BuildContext context) {
    final urunler = _sahneUrunleri(_aktifSahne);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _hikayeyiAc,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: AppColors.kartGolge,
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 190,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.hardEdge,
                children: [
                  const _ArkaPlanGradyan(),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 900),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    transitionBuilder: (cocuk, animasyon) {
                      final solma = CurvedAnimation(
                        parent: animasyon,
                        curve: Curves.easeInOut,
                      );
                      return FadeTransition(
                        opacity: solma,
                        child: ScaleTransition(
                          scale: Tween<double>(begin: 1.04, end: 1.0).animate(
                            solma,
                          ),
                          child: cocuk,
                        ),
                      );
                    },
                    layoutBuilder: (mevcut, onceki) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          ...onceki,
                          if (mevcut != null) mevcut,
                        ],
                      );
                    },
                    child: _UrunCollage(
                      key: ValueKey(_aktifSahne),
                      urunler: urunler,
                      nefes: _nefesKontrol,
                    ),
                  ),
                  _MetinKatmani(onTap: _hikayeyiAc),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ArkaPlanGradyan extends StatelessWidget {
  const _ArkaPlanGradyan();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.plumDustDark,
            AppColors.plumDust,
            Color(0xFF9A6B82),
          ],
        ),
      ),
    );
  }
}

class _UrunCollage extends StatelessWidget {
  const _UrunCollage({
    super.key,
    required this.urunler,
    required this.nefes,
  });

  final List<Urun> urunler;
  final Animation<double> nefes;

  @override
  Widget build(BuildContext context) {
    if (urunler.isEmpty) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: nefes,
      builder: (context, _) {
        final olcek = 1.0 + (nefes.value * 0.025);

        return Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.hardEdge,
          children: [
            _KonumluUrunKarti(
              urun: urunler[0],
              sag: -16,
              ust: -8,
              genislik: 150,
              yukseklik: 150,
              donus: -0.07,
              olcek: olcek,
            ),
            if (urunler.length > 1)
              _KonumluUrunKarti(
                urun: urunler[1],
                sag: 24,
                alt: -10,
                genislik: 120,
                yukseklik: 120,
                donus: 0.1,
                olcek: 1.0 + (1 - nefes.value) * 0.02,
              ),
            if (urunler.length > 2)
              _KonumluUrunKarti(
                urun: urunler[2],
                sol: -20,
                alt: 16,
                genislik: 100,
                yukseklik: 100,
                donus: 0.05,
                olcek: olcek * 0.98,
              ),
          ],
        );
      },
    );
  }
}

class _KonumluUrunKarti extends StatelessWidget {
  const _KonumluUrunKarti({
    required this.urun,
    required this.genislik,
    required this.yukseklik,
    required this.donus,
    required this.olcek,
    this.sol,
    this.sag,
    this.ust,
    this.alt,
  });

  final Urun urun;
  final double genislik;
  final double yukseklik;
  final double donus;
  final double olcek;
  final double? sol;
  final double? sag;
  final double? ust;
  final double? alt;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: sol,
      right: sag,
      top: ust,
      bottom: alt,
      child: Transform.scale(
        scale: olcek,
        child: Transform.rotate(
          angle: donus,
          child: Container(
            width: genislik,
            height: yukseklik,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.snow.withValues(alpha: 0.35),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: UrunGorseli(
                yol: urun.gorselUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MetinKatmani extends StatelessWidget {
  const _MetinKatmani({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.plumDustDark.withValues(alpha: 0.9),
                AppColors.plumDustDark.withValues(alpha: 0.5),
                AppColors.plumDust.withValues(alpha: 0.1),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.snow.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.snow.withValues(alpha: 0.3),
                  ),
                ),
                child: const Text(
                  'YENİ SEZON',
                  style: TextStyle(
                    color: AppColors.snow,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
              const Spacer(),
              const Text(
                'Yeni Sezon\nKoleksiyonu',
                style: TextStyle(
                  color: AppColors.snow,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 1.15,
                  shadows: [
                    Shadow(
                      color: Color(0x66000000),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Dokunarak koleksiyonu keşfet',
                style: TextStyle(
                  color: AppColors.snow.withValues(alpha: 0.92),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: AppColors.snow.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: AppColors.snow.withValues(alpha: 0.45),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.play_circle_outline_rounded,
                        color: AppColors.snow,
                        size: 16,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Sunumu İzle',
                        style: TextStyle(
                          color: AppColors.snow,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
