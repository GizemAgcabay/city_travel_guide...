# Adana Gezi Rehberi

Adana'nın tarihi yapılarını, müzelerini, camilerini ve doğal güzelliklerini tanıtan bir web projesi. Proje HTML, CSS ve JavaScript kullanılarak ders kapsamında geliştirildi.

## Sitede neler var?

- **Gezilecek Yerler:** Mekanlar *Tarihi Yapılar*, *Nehir ve Parklar* ve *Müzeler ve Camiler* başlıkları altında gruplandırılır.
- **Mekan Detayları:** Mekanların fotoğrafları, açıklamaları ve ziyaret bilgileri tek sayfada alt alta gösterilir. Ana sayfadaki **Detayları gör** bağlantısı doğrudan ilgili mekanın bölümüne gider.
- **Mekan Öner:** Ziyaretçi bir mekan önerebilir ve kaydetmeden önce bilgilerini onaylayabilir. Kaydedilen öneri ana sayfadaki **Önerilen Mekanlar** bölümünde görünür.
- **Ücretler ve Saatler:** Giriş ücretleri, ziyaret saatleri, kapalı günler ve kaynak bağlantıları bir arada sunulur. Bugünün tarihi İstanbul saatine göre gösterilir. Tablonun derlenme tarihi, bilgiler yeniden kontrol edildiğinde güncellenir.

## Kullanılan teknolojiler

- **HTML:** Sayfa yapısı, öneri formu ve ziyaret tablosu
- **CSS:** Renkler, tipografi, kartlar, Grid ve Flexbox yerleşimleri, mobil uyum
- **JavaScript:** Mekan kartları ve detayları, tarih gösterimi ve öneri kaydı

## Proje yapısı

```text
adana-gezi-rehberi/
├── index.html
├── details.html
├── suggest.html
├── fees-hours.html
├── css/
│   └── style.css
└── js/
    └── script.js
```

## Bilgisayarda çalıştırma

1. Proje klasörünü VS Code'da aç.
2. **Live Server** eklentisini kur.
3. `index.html` dosyasına sağ tıkla ve **Open with Live Server** seç.

Proje bir veritabanı veya backend gerektirmez. Mekan önerileri `localStorage` ile yalnızca kullanılan tarayıcıda ve aynı site adresinde saklanır. Dış bağlantılardaki fotoğrafların yüklenmesi için internet bağlantısı gerekir.

## Kaynaklar

Ücret ve ziyaret saatlerine ilişkin bağlantılar, **Ücretler ve Saatler** sayfasının **Resmî kaynaklar** bölümünde listelenmiştir. Mekan fotoğrafları Wikimedia Commons üzerinden yüklenir. Ana sayfanın kapak görseli Tatil Ana üzerinden alınmıştır.
