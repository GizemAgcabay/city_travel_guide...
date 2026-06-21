/// Açılış ekranı süresini cihaz performansına göre hesaplar.
///
/// Hızlı cihazlarda animasyon en az [minSure] kadar görünür;
/// yavaş cihazlarda veri yükleme süresine ek tampon eklenir.
class AcilisSuresi {
  AcilisSuresi._();

  /// Animasyonun tam olarak izlenebilmesi için alt sınır.
  static const Duration minSure = Duration(milliseconds: 2800);

  /// Çok yavaş cihazlarda üst sınır.
  static const Duration maxSure = Duration(milliseconds: 6000);

  /// Yükleme sonrası animasyon için ek süre (yavaş cihazlara nefes payı).
  static const int tamponMs = 900;

  /// [hazirlik] tamamlanana kadar geçen süreye göre açılış süresini döndürür.
  static Future<Duration> hesapla({
    required Future<void> Function() hazirlik,
  }) async {
    final kronometre = Stopwatch()..start();
    await hazirlik();
    kronometre.stop();

    final hedefMs = (kronometre.elapsedMilliseconds + tamponMs).clamp(
      minSure.inMilliseconds,
      maxSure.inMilliseconds,
    );

    return Duration(milliseconds: hedefMs);
  }
}
