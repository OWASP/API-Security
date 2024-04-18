# API5:2023 Otorisasi Tingkat Fungsi yang Rusak

| Agen ancaman/Vektor serangan | Kelemahan Keamanan | Dampak |
| - | - | - |
| Khusus API: **Mudah** dieksploitasi | **Umum** Prevalensi: **Mudah** Terdeteksi | **Parah** Teknis: Spesifik Bisnis |
| Eksploitasi mengharuskan penyerang mengirim panggilan API yang sah ke endpoint API yang seharusnya tidak dapat mereka akses sebagai pengguna anonim atau pengguna biasa non-istimewa. Endpoint yang terpapar akan dengan mudah dieksploitasi. | Pemeriksaan otorisasi untuk fungsi atau sumber daya biasanya dikelola melalui konfigurasi atau level kode. Menerapkan pemeriksaan yang tepat dapat menjadi tugas yang membingungkan karena aplikasi modern dapat terdiri dari banyak jenis peran, grup, dan hierarki pengguna yang kompleks (misalnya sub-pengguna, atau pengguna dengan lebih dari satu peran). Lebih mudah menemukan kelemahan ini di API karena API lebih terstruktur, dan mengakses fungsi yang berbeda lebih dapat diprediksi. | Kelemahan seperti itu memungkinkan penyerang mengakses fungsionalitas yang tidak sah. Fungsi administratif menjadi target utama untuk jenis serangan ini dan dapat menyebabkan pengungkapan data, kehilangan data, atau kerusakan data. Pada akhirnya, dapat menyebabkan gangguan layanan. |

## Apakah API Rentan?

Cara terbaik untuk menemukan masalah otorisasi tingkat fungsi yang rusak adalah dengan melakukan analisis mendalam tentang mekanisme otorisasi dengan tetap mempertimbangkan hierarki pengguna, peran atau grup yang berbeda dalam aplikasi, dan mengajukan pertanyaan berikut:

* Apakah pengguna reguler dapat mengakses endpoint administratif?
* Apakah pengguna dapat melakukan tindakan sensitif (misalnya pembuatan, modifikasi, atau penghapusan) yang seharusnya tidak bisa diakses dengan hanya mengubah metode HTTP (misalnya dari `GET` ke `DELETE`)?  
* Apakah pengguna dari grup X dapat mengakses fungsi yang seharusnya hanya dapat diakses pengguna dari grup Y, dengan hanya menebak URL endpoint dan parameternya (misalnya `/api/v1/users/export_all`)?

Jangan mengasumsikan bahwa sebuah endpoint API adalah endpoint reguler atau administratif hanya berdasarkan jalur URL-nya. 

Meskipun pengembang mungkin memilih untuk mengekspos sebagian besar endpoint administratif di path relatif tertentu, seperti `/api/admins`, sangat umum menemukan endpoint administratif ini di path relatif lain bersama dengan endpoint reguler, seperti `/api/users`.

## Skenario Serangan Contoh  

### Skenario #1

Selama proses pendaftaran untuk aplikasi yang hanya mengizinkan pengguna yang diundang untuk bergabung, aplikasi seluler memicu panggilan API ke `GET /api/invites/{invite_guid}`. Respons berisi sebuah JSON dengan detail tentang undangan, termasuk peran pengguna dan email pengguna.

Seorang penyerang menduplikasi permintaan dan memanipulasi metode HTTP dan endpoint menjadi `POST /api/invites/new`. Endpoint ini hanya boleh diakses oleh administrator menggunakan konsol admin. Endpoint tidak menerapkan pemeriksaan otorisasi tingkat fungsi. 

Penyerang mengeksploitasi masalah tersebut dan mengirim undangan baru dengan hak istimewa admin:

```
POST /api/invites/new

{
  "email": "attacker@somehost.com",
  "role":"admin" 
}
```

Selanjutnya, penyerang menggunakan undangan yang dibuat secara curang tersebut untuk membuat akun admin bagi dirinya sendiri dan mendapatkan akses penuh ke sistem.

### Skenario #2

Sebuah API berisi endpoint yang seharusnya hanya terungkap ke administrator - `GET /api/admin/v1/users/all`. Endpoint ini mengembalikan detail semua pengguna aplikasi dan tidak menerapkan pemeriksaan otorisasi tingkat fungsi. Seorang penyerang yang mempelajari struktur API melakukan tebakan cerdas dan berhasil mengakses endpoint ini, yang mengekspos detail sensitif para pengguna aplikasi.

## Cara Mencegah 

Aplikasi Anda harus memiliki modul otorisasi yang konsisten dan mudah dianalisis yang dipanggil dari semua fungsi bisnis Anda. Seringkali, perlindungan seperti itu disediakan oleh satu atau lebih komponen eksternal untuk kode aplikasi.

* Mekanisme penegakan harus menolak semua akses secara default, dibutuhkan hak akses yang eksplisit ke peran tertentu untuk mengakses setiap fungsi.
* Tinjau endpoint API Anda terhadap kelemahan otorisasi tingkat fungsi, dengan tetap memperhatikan logika bisnis aplikasi dan hierarki grup.  
* Pastikan semua pengendali administratif Anda mewarisi kendali abstrak administratif yang menerapkan pemeriksaan otorisasi berdasarkan grup/peran pengguna.
* Pastikan fungsi administratif di dalam pengendali reguler menerapkan pemeriksaan otorisasi berdasarkan grup dan peran pengguna.

## Referensi

### OWASP

* [Pemaksaan Penelusuran][1] 
* "A7: Hilangnya Kendali Akses Tingkat Fungsi", [OWASP Top 10 2013][2]
* [Kontrol Akses][3]  

### Eksternal

* [CWE-285: Otorisasi yang Tidak Tepat][4]

[1]: https://owasp.org/www-community/attacks/Forced_browsing
[2]: https://github.com/OWASP/Top10/raw/master/2013/OWASP%20Top%2010%20-%202013.pdf
[3]: https://owasp.org/www-community/Access_Control 
[4]: https://cwe.mitre.org/data/definitions/285.html
