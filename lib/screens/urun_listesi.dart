import 'package:flutter/material.dart';
import 'package:staj_proje/data/urun_verisi.dart';
import 'package:staj_proje/models/urun.dart';
import 'package:staj_proje/state/sepet_miras.dart';
import 'package:staj_proje/theme/app_colors.dart';
import 'package:staj_proje/widgets/app_logo.dart';
import 'package:staj_proje/widgets/arama_cubugu.dart';
import 'package:staj_proje/screens/urun_detay.dart';
import 'package:staj_proje/widgets/urun_karti.dart';

/// Tüm ürünlerin grid düzeninde listelendiği ekran.
class UrunListesiSayfasi extends StatefulWidget {
  const UrunListesiSayfasi({super.key});

  @override
  State<UrunListesiSayfasi> createState() => _UrunListesiSayfasiState();
}

class _UrunListesiSayfasiState extends State<UrunListesiSayfasi> {
  final _aramaController = TextEditingController();
  List<Urun> _tumUrunler = [];
  List<Urun> _filtrelenmisUrunler = [];
  List<String> _kategoriler = ['Tümü'];
  String _seciliKategori = 'Tümü';
  bool _yukleniyor = true;
  bool _kategoriArgumaniOkundu = false;

  @override
  void initState() {
    super.initState();
    _verileriYukle();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _baslangicKategorisiniUygula();
  }

  /// Ana sayfadan gelen kategori argümanını bir kez okur.
  void _baslangicKategorisiniUygula() {
    if (_kategoriArgumaniOkundu) return;
    final gelenKategori = ModalRoute.of(context)?.settings.arguments;
    if (gelenKategori is String) {
      _seciliKategori = gelenKategori;
      _kategoriArgumaniOkundu = true;
      if (!_yukleniyor) {
        _filtreUygula();
      }
    }
  }

  @override
  void dispose() {
    _aramaController.dispose();
    super.dispose();
  }

  Future<void> _verileriYukle() async {
    final urunler = await UrunVerisi.urunleriYukle();
    if (mounted) {
      _baslangicKategorisiniUygula();
      setState(() {
        _tumUrunler = urunler;
        _kategoriler = ['Tümü', ...UrunVerisi.kategorileriGetir(urunler)];
        _filtreUygula();
        _yukleniyor = false;
      });
    }
  }

  /// Arama metni ve kategoriye göre listeyi günceller.
  void _filtreUygula() {
    _filtrelenmisUrunler = UrunVerisi.filtrele(
      urunler: _tumUrunler,
      aramaMetni: _aramaController.text,
      seciliKategori: _seciliKategori,
    );
  }

  @override
  Widget build(BuildContext context) {
    final sepet = SepetMiras.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const AppLogoBaslik(baslik: 'Ürünler'),
        actions: [SepetIkonu(urunAdedi: sepet.urunAdedi)],
      ),
      body: _yukleniyor
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.plumDust),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: AramaCubugu(
                    controller: _aramaController,
                    onChanged: (_) => setState(_filtreUygula),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: KategoriFiltreleri(
                    kategoriler: _kategoriler,
                    seciliKategori: _seciliKategori,
                    onSecim: (kategori) {
                      setState(() {
                        _seciliKategori = kategori;
                        _filtreUygula();
                      });
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${_filtrelenmisUrunler.length} ürün bulundu',
                      style: const TextStyle(
                        color: AppColors.metinAcik,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: _filtrelenmisUrunler.isEmpty
                      ? const Center(
                          child: Text(
                            'Aramanıza uygun ürün bulunamadı.',
                            style: TextStyle(color: AppColors.metinOrta),
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            childAspectRatio: 0.62,
                          ),
                          itemCount: _filtrelenmisUrunler.length,
                          itemBuilder: (context, index) {
                            final urun = _filtrelenmisUrunler[index];
                            return UrunKarti(
                              urun: urun,
                              heroEtiketi: 'urun-${urun.id}',
                              onTap: () => UrunDetaySayfasi.git(context, urun),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
