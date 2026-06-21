import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:staj_proje/data/urun_verisi.dart';
import 'package:staj_proje/theme/app_colors.dart';
import 'package:staj_proje/utils/acilis_suresi.dart';
import 'package:staj_proje/widgets/app_logo.dart';

/// Uygulama açılış ekranı — logo ortada, palet renklerinde dönen noktalar.
class AcilisEkrani extends StatefulWidget {
  const AcilisEkrani({
    super.key,
    required this.onTamamlandi,
  });

  final VoidCallback onTamamlandi;

  @override
  State<AcilisEkrani> createState() => _AcilisEkraniState();
}

class _AcilisEkraniState extends State<AcilisEkrani>
    with TickerProviderStateMixin {
  late final AnimationController _anaKontrol;
  late final AnimationController _cikisKontrol;
  late final DateTime _baslangic;

  @override
  void initState() {
    super.initState();
    _baslangic = DateTime.now();

    _cikisKontrol = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _anaKontrol = AnimationController(
      vsync: this,
      duration: AcilisSuresi.minSure,
    )..forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tamamla();
      _logoyuOnbellegeAl();
    });
  }

  Future<void> _logoyuOnbellegeAl() async {
    if (!mounted) return;
    await precacheImage(
      const AssetImage(AppLogo.assetPath),
      context,
    );
  }

  Future<void> _tamamla() async {
    final kronometre = Stopwatch()..start();
    await UrunVerisi.urunleriYukle();
    kronometre.stop();

    final hedefMs = (kronometre.elapsedMilliseconds + AcilisSuresi.tamponMs)
        .clamp(
      AcilisSuresi.minSure.inMilliseconds,
      AcilisSuresi.maxSure.inMilliseconds,
    );

    if (_anaKontrol.status != AnimationStatus.completed) {
      final tamamlanma = Completer<void>();
      void dinleyici(AnimationStatus durum) {
        if (durum == AnimationStatus.completed) {
          _anaKontrol.removeStatusListener(dinleyici);
          tamamlanma.complete();
        }
      }

      _anaKontrol.addStatusListener(dinleyici);
      await tamamlanma.future;
    }

    final gecenMs = DateTime.now().difference(_baslangic).inMilliseconds;
    final kalanMs = hedefMs - gecenMs;
    if (kalanMs > 0) {
      await Future<void>.delayed(Duration(milliseconds: kalanMs));
    }

    if (mounted) await _cikisaGec();
  }

  Future<void> _cikisaGec() async {
    await _cikisKontrol.forward();
    if (mounted) widget.onTamamlandi();
  }

  @override
  void dispose() {
    _anaKontrol.dispose();
    _cikisKontrol.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.snow,
      body: AnimatedBuilder(
        animation: _cikisKontrol,
        builder: (context, cocuk) {
          return Opacity(
            opacity: 1 - _cikisKontrol.value,
            child: cocuk,
          );
        },
        child: _AcilisGovde(kontrol: _anaKontrol),
      ),
    );
  }
}

class _AcilisGovde extends StatelessWidget {
  const _AcilisGovde({required this.kontrol});

  final AnimationController kontrol;

