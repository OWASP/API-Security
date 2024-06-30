# API4:2023 Konsumsi Sumber Daya yang Tidak Dibatasi

| Agen ancaman/Vektor serangan | Kelemahan Keamanan | Dampak |
| - | - | - |
| Khusus API: **Rata-rata** dieksploitasi | **Luas** Prevalensi: **Mudah** Terdeteksi | **Parah** Teknis: Spesifik Bisnis |
| Eksploitasi membutuhkan permintaan API sederhana. Beberapa permintaan serentak dapat dilakukan dari satu komputer lokal atau dengan menggunakan sumber daya komputasi cloud. Sebagian besar alat otomatis yang tersedia dirancang untuk menyebabkan DoS melalui beban lalu lintas tinggi, yang berdampak pada tingkat layanan API. | Umum ditemukan API yang tidak membatasi interaksi atau konsumsi sumber daya klien. Permintaan API yang dibuat, seperti yang mencakup parameter yang mengendalikan jumlah sumber daya yang akan dikembalikan dan melakukan analisis status/waktu/panjang respons seharusnya memungkinkan identifikasi masalah. Hal yang sama berlaku untuk operasi batch. Meskipun agen ancaman tidak memiliki visibilitas atas dampak biaya, ini dapat disimpulkan berdasarkan model bisnis/harga penyedia layanan (misalnya penyedia cloud). | Eksploitasi dapat menyebabkan DoS karena kekurangan sumber daya, tetapi juga dapat menyebabkan peningkatan biaya operasional seperti yang terkait dengan infrastruktur karena permintaan CPU yang lebih tinggi, peningkatan kebutuhan penyimpanan cloud, dll. |

## Apakah API Rentan?

Memenuhi permintaan API memerlukan sumber daya seperti bandwidth jaringan, CPU, memori, dan penyimpanan. Terkadang sumber daya yang diperlukan disediakan oleh penyedia layanan melalui integrasi API, dan dibayar berdasarkan permintaan, seperti mengirim email/SMS/panggilan telepon, validasi biometrik, dll.  

API rentan jika setidaknya salah satu batasan berikut hilang atau diatur dengan tidak tepat (misalnya terlalu rendah/tinggi):

* Batas waktu eksekusi
* Memori maksimum yang dapat dialokasikan  
* Jumlah maksimum deskriptor file
* Jumlah proses maksimum
* Ukuran file unggah maksimum
* Jumlah operasi untuk dilakukan dalam satu permintaan klien API (misalnya penyuntingan batch GraphQL)
* Jumlah catatan per halaman untuk dikembalikan dalam satu permintaan-respons
* Batas biaya untuk layanan pihak ketiga 

## Skenario Serangan Contoh

### Skenario #1

Sebuah jejaring sosial mengimplementasikan alur "lupa kata sandi" menggunakan verifikasi SMS, hal ini memungkinkan pengguna menerima token sekali pakai melalui SMS untuk mereset kata sandi mereka.

Setelah pengguna mengklik "lupa kata sandi" sebuah panggilan API dikirim dari browser pengguna ke API back-end:

```
POST /initiate_forgot_password

{
  "step": 1,
  "user_number": "6501113434" 
}
```

Kemudian, di balik layar, panggilan API dikirim dari back-end ke API pihak ke-3 yang mengurus pengiriman SMS:

```
POST /sms/send_reset_pass_code

Host: willyo.net

{
  "phone_number": "6501113434"
}
```

Penyedia pihak ketiga, Willyo, membebankan $0,05 untuk setiap panggilan jenis ini.

Seorang penyerang menulis skrip yang mengirim panggilan API pertama puluhan ribu kali. Back-end mengikuti dan meminta Willyo untuk mengirim puluhan ribu pesan teks, yang menyebabkan perusahaan kehilangan ribuan dolar dalam hitungan menit.

### Skenario #2

Sebuah Endpoint API GraphQL memungkinkan pengguna mengunggah foto profil.

```
POST /graphql

{
  "query": "mutation {
    uploadPic(name: \"pic1\", base64_pic: \"R0FOIEFOR0xJVA...\") {
      url
    }
  }"
}
```

Begitu proses unggah selesai, API menghasilkan beberapa thumbnail dengan ukuran berbeda berdasarkan gambar yang diunggah. Operasi grafis ini mengambil banyak memori server.

API mengimplementasikan perlindungan pembatasan tradisional - pengguna tidak dapat mengakses endpoint GraphQL terlalu banyak dalam jangka waktu singkat. API juga memeriksa ukuran gambar yang diunggah sebelum menghasilkan thumbnail untuk menghindari memproses gambar yang terlalu besar. 

