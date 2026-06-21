import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:staj_proje/models/urun.dart';

/// Ürün verilerini asset JSON dosyasından yükler ve filtreler.
///
/// Veri kaynağı eğitim simülasyonu: https://wantapi.com/products.php
/// Banner görseli: https://wantapi.com/assets/banner.png
class UrunVerisi {
  UrunVerisi._();

  /// Ana sayfa banner görseli (wantapi banner'ının yerel kopyası).
  static const String bannerAsset = 'assets/images/banner.png';

  static List<Urun>? _onbellek;

  /// JSON dosyasından tüm ürünleri okur ve listeler.
  static Future<List<Urun>> urunleriYukle() async {
    if (_onbellek != null) {
      return _onbellek!;
    }

    final jsonMetni =
        await rootBundle.loadString('assets/data/urunler.json');
    final List<dynamic> jsonListe = json.decode(jsonMetni) as List<dynamic>;

    _onbellek = jsonListe
        .map((oge) => Urun.fromJson(oge as Map<String, dynamic>))
        .toList();

    return _onbellek!;
  }

  /// Ürün listesindeki benzersiz kategorileri döndürür.
  static List<String> kategorileriGetir(List<Urun> urunler) {
    final kategoriler = urunler.map((u) => u.kategori).toSet().toList();
    kategoriler.sort();
    return kategoriler;
  }

  /// Arama metni ve kategoriye göre ürünleri filtreler.
  static List<Urun> filtrele({
    required List<Urun> urunler,
    required String aramaMetni,
    String? seciliKategori,
  }) {
    final arama = aramaMetni.trim().toLowerCase();

    return urunler.where((urun) {
      final kategoriUygun = seciliKategori == null ||
          seciliKategori == 'Tümü' ||
          urun.kategori == seciliKategori;

      final aramaUygun = arama.isEmpty ||
          urun.ad.toLowerCase().contains(arama) ||
          urun.marka.toLowerCase().contains(arama) ||
          urun.kategori.toLowerCase().contains(arama);

      return kategoriUygun && aramaUygun;
    }).toList();
  }
}
