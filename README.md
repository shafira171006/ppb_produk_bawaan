# Citra's Haven - Mobile Flutter App

Aplikasi mobile berbasis Flutter yang dikembangkan untuk menampilkan daftar produk, pencarian produk secara interaktif, dan halaman detail produk dengan memanfaatkan REST API dari **DummyJSON**[cite: 1, 2]. Aplikasi ini dirancang dengan antarmuka khusus seluler yang mengusung tema skema warna pastel yang lembut dan estetik[cite: 1, 3].

## 👩‍💻 Identitas Pengembang
* **Nama:** Shafira Fitri Citra Ramadhanti
* **Program Studi:** Teknik Informatika (Semester 5)
* **Institusi:** Universitas Muhammadiyah Bandung

---

## ✨ Fitur Utama Aplikasi
1. **Dinamis dari API DummyJSON:** Mengambil data produk, kategori, dan detail secara *real-time* dari endpoint resmi DummyJSON[cite: 1].
2. **Skema Warna Pastel:** Antarmuka menggunakan palet warna pastel yang manis dan nyaman dipandang (Lavender, Mint, Peach, Soft Pink)[cite: 1, 3].
3. **Pencarian Fungsional (Search Bar):** Fitur pencarian produk secara instan berdasarkan kata kunci[cite: 1].
4. **Navigasi Kategori:** Menyaring produk berdasarkan kategori pilihan secara horizontal.
5. **Halaman Detail Produk:** Menampilkan informasi lengkap mulai dari gambar, harga, rating bintang, merek (brand), stok, hingga deskripsi produk[cite: 4].
6. **Manajemen Data (CRUD Support):** Mendukung penambahan, penyuntingan, dan penghapusan data produk.

---

## 📂 Struktur Proyek & Arsitektur
Proyek ini dibangun menggunakan arsitektur modular yang bersih di Flutter:
* `lib/models/`: Berisi pemodelan data (`product_model.dart`) untuk parsing JSON ke objek Dart secara *strongly-typed* beserta proteksi *null-safety*[cite: 2].
* `lib/service/`: Berisi pengaturan jaringan (`api_service.dart`) menggunakan package **Dio** untuk mengatur komunikasi HTTP dengan DummyJSON.
* `lib/screens/`: Berisi tampilan antarmuka utama seperti `ListProductScreen` (halaman utama) dan `DetailProductScreen` (halaman detail)[cite: 2].
* `lib/providers/`: Mengatur state management aplikasi secara reaktif.

---

📹 Video Demo & Presentasi
    Link Video YouTube (Demo & Penjelasan): [https://youtu.be/uWzVsQZRVR0?si=BKCJJuinz-cGhBCf]
   
