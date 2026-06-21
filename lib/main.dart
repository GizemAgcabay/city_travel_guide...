import 'package:flutter/material.dart';
import 'package:staj_proje/models/urun.dart';
import 'package:staj_proje/screens/acilis_ekrani.dart';
import 'package:staj_proje/screens/ana_sayfa.dart';
import 'package:staj_proje/screens/sepet_sayfasi.dart';
import 'package:staj_proje/screens/urun_detay.dart';
import 'package:staj_proje/screens/urun_listesi.dart';
import 'package:staj_proje/state/sepet_miras.dart';
import 'package:staj_proje/theme/app_theme.dart';

void main() {
  runApp(const BeautyBagApp());
}

class BeautyBagApp extends StatefulWidget {
  const BeautyBagApp({super.key});

  @override
  State<BeautyBagApp> createState() => _BeautyBagAppState();
}

class _BeautyBagAppState extends State<BeautyBagApp> {
  final List<Urun> _sepetUrunleri = [];

  void _sepeteEkle(Urun urun) {
    setState(() {
      if (!_sepetUrunleri.any((u) => u.id == urun.id)) {
        _sepetUrunleri.add(urun);
      }
    });
  }

  void _sepettenCikar(Urun urun) {
    setState(() {
      _sepetUrunleri.removeWhere((u) => u.id == urun.id);
    });
  }

  void _sepetiTemizle() {
    setState(() => _sepetUrunleri.clear());
  }

  @override
  Widget build(BuildContext context) {
    return SepetMiras(
      sepetUrunleri: List.unmodifiable(_sepetUrunleri),
      sepeteEkle: _sepeteEkle,
      sepettenCikar: _sepettenCikar,
      sepetiTemizle: _sepetiTemizle,
      child: MaterialApp(
        title: 'Güzellik Sepetim',
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(),
        initialRoute: '/acilis',
        onGenerateRoute: _rotaOlustur,
      ),
    );
  }

  Route<dynamic> _rotaOlustur(RouteSettings ayarlar) {
    switch (ayarlar.name) {
      case '/acilis':
        return PageRouteBuilder(
          settings: ayarlar,
          pageBuilder: (context, _, __) => AcilisEkrani(
            onTamamlandi: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );
      case '/':
        return MaterialPageRoute(
          settings: ayarlar,
          builder: (_) => const AnaSayfa(),
        );
      case '/urunler':
        return MaterialPageRoute(
          settings: ayarlar,
          builder: (_) => const UrunListesiSayfasi(),
        );
      case '/detay':
        return MaterialPageRoute(
          settings: ayarlar,
          builder: (_) => const UrunDetaySayfasi(),
        );
      case '/sepet':
        return MaterialPageRoute(
          settings: ayarlar,
          builder: (_) => const SepetSayfasi(),
        );
      default:
        return MaterialPageRoute(
          settings: ayarlar,
          builder: (_) => const AnaSayfa(),
        );
    }
  }
}
