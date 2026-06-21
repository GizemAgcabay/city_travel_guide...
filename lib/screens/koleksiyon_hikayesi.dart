import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:staj_proje/data/kategori_hikaye_verisi.dart';
import 'package:staj_proje/models/urun.dart';
import 'package:staj_proje/theme/app_colors.dart';
import 'package:staj_proje/widgets/urun_gorseli.dart';

/// Instagram hikayeleri tarzında kategori sunumu.
class KoleksiyonHikayesi extends StatefulWidget {
  const KoleksiyonHikayesi({super.key, required this.tumUrunler});

  final List<Urun> tumUrunler;

  @override
  State<KoleksiyonHikayesi> createState() => _KoleksiyonHikayesiState();
}

class _KoleksiyonHikayesiState extends State<KoleksiyonHikayesi>
    with TickerProviderStateMixin {
  static const _slaytSuresi = Duration(seconds: 5);

  late final PageController _sayfaKontrol;
  late final List<KategoriHikayesi> _slaytlar;
  late final AnimationController _ilerlemeKontrol;
  late final AnimationController _metinKontrol;

  int _aktifIndex = 0;
  bool _duraklatildi = false;

  @override
  void initState() {
    super.initState();
    _slaytlar = KategoriHikayeVerisi.slaytlar;
    _sayfaKontrol = PageController();

    _ilerlemeKontrol = AnimationController(vsync: this, duration: _slaytSuresi);
    _metinKontrol = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _ilerlemeKontrol.addStatusListener((durum) {
      if (durum == AnimationStatus.completed && !_duraklatildi && mounted) {
        _sonrakineGec();
      }
    });

    _metinKontrol.forward();
    _ilerlemeyiBaslat();
  }

  @override
  void dispose() {
    _sayfaKontrol.dispose();
    _ilerlemeKontrol.dispose();
    _metinKontrol.dispose();
    super.dispose();
  }

  void _ilerlemeyiBaslat() {
    _ilerlemeKontrol.forward(from: 0);
  }

  void _ilerlemeyiSifirla() {
    _ilerlemeKontrol.stop();
    _ilerlemeKontrol.reset();
    if (!_duraklatildi) {
      _ilerlemeyiBaslat();
    }
  }

  void _slaytaGec(int index) {
    if (index < 0 || index >= _slaytlar.length) return;

    setState(() => _aktifIndex = index);
    _sayfaKontrol.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
    );
    _metinKontrol.forward(from: 0);
    _ilerlemeyiSifirla();
  }

  void _sonrakineGec() {
    if (_aktifIndex < _slaytlar.length - 1) {
      _slaytaGec(_aktifIndex + 1);
    } else {
      Navigator.of(context).pop();
    }
  }

  void _oncekineGec() {
    if (_aktifIndex > 0) {
      _slaytaGec(_aktifIndex - 1);
    } else {
      _ilerlemeyiSifirla();
    }
  }

  List<Urun> _slaytUrunleri(KategoriHikayesi slayt) {
    if (slayt.girisSlayti) {
      return KategoriHikayeVerisi.bannerUrunleri(widget.tumUrunler, adet: 8);
    }
    return KategoriHikayeVerisi.kategoriUrunleri(
      widget.tumUrunler,
      slayt.kategori!,
    );
  }

  int _slaytUrunSayisi(KategoriHikayesi slayt) {
    if (slayt.girisSlayti || slayt.kategori == null) return 0;
    return KategoriHikayeVerisi.kategoriUrunSayisi(
      widget.tumUrunler,
      slayt.kategori!,
    );
  }

  void _kategoriyiAc(String kategori) {
    Navigator.of(context).pop();
    Navigator.pushNamed(context, '/urunler', arguments: kategori);
  }

  @override
  Widget build(BuildContext context) {
    final ustBosluk = MediaQuery.paddingOf(context).top;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _sayfaKontrol,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _slaytlar.length,
            onPageChanged: (index) {
              setState(() => _aktifIndex = index);
              _metinKontrol.forward(from: 0);
              _ilerlemeyiSifirla();
            },
            itemBuilder: (context, index) {
              final slayt = _slaytlar[index];
              final urunler = _slaytUrunleri(slayt);
              return _SlaytArkaPlani(urunler: urunler);
            },
          ),

          Row(
            children: [
              Expanded(
                flex: 3,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: _oncekineGec,
                  onLongPressStart: (_) {
                    setState(() => _duraklatildi = true);
                    _ilerlemeKontrol.stop();
                  },
                  onLongPressEnd: (_) {
                    setState(() => _duraklatildi = false);
                    _ilerlemeyiBaslat();
                  },
                ),
              ),
              Expanded(
                flex: 7,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: _sonrakineGec,
                  onLongPressStart: (_) {
                    setState(() => _duraklatildi = true);
                    _ilerlemeKontrol.stop();
                  },
                  onLongPressEnd: (_) {
                    setState(() => _duraklatildi = false);
                    _ilerlemeyiBaslat();
                  },
                ),
              ),
            ],
          ),

          // Üst kontroller
            Positioned(
              top: ustBosluk + 8,
              left: 12,
              right: 12,
              child: Column(
                children: [
                  _IlerlemeCubuklari(
                    toplam: _slaytlar.length,
                    aktifIndex: _aktifIndex,
                    ilerleme: _ilerlemeKontrol,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.35),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            color: AppColors.snow,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {},
                behavior: HitTestBehavior.opaque,
                child: AnimatedBuilder(
                  animation: _metinKontrol,
                  builder: (context, _) {
                    final slayt = _slaytlar[_aktifIndex];
                    final urunSayisi = _slaytUrunSayisi(slayt);
                    final kaydirma = Tween<Offset>(
                      begin: const Offset(0, 0.08),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: _metinKontrol,
                      curve: Curves.easeOutCubic,
                    ));
                    final solma = CurvedAnimation(
                      parent: _metinKontrol,
                      curve: Curves.easeOut,
                    );

                    return SlideTransition(
                      position: kaydirma,
                      child: FadeTransition(
                        opacity: solma,
                        child: _SlaytMetinPaneli(
                          slayt: slayt,
                          urunSayisi: urunSayisi,
                          onKesfet: slayt.kategori != null
                              ? () => _kategoriyiAc(slayt.kategori!)
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
    );
  }
}

class _IlerlemeCubuklari extends StatelessWidget {
  const _IlerlemeCubuklari({
    required this.toplam,
    required this.aktifIndex,
    required this.ilerleme,
  });

  final int toplam;
  final int aktifIndex;
  final AnimationController ilerleme;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ilerleme,
      builder: (context, _) {
        return Row(
          children: List.generate(toplam, (index) {
            double deger;
            if (index < aktifIndex) {
              deger = 1;
            } else if (index == aktifIndex) {
              deger = ilerleme.value;
            } else {
              deger = 0;
            }

            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: index < toplam - 1 ? 4 : 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: deger,
                    minHeight: 3,
                    backgroundColor: AppColors.snow.withValues(alpha: 0.25),
                    valueColor: const AlwaysStoppedAnimation(AppColors.snow),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class _SlaytArkaPlani extends StatelessWidget {
  const _SlaytArkaPlani({required this.urunler});

  final List<Urun> urunler;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (urunler.isEmpty)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.plumDustDark, AppColors.plumDust],
              ),
            ),
          )
        else
          _UrunMozaik(urunler: urunler),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            color: AppColors.plumDustDark.withValues(alpha: 0.55),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.35),
                Colors.black.withValues(alpha: 0.15),
                Colors.black.withValues(alpha: 0.75),
              ],
              stops: const [0.0, 0.45, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}

class _UrunMozaik extends StatelessWidget {
  const _UrunMozaik({required this.urunler});

  final List<Urun> urunler;

  @override
  Widget build(BuildContext context) {
    final gosterilecek = urunler.take(6).toList();
    final sutunSayisi = gosterilecek.length <= 4 ? 2 : 3;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: sutunSayisi,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: gosterilecek.length,
      itemBuilder: (context, index) {
        return UrunGorseli(
          yol: gosterilecek[index].gorselUrl,
          fit: BoxFit.cover,
        );
      },
    );
  }
}

class _SlaytMetinPaneli extends StatelessWidget {
  const _SlaytMetinPaneli({
    required this.slayt,
    required this.urunSayisi,
    this.onKesfet,
  });

  final KategoriHikayesi slayt;
  final int urunSayisi;
  final VoidCallback? onKesfet;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        24,
        32,
        24,
        MediaQuery.paddingOf(context).bottom + 36,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withValues(alpha: 0.5),
            Colors.black.withValues(alpha: 0.85),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.snow.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.snow.withValues(alpha: 0.2),
              ),
            ),
            child: Icon(slayt.ikon, color: AppColors.snow, size: 28),
          ),
          const SizedBox(height: 16),
          Text(
            slayt.baslik,
            style: const TextStyle(
              color: AppColors.snow,
              fontSize: 34,
              fontWeight: FontWeight.w800,
              height: 1.1,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            slayt.altBaslik,
            style: TextStyle(
              color: AppColors.plumDustLight.withValues(alpha: 0.95),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            slayt.aciklama,
            style: TextStyle(
              color: AppColors.snow.withValues(alpha: 0.88),
              fontSize: 15,
              height: 1.55,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (!slayt.girisSlayti && urunSayisi > 0) ...[
            const SizedBox(height: 16),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.plumDust.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$urunSayisi ürün',
                style: const TextStyle(
                  color: AppColors.snow,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          if (onKesfet != null) ...[
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onKesfet,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.snow,
                foregroundColor: AppColors.plumDustDark,
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.arrow_forward_rounded, size: 18),
              label: Text('${slayt.baslik} Keşfet'),
            ),
          ] else ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.swipe_rounded,
                  color: AppColors.snow.withValues(alpha: 0.6),
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  'Devam etmek için sağa dokun',
                  style: TextStyle(
                    color: AppColors.snow.withValues(alpha: 0.6),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
