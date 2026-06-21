import 'package:flutter/material.dart';
import 'package:staj_proje/models/urun.dart';

/// Sepet durumunu alt widget'lara aktaran InheritedWidget.
/// Ek paket kullanmadan basit state yönetimi sağlar.
class SepetMiras extends InheritedWidget {
  const SepetMiras({
    super.key,
    required this.sepetUrunleri,
    required this.sepeteEkle,
    required this.sepettenCikar,
    required this.sepetiTemizle,
    required super.child,
  });

  final List<Urun> sepetUrunleri;
  final void Function(Urun urun) sepeteEkle;
  final void Function(Urun urun) sepettenCikar;
  final VoidCallback sepetiTemizle;

  /// Sepetteki toplam ürün adedi.
  int get urunAdedi => sepetUrunleri.length;

  /// Sepetteki ürünlerin toplam fiyatı.
  double get toplamFiyat {
    return sepetUrunleri.fold(0, (toplam, urun) => toplam + urun.fiyat);
  }

  /// Alt widget'lardan sepet durumuna erişim sağlar.
  static SepetMiras of(BuildContext context) {
    final sonuc = context.dependOnInheritedWidgetOfExactType<SepetMiras>();
    assert(sonuc != null, 'SepetMiras bulunamadı. Widget ağacına eklendi mi?');
    return sonuc!;
  }

  @override
  bool updateShouldNotify(SepetMiras eskiWidget) {
    return sepetUrunleri != eskiWidget.sepetUrunleri;
  }
}
