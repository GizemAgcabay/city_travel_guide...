# Güzellik Sepetim

Kadınlara yönelik makyaj ve kozmetik ürünlerini listeleyen Flutter mini katalog uygulaması.

## Gereksinimler

- Flutter SDK 3.12.2 veya üzeri
- Dart SDK 3.12.2 veya üzeri

## Kurulum ve Çalıştırma

```bash
flutter pub get
flutter run
```

## Özellikler

- Ana sayfa (banner, kategoriler, öne çıkan ürünler)
- GridView ile ürün listesi
- Ürün detay ekranı
- Named Routes ve MaterialPageRoute ile navigasyon
- Route Arguments ile sayfalar arası veri taşıma
- ListView.builder ile sepet listesi
- Arama ve kategori filtreleme
- Sepet simülasyonu (InheritedWidget + setState)
- JSON tabanlı veri modeli (`fromJson` / `toJson`)
- Asset yönetimi (görseller, JSON)

## Veri Kaynağı

Ürün verileri eğitim kapsamında yerel JSON dosyasından okunur (`assets/data/urunler.json`).
Kaynak simülasyon: [wantapi.com/products.php](https://wantapi.com/products.php)

Banner görseli: `assets/images/banner.png`

## Proje Yapısı

```
lib/
├── main.dart
├── models/
├── data/
├── screens/
├── widgets/
├── theme/
└── state/
```

## Ekran Görüntüleri

Teslim için aşağıdaki ekranların görüntüsünü `docs/screenshots/` klasörüne ekleyin:

1. Ana sayfa
2. Ürün listesi (GridView)
3. Ürün detayı
4. Sepet ekranı

## Tema

- Plum Dust: `#8E6080`
- Snow: `#FFFAFA`