Seorang penyerang dapat dengan mudah mengatasi mekanisme tersebut, dengan memanfaatkan sifat fleksibel GraphQL:

```
POST /graphql

[
  {"query": "mutation {uploadPic(name: \"pic1\", base64_pic: \"R0FOIEFOR0xJVA...\") {url}}"},
  {"query": "mutation {uploadPic(name: \"pic2\", base64_pic: \"R0FOIEFOR0xJVA...\") {url}}"},
  ...
  {"query": "mutation {uploadPic(name: \"pic999\", base64_pic: \"R0FO IEFOR0xJVA...\") {url}}"},  
]
```

Karena API tidak membatasi berapa kali operasi `uploadPic` dapat dicoba, panggilan akan menyebabkan habisnya memori server dan Denial of Service.

### Skenario #3

Sebuah penyedia layanan memungkinkan klien mengunduh file berukuran sebesar apa pun menggunakan API-nya. File-file ini disimpan di penyimpanan objek cloud dan jarang berubah. Penyedia layanan mengandalkan layanan cache agar memiliki tingkat layanan yang lebih baik dan menjaga konsumsi bandwidth tetap rendah. Layanan cache hanya menyimpan file hingga 15GB.

Ketika salah satu file diperbarui, ukurannya meningkat menjadi 18GB. Semua klien layanan segera mulai menarik versi baru. Karena tidak ada peringatan biaya konsumsi, atau pengeluaran maksimum yang diizinkan untuk layanan cloud, tagihan bulanan berikutnya meningkat dari rata-rata US$13 menjadi US$8 ribu.

## Cara Mencegah

* Gunakan solusi yang memudahkan pembatasan [memori][1], [CPU][2], [jumlah restart][3], [deskriptor file, dan proses][4] seperti Kontainer / Serverless code (misalnya Lambda).
* Tentukan dan pastikan ukuran data maksimum pada semua parameter dan payload masukan, seperti panjang maksimum string, jumlah elemen maksimum array, dan ukuran file unggah maksimum (terlepas apakah disimpan secara lokal atau di penyimpanan cloud). 
* Terapkan batas seberapa sering klien dapat berinteraksi dengan API dalam rentang waktu tertentu (pembatasan laju).
* Pembatasan laju harus diatur berdasarkan kebutuhan bisnis. Beberapa Endpoint API mungkin memerlukan kebijakan yang lebih ketat.  
* Batasi/atur seberapa banyak atau seberapa sering satu klien/pengguna API dapat mengeksekusi operasi tunggal (misalnya memvalidasi OTP, atau meminta pemulihan kata sandi tanpa mengunjungi URL sekali pakai).
* Tambahkan validasi sisi server yang tepat untuk parameter string kueri dan body permintaan, khususnya yang mengendalikan jumlah catatan yang akan dikembalikan dalam respons.
* Konfigurasikan batas pengeluaran untuk semua penyedia layanan/integrasi API. Jika tidak memungkinkan untuk membatasi pengeluaran, sebaiknya konfigurasi peringatan tagihan.

## Referensi

### OWASP

* ["Ketersediaan" - Cheat Sheet Keamanan Layanan Web][5]  
* ["Pencegahan DoS" - Cheat Sheet GraphQL][6]
* ["Meredam Serangan Batching" - Cheat Sheet GraphQL][7]  

### Eksternal

* [CWE-770: Alokasi Sumber Daya Tanpa Batasan atau Pengaturan][8] 
* [CWE-400: Konsumsi Sumber Daya yang Tidak Terkendali][9]
* [CWE-799: Kontrol Interaksi Frekuensi yang Tidak Tepat][10]  
* "Pembatasan Laju (Pengaturan)" - [Strategi Keamanan untuk Sistem Aplikasi Berbasis Mikroservis][11], NIST

[1]: https://docs.docker.com/config/containers/resource_constraints/#memory
[2]: https://docs.docker.com/config/containers/resource_constraints/#cpu  
[3]: https://docs.docker.com/engine/reference/commandline/run/#restart
[4]: https://docs.docker.com/engine/reference/commandline/run/#ulimit
[5]: https://cheatsheetseries.owasp.org/cheatsheets/Web_Service_Security_Cheat_Sheet.html#availability
[6]: https://cheatsheetseries.owasp.org/cheatsheets/GraphQL_Cheat_Sheet.html#dos-prevention
[7]: https://cheatsheetseries.owasp.org/cheatsheets/GraphQL_Cheat_Sheet.html#mitigating-batching-attacks
[8]: https://cwe.mitre.org/data/definitions/770.html 
[9]: https://cwe.mitre.org/data/definitions/400.html
[10]: https://cwe.mitre.org/data/definitions/799.html
[11]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-204.pdf

