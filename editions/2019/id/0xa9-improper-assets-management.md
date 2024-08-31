# API9:2019 Pengelolaan Aset yang Tidak Tepat

| Agen Ancaman/Vektor Serangan | Kelemahan Keamanan | Dampak |
| - | - | - |
| Khusus API: Eksploitasi **3** | Prevalensi **3** : Deteksi **2** | Teknis **2** : Spesifik Bisnis |
| Versi API lama biasanya tidak diperbarui dan merupakan cara mudah untuk mengkompromikan sistem tanpa harus melawan mekanisme keamanan mutakhir, yang mungkin ada untuk melindungi versi API terbaru. | Dokumentasi yang sudah ketinggalan zaman membuatnya lebih sulit untuk menemukan dan/atau memperbaiki kerentanan. Kurangnya inventarisasi aset dan strategi pensiun menyebabkan menjalankan sistem yang tidak diperbarui, yang mengakibatkan kebocoran data sensitif. Umum ditemukan host API yang terpapar secara tidak perlu karena konsep modern seperti mikroservis, yang memudahkan aplikasi untuk diterapkan dan independen (misalnya, komputasi cloud, k8s). | Penyerang dapat memperoleh akses ke data sensitif, atau bahkan mengambil alih server melalui versi API lama yang tidak diperbarui yang terhubung ke basis data yang sama. |

## Apakah API Rentan?

API mungkin rentan jika:

* Tujuan dari host API tidak jelas, dan tidak ada jawaban eksplisit untuk pertanyaan berikut:
    * Lingkungan apa API berjalan (misalnya, produksi, staging, pengujian, pengembangan)?
    * Siapa yang seharusnya memiliki akses jaringan ke API (misalnya, publik, internal, mitra)?
    * Versi API apa yang berjalan?
    * Data apa yang dikumpulkan dan diproses oleh API (misalnya, PII)?
    * Bagaimana aliran datanya?
* Tidak ada dokumentasi, atau dokumentasi yang ada tidak diperbarui.
* Tidak ada rencana pensiun untuk setiap versi API.  
* Inventarisasi host hilang atau ketinggalan zaman.
* Inventarisasi layanan terintegrasi, baik pihak pertama maupun ketiga, hilang atau ketinggalan zaman. 
* Versi API lama atau sebelumnya berjalan tanpa patch.

## Skenario Serangan Contoh

### Skenario #1

Setelah merancang ulang aplikasi mereka, layanan pencarian lokal meninggalkan versi API lama (`api.someservice.com/v1`) berjalan, tidak dilindungi, dan dengan akses ke basis data pengguna. Saat menargetkan salah satu aplikasi rilis terbaru, seorang penyerang menemukan alamat API (`api.someservice.com/v2`). Mengganti `v2` dengan `v1` di URL memberi penyerang akses ke API lama, tidak dilindungi, yang memaparkan informasi identifikasi pribadi (PII) lebih dari 100 juta pengguna.

### Skenario #2

Sebuah jaringan sosial menerapkan mekanisme pembatasan laju yang memblokir penyerang dari menggunakan brute-force untuk menebak token reset kata sandi. Mekanisme ini tidak diimplementasikan sebagai bagian dari kode API itu sendiri, tetapi dalam komponen terpisah antara klien dan API resmi (`www.socialnetwork.com`). Seorang peneliti menemukan host API beta (`www.mbasic.beta.socialnetwork.com`) yang menjalankan API yang sama, termasuk mekanisme reset kata sandi, tetapi mekanisme pembatasan laju tidak diterapkan. Peneliti dapat mereset kata sandi pengguna mana pun dengan menggunakan brute-force sederhana untuk menebak token 6 digit.

## Cara Mencegah

* Inventarisasi semua host API dan dokumentasikan aspek penting dari masing-masing, berfokus pada lingkungan API (misalnya, produksi, staging, pengujian, pengembangan), siapa yang seharusnya memiliki akses jaringan ke host (misalnya, publik, internal, mitra) dan versi API.
* Inventarisasi layanan terintegrasi dan dokumentasikan aspek penting seperti peran mereka dalam sistem, data apa yang dipertukarkan (aliran data), dan sensitivitasnya.  
* Dokumentasikan semua aspek API Anda seperti otentikasi, kesalahan, pengalihan, pembatasan laju, kebijakan berbagi sumber daya lintas asal (CORS) dan endpoint, termasuk parameter, permintaan, dan respons mereka.
* Hasilkan dokumentasi secara otomatis dengan mengadopsi standar terbuka. Sertakan pembangunan dokumentasi dalam pipeline CI/CD Anda.
* Buat dokumentasi API tersedia untuk mereka yang berwenang menggunakan API.
* Gunakan langkah-langkah perlindungan eksternal seperti firewall keamanan API untuk semua versi terekspos API Anda, bukan hanya untuk versi produksi saat ini.
* Hindari menggunakan data produksi dengan penerapan API non-produksi. Jika ini tidak dapat dihindari, endpoint ini harus mendapatkan perlakuan keamanan yang sama dengan produksi.
* Ketika versi API yang lebih baru mencakup peningkatan keamanan, lakukan analisis risiko untuk membuat keputusan tindakan mitigasi yang diperlukan untuk versi yang lebih tua: misalnya, apakah mungkin menerapkan peningkatan tanpa merusak kompatibilitas API atau Anda perlu menarik versi yang lebih tua dengan cepat dan memaksa semua klien beralih ke versi terbaru.

## Referensi

### Eksternal 

* [CWE-1059: Dokumentasi yang Tidak Lengkap][1] 
* [Inisiatif OpenAPI][2]

[1]: https://cwe.mitre.org/data/definitions/1059.html
[2]: https://www.openapis.org/
