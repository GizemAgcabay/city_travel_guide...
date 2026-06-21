import 'package:staj_proje/models/urun_renk_secenegi.dart';

/// Makyaj ürününü temsil eden veri modeli.
/// JSON dosyasından okunan veriler bu sınıfa dönüştürülür.
class Urun {
  const Urun({
    required this.id,
    required this.ad,
    required this.marka,
    required this.kategori,
    required this.fiyat,
    required this.gorselUrl,
    required this.aciklama,
    this.renk,
    this.gorseller = const [],
    this.renkSecenekleri = const [],
  });

  final int id;
  final String ad;
  final String marka;
  final String kategori;
  final double fiyat;
  final String gorselUrl;
  final String aciklama;
  final String? renk;
  final List<String> gorseller;
  final List<UrunRenkSecenegi> renkSecenekleri;

  /// Liste ve kartlarda gösterilecek tüm görseller.
  List<String> get tumGorseller {
    if (gorseller.isNotEmpty) return gorseller;
    return [gorselUrl];
  }

  /// Varsayılan veya eşleşen renk seçeneğini döndürür.
  UrunRenkSecenegi? renkSecenegiBul(String? renkAdi) {
    if (renkSecenekleri.isEmpty) return null;
    if (renkAdi != null) {
      for (final secenek in renkSecenekleri) {
        if (secenek.ad.toLowerCase() == renkAdi.toLowerCase()) {
          return secenek;
        }
      }
    }
    return renkSecenekleri.first;
  }

  /// Seçilen renge göre gösterilecek görseller.
  List<String> gorsellerForRenk(String? renkAdi) {
    final secenek = renkSecenegiBul(renkAdi);
    if (secenek != null && secenek.gorseller.isNotEmpty) {
      return secenek.gorseller;
    }
    return tumGorseller;
  }

  /// Seçilen renge göre kapak görseli.
  String kapakGorseliForRenk(String? renkAdi) {
    final secenek = renkSecenegiBul(renkAdi);
    if (secenek != null) return secenek.gorselUrl;
    return gorselUrl;
  }

  /// Seçilen renge göre fiyat (renk bazlı fiyat yoksa ana fiyat).
  double fiyatForRenk(String? renkAdi) {
    final secenek = renkSecenegiBul(renkAdi);
    return secenek?.fiyat ?? fiyat;
  }

  /// JSON haritasından Urun nesnesi oluşturur.
  factory Urun.fromJson(Map<String, dynamic> json) {
    final renkler = json['renkSecenekleri'] as List<dynamic>?;
    return Urun(
      id: json['id'] as int,
      ad: json['ad'] as String,
      marka: json['marka'] as String,
      kategori: json['kategori'] as String,
      fiyat: (json['fiyat'] as num).toDouble(),
      gorselUrl: json['gorselUrl'] as String,
      aciklama: json['aciklama'] as String,
      renk: json['renk'] as String?,
      gorseller: (json['gorseller'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      renkSecenekleri: renkler
              ?.map(
                (e) => UrunRenkSecenegi.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );
  }

  /// Urun nesnesini JSON haritasına dönüştürür.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ad': ad,
      'marka': marka,
      'kategori': kategori,
      'fiyat': fiyat,
      'gorselUrl': gorselUrl,
      'aciklama': aciklama,
      'renk': renk,
      if (gorseller.isNotEmpty) 'gorseller': gorseller,
      if (renkSecenekleri.isNotEmpty)
        'renkSecenekleri':
            renkSecenekleri.map((r) => r.toJson()).toList(),
    };
  }

  /// Fiyatı Türk Lirası formatında döndürür.
  String get fiyatMetni => '${fiyat.toStringAsFixed(2)} ₺';

  String fiyatMetniForRenk(String? renkAdi) =>
      '${fiyatForRenk(renkAdi).toStringAsFixed(2)} ₺';
}
