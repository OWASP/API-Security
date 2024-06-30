# API9:2023 Pengelolaan Inventaris yang Tidak Tepat

| Agen Ancaman/Vektor Serangan | Kelemahan Keamanan | Dampak |
| - | - | - |
| Khusus API : Kemungkinan Dieksploitasi **Mudah** | Prevalensi **Luas** : Kemungkinan Dideteksi **Sedang** | Teknis **Sedang** : Khusus Bisnis |
| Agen ancaman biasanya mendapatkan akses tidak sah melalui versi API lama atau endpoint yang tidak diperbaiki dan menggunakan persyaratan keamanan yang lebih lemah. Dalam beberapa kasus, eksploitasi tersedia. Atau, mereka mungkin mendapatkan akses ke data sensitif melalui pihak ketiga yang tidak ada alasan untuk berbagi data dengannya. | Dokumentasi yang sudah kadaluarsa membuat lebih sulit untuk menemukan dan/atau memperbaiki kerentanan. Ketidakadaan inventaris aset dan strategi pensiun mengakibatkan sistem yang tidak diperbaiki, yang mengakibatkan kebocoran data sensitif. Sangat umum untuk menemukan host API yang terpapar secara tidak perlu karena konsep modern seperti mikro layanan, yang membuat aplikasi mudah untuk dideploy dan mandiri (misalnya, komputasi awan, K8S). Cukup dengan Google Dorking, enumerasi DNS, atau menggunakan mesin pencari khusus untuk berbagai jenis server (webcam, router, server, dll.) yang terhubung ke internet akan cukup untuk menemukan target. | Penyerang dapat memperoleh akses ke data sensitif, atau bahkan mengambil alih server. Terkadang berbagai versi/deployment API terhubung ke database yang sama dengan data nyata. Agen ancaman dapat mengeksploitasi endpoint yang sudah tidak digunakan yang tersedia dalam versi API lama untuk mendapatkan akses ke fungsi administratif atau mengeksploitasi kerentanan yang sudah dikenal. |

## Apakah API Rentan?

Sifat API dan aplikasi modern yang tersebar dan terhubung membawa tantangan baru. Penting bagi organisasi untuk tidak hanya memiliki pemahaman yang baik dan visibilitas terhadap API dan endpoint API mereka sendiri, tetapi juga bagaimana API menyimpan atau berbagi data dengan pihak ketiga eksternal.

Menjalankan beberapa versi API memerlukan sumber daya manajemen tambahan
dari penyedia API dan memperluas permukaan serangan.

Sebuah API memiliki "<ins>blindspot dokumentasi</ins>" jika:

* Tujuan host API tidak jelas, dan tidak ada jawaban eksplisit untuk
  pertanyaan-pertanyaan berikut
    * Lingkungan mana yang digunakan API (misalnya, produksi, staging, tes,
    pengembangan)?
    * Siapa yang seharusnya memiliki akses jaringan ke API (misalnya, publik, internal, mitra)?
    * Versi API mana yang sedang berjalan?
* Tidak ada dokumentasi atau dokumentasi yang ada tidak diperbarui.
* Tidak ada rencana pensiun untuk setiap versi API.
* Inventaris host hilang atau sudah kadaluarsa.

Visibilitas dan inventaris aliran data sensitif memainkan peran penting sebagai
bagian dari rencana respons insiden, jika terjadi pelanggaran di sisi pihak ketiga.

Sebuah API memiliki "<ins>blindspot aliran data</ins>" jika:

* Ada "aliran data sensitif" di mana API berbagi data sensitif dengan pihak ketiga dan
    * Tidak ada justifikasi bisnis atau persetujuan atas aliran tersebut
    * Tidak ada inventaris atau visibilitas aliran tersebut
    * Tidak ada visibilitas mendalam tentang jenis data sensitif yang dibagikan


## Contoh Skenario Serangan

### Skenario #1

Sebuah jaringan sosial mengimplementasikan mekanisme pembatasan laju yang menghalangi penyerang
menggunakan metode brute force untuk menebak token reset kata sandi. Mekanisme ini tidak
diimplementasikan sebagai bagian dari kode API itu sendiri tetapi di komponen terpisah antara
klien dan API resmi (`api.socialnetwork.owasp.org`). Seorang peneliti menemukan host API beta
(`beta.api.socialnetwork.owasp.org`) yang menjalankan API yang sama, termasuk mekanisme reset kata sandi,
tetapi mekanisme pembatasan laju tidak ada. Peneliti tersebut berhasil mereset kata sandi
pengguna dengan menebak token 6 digit menggunakan brute force.

### Skenario #2

Sebuah jaringan sosial memungkinkan pengembang aplikasi independen untuk mengintegrasikan dengan
mereka. Sebagai bagian dari proses ini, izin diminta dari pengguna akhir, sehingga jaringan sosial
dapat berbagi informasi pribadi pengguna dengan aplikasi independen.

Aliran data antara jaringan sosial dan aplikasi independen tidak cukup dibatasi atau dimonitor,
memungkinkan aplikasi independen untuk mengakses tidak hanya
informasi pengguna tetapi juga informasi pribadi dari semua teman mereka.

Sebuah firma konsultan membangun aplikasi berbahaya dan berhasil mendapatkan izin dari
270.000 pengguna. Karena kelemahan ini, firma konsultan berhasil mengakses
informasi pribadi dari 50.000.000 pengguna. Kemudian, firma konsultan
menjual informasi tersebut untuk tujuan berbahaya.

## Cara Mencegah

* Inventarisasi semua <ins>host API</ins> dan dokumentasikan aspek penting dari masing-masing di
  antaranya, berfokus pada lingkungan API (misalnya, produksi, staging, tes, pengembangan), siapa yang
  seharusnya memiliki akses jaringan ke host (misalnya, publik, internal, mitra) dan versi API.
* Inventarisasi <ins>layanan terintegrasi</ins> dan dokumentasikan aspek penting seperti peran mereka
  dalam sistem, data apa yang dipertukarkan (aliran data), dan sensitivitasnya.
* Dokumentasikan semua aspek API Anda seperti otentikasi, kesalahan, pengalihan, pembatasan laju,
  kebijakan berbagi sumber daya lintas asal (CORS), dan endpoint, termasuk parameter, permintaan, dan tanggapan.
* Hasilkan dokumentasi secara otomatis dengan mengadopsi standar terbuka. Sertakan pembangunan dokumentasi dalam jalur CI/CD Anda.
* Buat dokumentasi API hanya tersedia bagi mereka yang berwenang untuk menggunakan API.
* Gunakan langkah-langkah perlindungan eksternal seperti solusi keamanan API yang spesifik untuk semua versi API Anda yang terpapar, tidak hanya untuk versi produksi saat ini.
* Hindari menggunakan data produksi dengan implementasi API non-produksi. Jika hal ini tidak dapat dihindari, endpoint ini harus mendapatkan perlakuan keamanan yang sama dengan endpoint produksi.
* Ketika versi API yang lebih baru mencakup perbaikan keamanan, lakukan analisis risiko untuk
  memberi tahu tindakan mitigasi yang diperlukan untuk versi lama. Misalnya, apakah memungkinkan untuk melakukan backport perbaikan tanpa merusak kompatibilitas API atau apakah Anda perlu segera menghapus versi lama dan memaksa semua klien beralih ke versi terbaru.


## Referensi

### Eksternal

* [CWE-1059: Dokumentasi yang Tidak Lengkap][1]

[1]: https://cwe.mitre.org/data/definitions/1059.html