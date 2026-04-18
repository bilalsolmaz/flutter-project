# Mini Katalog Uygulaması

Flutter ile geliştirilmiş mini e-ticaret katalog uygulaması.  
Belge: **Flutter Günlük Eğitim – Proje Çıktısı Raporu**

---

## 📱 Özellikler

- **Discover (Ana Sayfa):** Banner, ürün arama ve 2 sütunlu GridView
- **Ürün Detayı:** Büyük görsel, açıklama, özellikler ve sepete ekle butonu
- **Sepet:** Ürün listesi, toplam fiyat ve checkout akışı
- **Boş Sepet:** Animasyonlu boş durum ekranı
- **Sayfa Geçişleri:** `Navigator.push` ve `MaterialPageRoute`
- **Veri Çekme:** `dart:io` HttpClient ile API; yedek olarak DummyJSON

---

## 🔧 Kullanılan Flutter Sürümü

Flutter **3.x** (Dart SDK **≥ 3.0.0**)  
> Ekstra paket kullanılmamıştır — yalnızca `material.dart`

---

## 🚀 Çalıştırma Adımları

### 1. Yeni bir Flutter projesi oluştur

```bash
flutter create mini_katalog
cd mini_katalog
```

### 2. Bu paketi aç ve dosyaları kopyala

Zip içindeki klasörü açtıktan sonra aşağıdaki dosya/klasörleri  
az önce oluşturduğun `mini_katalog/` projesine kopyala:

```
lib/          →  mini_katalog/lib/
pubspec.yaml  →  mini_katalog/pubspec.yaml
```

### 3. Bağımlılıkları yükle

```bash
flutter pub get
```

### 4. Uygulamayı başlat

```bash
# Bağlı cihaz veya emülatörde
flutter run

# Belirli bir cihazda
flutter run -d <device-id>
```

---

## 🗂 Proje Yapısı

```
lib/
├── main.dart                        # Uygulama giriş noktası
├── models/
│   └── product.dart                 # Ürün veri modeli (fromJson / toJson)
├── services/
│   ├── api_service.dart             # HTTP ile ürün verisi çekme
│   └── cart_service.dart            # ValueNotifier tabanlı sepet yönetimi
├── screens/
│   ├── home_screen.dart             # Ana sayfa (Discover)
│   ├── product_detail_screen.dart   # Ürün detay sayfası
│   └── cart_screen.dart             # Sepet sayfası
└── widgets/
    └── product_card.dart            # Yeniden kullanılabilir ürün kartı
```

---

## 🌐 Veri Kaynakları

| Kaynak | URL |
|--------|-----|
| Birincil API | https://wantapi.com/products.php |
| Banner | https://wantapi.com/assets/banner.png |
| Yedek API | https://dummyjson.com/products |

---

## 📸 Ekran Görüntüleri

> `screenshots/` klasörüne eklenecektir.

---

## ✅ Proje Çıktıları (Eğitim Kazanımları)

- [x] Çalışan Mini Katalog Uygulaması  
- [x] Ana sayfa → Ürün listesi → Ürün detayı ekran yapısı  
- [x] Sayfa geçişleri (`Navigator.push / pop`)  
- [x] Route Arguments (product nesnesi aktarımı)  
- [x] `GridView.builder` ile kart tabanlı tasarım  
- [x] `ValueNotifier` ile basit state güncelleme  
- [x] Asset & görsel yönetimi  
- [x] Proje klasör yapısını doğru kullanma  
