/// Ürünün tek bir renk seçeneğini temsil eder.
class UrunRenkSecenegi {
  const UrunRenkSecenegi({
    required this.ad,
    required this.gorselUrl,
    required this.gorseller,
    this.fiyat,
  });

  final String ad;
  final String gorselUrl;
  final List<String> gorseller;
  final double? fiyat;

  factory UrunRenkSecenegi.fromJson(Map<String, dynamic> json) {
    return UrunRenkSecenegi(
      ad: json['ad'] as String,
      gorselUrl: json['gorselUrl'] as String,
      gorseller: (json['gorseller'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      fiyat: json['fiyat'] != null ? (json['fiyat'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ad': ad,
      'gorselUrl': gorselUrl,
      'gorseller': gorseller,
      if (fiyat != null) 'fiyat': fiyat,
    };
  }
}