  @override
  Widget build(BuildContext context) {
    final logoGiris = CurvedAnimation(
      parent: kontrol,
      curve: const Interval(0.0, 0.28, curve: Curves.easeOutCubic),
    );

    final noktaCikis = CurvedAnimation(
      parent: kontrol,
      curve: const Interval(0.22, 0.52, curve: Curves.easeOutCubic),
    );

    final donus = Tween<double>(begin: 0, end: math.pi * 2.2).animate(
      CurvedAnimation(
        parent: kontrol,
        curve: const Interval(0.3, 1.0, curve: Curves.linear),
      ),
    );

    final parlama = Tween<double>(begin: 0.2, end: 0.65).animate(
      CurvedAnimation(
        parent: kontrol,
        curve: const Interval(0.28, 0.62, curve: Curves.easeInOut),
      ),
    );

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0, -0.12),
          radius: 1.15,
          colors: [
            AppColors.plumDustSoft,
            AppColors.snow,
          ],
          stops: [0.0, 0.78],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, kisitlar) {
          final merkez = Offset(
            kisitlar.maxWidth / 2,
            kisitlar.maxHeight / 2,
          );

          return AnimatedBuilder(
            animation: kontrol,
            builder: (context, _) {
              final logoOpaklik = logoGiris.value;
              final logoOlcek = 0.7 + 0.3 * logoOpaklik;

              return Stack(
                fit: StackFit.expand,
                children: [
                  CustomPaint(
                    painter: _OrbitNoktalariCizer(
                      merkez: merkez,
                      cikis: noktaCikis.value,
                      donus: donus.value,
                      parlama: parlama.value,
                    ),
                  ),
                  Center(
                    child: logoOpaklik > 0
                        ? Opacity(
                            opacity: logoOpaklik,
                            child: Transform.scale(
                              scale: logoOlcek,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(28),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.plumDust.withValues(
                                        alpha: 0.14 + parlama.value * 0.14,
                                      ),
                                      blurRadius: 32,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: const AppLogo(
                                  height: 108,
                                  borderRadius: 24,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(
                            width: 108,
                            height: 108,
                          ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

/// Logo arkasından çıkıp etrafında dönen renk noktalarını çizer.
class _OrbitNoktalariCizer extends CustomPainter {
  _OrbitNoktalariCizer({
    required this.merkez,
    required this.cikis,
    required this.donus,
    required this.parlama,
  });

  final Offset merkez;
  final double cikis;
  final double donus;
  final double parlama;

  /// Tek halka — yalnızca marka plum paleti.
  static const List<_NoktaTanimi> _noktalar = [
    _NoktaTanimi(AppColors.plumDustDark, 0),
    _NoktaTanimi(AppColors.plumDust, math.pi / 3),
    _NoktaTanimi(AppColors.plumDustLight, math.pi * 2 / 3),
    _NoktaTanimi(AppColors.plumDustMuted, math.pi),
    _NoktaTanimi(AppColors.metinOrta, math.pi * 4 / 3),
    _NoktaTanimi(AppColors.metinAcik, math.pi * 5 / 3),
  ];

  static const double _yaricap = 96;
  static const double _logoYaricap = 38;
  static const double _noktaBoyutu = 11;

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < _noktalar.length; i++) {
      final nokta = _noktalar[i];
      final gecikme = i / _noktalar.length * 0.22;
      final yerelCikis = ((cikis - gecikme) / (1 - gecikme)).clamp(0.0, 1.0);
      final yumusakCikis = Curves.easeOutCubic.transform(yerelCikis);

      final yaricap =
          _logoYaricap + (_yaricap - _logoYaricap) * yumusakCikis;
      final aci = nokta.baslangicAcisi + donus;
      final konum = merkez + Offset(
        math.cos(aci) * yaricap,
        math.sin(aci) * yaricap,
      );

      final gorunurluk = yumusakCikis;
      final boyut = _noktaBoyutu * (0.4 + 0.6 * yumusakCikis);

      final golgeBoyutu = boyut * (1.5 + parlama * 0.4);
      canvas.drawCircle(
        konum,
        golgeBoyutu,
        Paint()
          ..color = nokta.renk.withValues(alpha: 0.2 * gorunurluk)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7),
      );

      canvas.drawCircle(
        konum,
        boyut,
        Paint()
          ..color = nokta.renk.withValues(alpha: 0.9 * gorunurluk)
          ..style = PaintingStyle.fill,
      );

      canvas.drawCircle(
        konum,
        boyut * 0.35,
        Paint()
          ..color = AppColors.snow.withValues(alpha: 0.5 * gorunurluk)
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _OrbitNoktalariCizer eski) {
    return eski.cikis != cikis ||
        eski.donus != donus ||
        eski.parlama != parlama ||
        eski.merkez != merkez;
  }
}

class _NoktaTanimi {
  const _NoktaTanimi(this.renk, this.baslangicAcisi);

  final Color renk;
  final double baslangicAcisi;
}
