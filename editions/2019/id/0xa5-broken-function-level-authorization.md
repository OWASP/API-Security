# API5:2019 Otorisasi Tingkat Fungsi yang Rusak

| Agen Ancaman/Vektor Serangan | Kelemahan Keamanan | Dampak |
| - | - | - |
| Khusus API: Eksploitasi **3** | Prevalensi **2** : Deteksi **1** | Teknis **2** : Spesifik Bisnis |
| Eksploitasi membutuhkan penyerang untuk mengirim panggilan API yang sah ke endpoint API yang seharusnya tidak mereka akses. Endpoint ini mungkin terbuka untuk pengguna anonim atau pengguna reguler non-istimewa. Lebih mudah menemukan celah ini di API karena API lebih terstruktur, dan cara mengakses fungsi tertentu lebih dapat diprediksi (misalnya, mengganti metode HTTP dari GET ke PUT, atau mengubah string “users” di URL menjadi "admins"). | Pemeriksaan otorisasi untuk fungsi atau sumber daya biasanya dikelola melalui konfigurasi, dan terkadang di tingkat kode. Mengimplementasikan pemeriksaan yang tepat dapat menjadi tugas yang membingungkan, karena aplikasi modern dapat berisi banyak jenis peran atau kelompok dan hirarki pengguna yang kompleks (misalnya, sub-pengguna, pengguna dengan lebih dari satu peran). | Celah seperti itu memungkinkan penyerang mengakses fungsionalitas yang tidak sah. Fungsi administratif menjadi target utama untuk jenis serangan ini. |

## Apakah API Rentan?

Cara terbaik untuk menemukan masalah otorisasi tingkat fungsi yang rusak adalah dengan melakukan analisis mendalam terhadap mekanisme otorisasi, dengan mempertimbangkan hirarki pengguna, peran atau kelompok yang berbeda dalam aplikasi, dan mengajukan pertanyaan berikut:

* Apakah pengguna reguler dapat mengakses endpoint administratif?  
* Apakah pengguna dapat melakukan tindakan sensitif (misalnya, pembuatan, modifikasi, atau penghapusan) yang seharusnya tidak mereka akses dengan hanya mengubah metode HTTP (misalnya, dari `GET` ke `DELETE`)?
* Apakah pengguna dari kelompok X dapat mengakses fungsi yang seharusnya hanya diekspos ke pengguna dari kelompok Y, dengan hanya menebak URL dan parameter endpoint (misalnya, `/api/v1/users/export_all`)?

Jangan menganggap endpoint API adalah reguler atau administratif hanya berdasarkan jalur URL. 

Meskipun pengembang mungkin memilih untuk mengekspos sebagian besar endpoint administratif di bawah jalur relatif tertentu, seperti `api/admins`, sangat umum menemukan endpoint administratif ini di bawah jalur relatif lain bersama dengan endpoint reguler, seperti `api/users`.

## Skenario Serangan Contoh

### Skenario #1

Selama proses pendaftaran ke aplikasi yang hanya mengizinkan pengguna diundang untuk bergabung, aplikasi seluler memicu panggilan API ke `GET /api/invites/{invite_guid}`. Respons berisi JSON dengan rincian undangan, termasuk peran pengguna dan email pengguna.

Seorang penyerang menduplikasi permintaan dan memanipulasi metode HTTP dan endpoint menjadi `POST /api/invites/new`. Endpoint ini hanya boleh diakses oleh administrator menggunakan konsol admin, yang tidak menerapkan pemeriksaan otorisasi tingkat fungsi. 

Penyerang mengeksploitasi masalah ini dan mengirim undangan ke dirinya sendiri untuk membuat akun admin:

```
POST /api/invites/new

{“email”:”hugo@malicious.com”,”role”:”admin”}
```

### Skenario #2

Sebuah API berisi endpoint yang seharusnya hanya diekspos ke administrator - `GET /api/admin/v1/users/all`. Endpoint ini mengembalikan rincian semua pengguna aplikasi dan tidak menerapkan pemeriksaan otorisasi tingkat fungsi. Seorang penyerang yang mempelajari struktur API membuat tebakan terdidik dan berhasil mengakses endpoint ini, yang mengekspos rincian sensitif pengguna aplikasi.

## Cara Mencegah

Aplikasi Anda harus memiliki modul otorisasi yang konsisten dan mudah dianalisis yang dipanggil dari semua fungsi bisnis Anda. Seringkali, perlindungan tersebut disediakan oleh satu atau lebih komponen eksternal untuk kode aplikasi.

* Mekanisme penegakan harus menolak semua akses secara default, membutuhkan izin eksplisit ke peran tertentu untuk mengakses setiap fungsi.
* Tinjau endpoint API Anda terhadap celah otorisasi tingkat fungsi, dengan mempertimbangkan logika bisnis aplikasi dan hirarki kelompok.  
* Pastikan semua pengendali administrasi Anda mewarisi pengendali abstrak administratif yang menerapkan pemeriksaan otorisasi berdasarkan grup/peran pengguna.
* Pastikan fungsi administratif di dalam pengendali reguler menerapkan pemeriksaan otorisasi berdasarkan grup dan peran pengguna.

## Referensi

### OWASP

* [Artikel OWASP tentang Forced Browsing][1]  
* [OWASP Top 10 2013-A7-Missing Function Level Access Control][2]
* [OWASP Development Guide: Bab tentang Otorisasi][3]

### Eksternal

* [CWE-285: Otorisasi yang Tidak Tepat][4]

[1]: https://www.owasp.org/index.php/Forced_browsing
[2]: https://www.owasp.org/index.php/Top_10_2013-A7-Missing_Function_Level_Access_Control
[3]: https://www.owasp.org/index.php/Category:Access_Control
[4]: https://cwe.mitre.org/data/definitions/285.html