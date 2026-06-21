import 'package:flutter/material.dart';
import 'package:staj_proje/models/urun.dart';

/// Kategori hikayesi slaytında gösterilecek metin ve görsel bilgileri.
class KategoriHikayesi {
  const KategoriHikayesi({
    required this.baslik,
    required this.altBaslik,
    required this.aciklama,
    required this.ikon,
    this.kategori,
  });

  final String baslik;
  final String altBaslik;
  final String aciklama;
  final IconData ikon;

  /// null ise giriş slaytı; dolu ise ilgili ürün kategorisi.
  final String? kategori;

  bool get girisSlayti => kategori == null;
}

/// Yeni sezon koleksiyonu hikaye slaytları ve kategori metinleri.
class KategoriHikayeVerisi {
  KategoriHikayeVerisi._();

  static const List<KategoriHikayesi> slaytlar = [
    KategoriHikayesi(
      baslik: 'Yeni Sezon Koleksiyonu',
      altBaslik: '2026 İlkbahar-Yaz',
      aciklama:
          'Sezonun en trend makyaj ürünlerini keşfedin. Her kategori için özenle seçilmiş parçalarla tanışın; sağa dokunarak keşfe devam edin.',
      ikon: Icons.auto_awesome_rounded,
    ),
    KategoriHikayesi(
      kategori: 'Ruj',
      baslik: 'Ruj',
      altBaslik: 'Dudaklarda zarif bir dokunuş',
      aciklama:
          'Mat ve parlak bitiş seçenekleri, ikonik kırmızılardan günlük ten tonlarına. Dudaklarınıza kalıcılık ve stil katan seçkin rujlar.',
      ikon: Icons.brush_outlined,
    ),
    KategoriHikayesi(
      kategori: 'Far',
      baslik: 'Far',
      altBaslik: 'Göz makyajında yaratıcılık',
      aciklama:
          'Pigmentli paletler, tekli farlar ve göz alıcı renkler. Yumuşak smoky efektlerden ışıltılı gölgelere; sınırsız kombinasyon imkânı.',
      ikon: Icons.palette_outlined,
    ),
    KategoriHikayesi(
      kategori: 'Maskara',
      baslik: 'Maskara',
      altBaslik: 'Bakışlarda etkileyici derinlik',
      aciklama:
          'Hacim, uzunluk ve kıvrım bir arada. Gün boyu kalıcı formüllerle kirpiklerinizi öne çıkarın.',
      ikon: Icons.remove_red_eye_outlined,
    ),
    KategoriHikayesi(
      kategori: 'Fondöten',
      baslik: 'Fondöten',
      altBaslik: 'Doğal ve eşit ten görünümü',
      aciklama:
          'Hafif renklendiricilerden tam kapatıcı formüllere. Cildinizle bütünleşen, doğal ışıltı veren ten ürünleri.',
      ikon: Icons.face_retouching_natural_outlined,
    ),
    KategoriHikayesi(
      kategori: 'Allık',
      baslik: 'Allık',
      altBaslik: 'Yanaklarda doğal canlılık',
      aciklama:
          'Kremsi dokular ve ince pudralar. Yanaklarınıza taze ve sağlıklı bir renk veren çok yönlü allık tonları.',
      ikon: Icons.favorite_border_rounded,
    ),
    KategoriHikayesi(
      kategori: 'Aksesuar',
      baslik: 'Aksesuar',
      altBaslik: 'Makyaj rutininin vazgeçilmezleri',
      aciklama:
          'Fırçalar, aplikatörler ve pratik setler. Profesyonel sonuçlar için ihtiyaç duyduğunuz her araç burada.',
      ikon: Icons.auto_fix_high_outlined,
    ),
  ];

  /// Banner collage için farklı kategorilerden temsilci ürünler seçer.
  static List<Urun> bannerUrunleri(List<Urun> urunler, {int adet = 6}) {
    const oncelik = ['Ruj', 'Far', 'Maskara', 'Fondöten', 'Allık', 'Aksesuar'];
    final secilen = <Urun>[];

    for (final kategori in oncelik) {
      final aday = urunler.where((u) => u.kategori == kategori);
      if (aday.isNotEmpty) {
        secilen.add(aday.first);
      }
      if (secilen.length >= adet) break;
    }

    if (secilen.length < adet) {
      for (final urun in urunler) {
        if (secilen.any((s) => s.id == urun.id)) continue;
        secilen.add(urun);
        if (secilen.length >= adet) break;
      }
    }

    return secilen;
  }

  /// Kategoriye ait ürünleri döndürür (arka plan mozaik için, en fazla [limit] adet).
  static List<Urun> kategoriUrunleri(
    List<Urun> urunler,
    String kategori, {
    int limit = 6,
  }) {
    return urunler.where((u) => u.kategori == kategori).take(limit).toList();
  }

  /// Kategoriye ait ürün sayısını döndürür.
  static int kategoriUrunSayisi(List<Urun> urunler, String kategori) {
    return urunler.where((u) => u.kategori == kategori).length;
  }
}
