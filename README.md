# YouApp

YouApp adalah aplikasi modern yang terdiri dari dua bagian utama: **YouApp Backend** (API server berbasis NestJS) dan **YouApp Mobile** (aplikasi mobile cross-platform berbasis Flutter). Aplikasi ini dirancang untuk memberikan pengalaman pengguna yang interaktif, aman, dan mudah diakses di berbagai perangkat.

## Fitur Utama
- **Autentikasi & Otorisasi**: Sistem login/register dengan JWT untuk keamanan data pengguna.
- **Chat Real-Time**: Komunikasi instan antar pengguna menggunakan WebSocket.
- **Manajemen Pengguna**: CRUD profil, pengaturan akun, dan fitur sosial lainnya.
- **Arsitektur Modular**: Kode backend dan mobile terstruktur rapi, mudah dikembangkan dan dipelihara.

## Tech Stack

### Backend (youapp_backend)
- **NestJS**: Framework Node.js progresif untuk membangun aplikasi backend yang scalable dan maintainable.
- **TypeScript**: Bahasa utama untuk pengembangan backend, memberikan type safety dan produktivitas tinggi.
- **WebSocket**: Untuk fitur chat real-time.
- **JWT (JSON Web Token)**: Untuk autentikasi dan otorisasi yang aman.
- **Docker**: Mendukung deployment dan pengembangan yang konsisten di berbagai environment.

### Mobile (youapp_mobile)
- **Flutter**: Framework UI dari Google untuk membangun aplikasi mobile cross-platform (Android, iOS, Web, Desktop) dari satu basis kode.
- **Dart**: Bahasa pemrograman utama untuk Flutter.
- **Provider**: State management yang efisien dan mudah digunakan.
- **Integrasi API**: Komunikasi dengan backend menggunakan HTTP/REST API.

## Struktur Proyek
```
youapp_backend/   # Source code backend (NestJS)
youapp_mobile/    # Source code aplikasi mobile (Flutter)
```

## Cara Menjalankan
### Backend
1. Masuk ke folder `youapp_backend`
2. Install dependencies: `npm install`
3. Jalankan server: `npm run start:dev`

### Mobile
1. Masuk ke folder `youapp_mobile`
2. Install dependencies: `flutter pub get`
3. Jalankan aplikasi: `flutter run`

## Kontribusi
Kontribusi sangat terbuka! Silakan fork repository ini, buat branch baru, dan ajukan pull request.

---

**YouApp** – Solusi aplikasi modern, cepat, dan fleksibel untuk kebutuhan Anda!