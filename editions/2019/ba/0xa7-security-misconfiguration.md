# API7:2019 Kesalahan Konfigurasi Keamanan 

| Agen Ancaman/Vektor Serangan | Kelemahan Keamanan | Dampak |
| - | - | - |
| Khusus API: Eksploitasi **3** | Prevalensi **3** : Deteksi **3** | Teknis **2** : Spesifik Bisnis |
| Penyerang sering mencoba menemukan celah yang tidak diperbarui, endpoint umum, atau file dan direktori yang tidak dilindungi untuk mendapatkan akses yang tidak sah atau pengetahuan tentang sistem. | Kesalahan konfigurasi keamanan dapat terjadi pada setiap level tumpukan API, dari level jaringan hingga level aplikasi. Alat otomatis tersedia untuk mendeteksi dan memanfaatkan kesalahan konfigurasi seperti layanan yang tidak perlu atau opsi warisan. | Kesalahan konfigurasi keamanan tidak hanya dapat mengekspos data pengguna yang sensitif, tetapi juga rincian sistem yang dapat mengarah ke kompromi server penuh. |

## Apakah API Rentan? 

API mungkin rentan jika:

* Pengerasan keamanan yang tepat hilang di bagian mana pun dari tumpukan aplikasi, atau jika memiliki izin yang dikonfigurasi dengan salah pada layanan cloud.
* Perbaikan keamanan terbaru hilang, atau sistemnya sudah ketinggalan zaman. 
* Fitur yang tidak perlu diaktifkan (misalnya, kata kerja HTTP).
* Keamanan Lapisan Transport (TLS) hilang.
* Direktif keamanan tidak dikirim ke klien (misalnya, [Security Headers][1]).
* Kebijakan Berbagi Sumber Daya Lintas Asal (CORS) hilang atau disetel dengan salah.
* Pesan kesalahan termasuk jejak tumpukan, atau informasi sensitif lainnya terekspos.

## Skenario Serangan Contoh

### Skenario #1

Seorang penyerang menemukan file `.bash_history` di bawah direktori root server, yang berisi perintah yang digunakan oleh tim DevOps untuk mengakses API:

```
$ curl -X GET 'https://api.server/endpoint/' -H 'authorization: Basic Zm9vOmJhcg=='
```

Penyerang juga bisa menemukan endpoint baru pada API yang hanya digunakan oleh tim DevOps dan tidak didokumentasikan.

### Skenario #2 

Untuk menargetkan layanan tertentu, seorang penyerang menggunakan mesin pencari populer untuk mencari komputer yang dapat diakses langsung dari Internet. Penyerang menemukan host yang menjalankan sistem manajemen basis data populer, mendengarkan di port default. Host tersebut menggunakan konfigurasi default, yang secara default menonaktifkan otentikasi, dan penyerang mendapatkan akses ke jutaan catatan dengan PII, preferensi pribadi, dan data otentikasi.

### Skenario #3

Memeriksa lalu lintas aplikasi seluler, penyerang mengetahui bahwa tidak semua lalu lintas HTTP dilakukan pada protokol aman (misalnya, TLS). Penyerang menemukan ini benar, khususnya untuk mengunduh gambar profil. Karena interaksi pengguna bersifat biner, meskipun lalu lintas API dilakukan pada protokol yang aman, penyerang menemukan pola pada ukuran respons API, yang dia gunakan untuk melacak preferensi pengguna atas konten yang dirender (misalnya, gambar profil).

## Cara Mencegah

Siklus hidup API harus mencakup:

* Proses pengerasan yang dapat diulang yang mengarah ke penyebaran yang cepat dan mudah dari lingkungan yang dikunci dengan benar.
* Tugas untuk meninjau dan memperbarui konfigurasi di seluruh tumpukan API. Tinjauan harus mencakup: file orchestrasi, komponen API, dan layanan cloud (misalnya, izin bucket S3).
* Saluran komunikasi yang aman untuk semua interaksi akses API ke aset statis (misalnya, gambar).
* Proses otomatis untuk secara kontinu menilai efektivitas konfigurasi dan pengaturan di semua lingkungan.

Selanjutnya: 

* Untuk mencegah jejak pengecualian dan informasi berharga lainnya dikirim kembali ke penyerang, jika berlaku, tentukan dan tegakkan semua skema muatan respons API termasuk respons kesalahan.
* Pastikan API hanya dapat diakses oleh kata kerja HTTP yang ditentukan. Semua kata kerja HTTP lainnya harus dinonaktifkan (misalnya, `HEAD`).
* API yang diharapkan dapat diakses dari klien berbasis browser (misalnya, front-end WebApp) harus menerapkan kebijakan Berbagi Sumber Daya Lintas Asal (CORS) yang tepat. 

## Referensi

### OWASP

* [OWASP Secure Headers Project][1]  
* [OWASP Testing Guide: Configuration Management][2]
* [OWASP Testing Guide: Testing for Error Codes][3]
* [OWASP Testing Guide: Test Cross Origin Resource Sharing][9]

### Eksternal

* [CWE-2: Kelemahan Keamanan Lingkungan][4] 
* [CWE-16: Konfigurasi][5]
* [CWE-388: Penanganan Kesalahan][6]  
* [Panduan Keamanan Server Umum][7], NIST
* [Let’s Encrypt: Otoritas Sertifikat Gratis, Otomatis, dan Terbuka][8]

[1]: https://www.owasp.org/index.php/OWASP_Secure_Headers_Project
[2]: https://www.owasp.org/index.php/Testing_for_configuration_management
[3]: https://www.owasp.org/index.php/Testing_for_Error_Code_(OTG-ERR-001)  
[4]: https://cwe.mitre.org/data/definitions/2.html
[5]: https://cwe.mitre.org/data/definitions/16.html
[6]: https://cwe.mitre.org/data/definitions/388.html
[7]: https://csrc.nist.gov/publications/detail/sp/800-123/final
[8]: https://letsencrypt.org/
[9]: https://www.owasp.org/index.php/Test_Cross_Origin_Resource_Sharing_(OTG-CLIENT-007)