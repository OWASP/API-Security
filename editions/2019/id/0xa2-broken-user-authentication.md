# API2:2019 Otentikasi Pengguna yang Rusak

| Agen Ancaman/Vektor Serangan | Kelemahan Keamanan | Dampak |
| - | - | - |
| Khusus API: Eksploitasi **3** | Prevalensi **2** : Deteksi **2** | Teknis **3** : Spesifik Bisnis |
| Otentikasi dalam API adalah mekanisme yang kompleks dan membingungkan. Insinyur perangkat lunak dan keamanan mungkin memiliki kesalahpahaman tentang batasan otentikasi dan cara mengimplementasikannya dengan benar. Selain itu, mekanisme otentikasi adalah target yang mudah bagi penyerang, karena terbuka untuk semua orang. Dua poin ini membuat komponen otentikasi berpotensi rentan terhadap banyak eksploitasi. | Ada dua sub-masalah: 1. Kurangnya mekanisme perlindungan: endpoint API yang bertanggung jawab untuk otentikasi harus diperlakukan berbeda dari endpoint reguler dan menerapkan lapisan perlindungan tambahan 2. Kesalahan implementasi mekanisme: Mekanisme digunakan/diimplementasikan tanpa mempertimbangkan vektor serangan, atau itu kasus penggunaan yang salah (misalnya, mekanisme otentikasi yang dirancang untuk klien IoT mungkin bukan pilihan yang tepat untuk aplikasi web). | Penyerang dapat mengambil alih akun pengguna lain dalam sistem, membaca data pribadi mereka, dan melakukan tindakan sensitif atas nama mereka, seperti transaksi uang dan mengirim pesan pribadi. |

## Apakah API Rentan? 

Titik akhir dan alur otentikasi adalah aset yang perlu dilindungi. “Lupa kata sandi / reset kata sandi” harus diperlakukan sama seperti mekanisme otentikasi. 

API rentan jika:
* Mengizinkan [credential stuffing][1] di mana penyerang memiliki daftar nama pengguna dan kata sandi yang valid. 
* Mengizinkan penyerang melakukan serangan brute force pada akun pengguna yang sama, tanpa menyajikan mekanisme captcha/penguncian akun.
* Mengizinkan kata sandi yang lemah. 
* Mengirim detail otentikasi sensitif, seperti token otentikasi dan kata sandi di URL.
* Tidak memvalidasi keaslian token.
* Menerima token JWT yang tidak ditandatangani/lemah ditandatangani (`"alg": "none"`) / tidak memvalidasi tanggal kedaluwarsa mereka.
* Menggunakan kata sandi teks polos, tidak dienkripsi, atau di-hash lemah. 
* Menggunakan kunci enkripsi yang lemah.

## Skenario Serangan Contoh 

## Skenario #1

[Credential stuffing][1] (menggunakan [daftar nama pengguna/kata sandi yang diketahui][2]), adalah serangan yang umum. Jika aplikasi tidak menerapkan ancaman otomatis atau perlindungan stuffing kredensial, aplikasi dapat digunakan sebagai oracle kata sandi (penguji) untuk menentukan apakah kredensial valid.

## Skenario #2

Seorang penyerang memulai alur kerja pemulihan kata sandi dengan menerbitkan permintaan POST ke `/api/system/verification-codes` dan dengan menyediakan nama pengguna dalam body permintaan. Selanjutnya token SMS dengan 6 digit dikirim ke telepon korban. Karena API tidak menerapkan kebijakan pembatasan laju, penyerang dapat menguji semua kombinasi yang mungkin menggunakan skrip multi-thread, terhadap endpoint `/api/system/verification-codes/{smsToken}` untuk menemukan token yang benar dalam beberapa menit.

## Cara Mencegah

* Pastikan Anda mengetahui semua kemungkinan alur untuk mengotentikasi ke API (mobile/web/tautan dalam yang mengimplementasikan otentikasi satu klik/dll.)
* Tanyakan pada insinyur Anda alur apa yang Anda lewatkan.
* Baca tentang mekanisme otentikasi Anda. Pastikan Anda memahami apa dan bagaimana mereka digunakan. OAuth bukan otentikasi, dan begitu juga kunci API.
* Jangan menemukan kembali roda dalam otentikasi, generasi token, penyimpanan kata sandi. Gunakan standar.
* Endpoint pemulihan kredensial/lupa kata sandi harus diperlakukan seperti titik akhir login dalam hal brute force, pembatasan laju, dan perlindungan penguncian.
* Gunakan [OWASP Authentication Cheatsheet][3]. 
* Jika memungkinkan, terapkan otentikasi multifaktor.
* Terapkan mekanisme anti-brute force untuk memitigasi stuffing kredensial, serangan kamus, dan serangan brute force pada titik akhir otentikasi Anda. Mekanisme ini harus lebih ketat daripada mekanisme pembatasan laju normal pada API Anda.
* Terapkan [penguncian akun][4] / mekanisme captcha untuk mencegah brute force terhadap pengguna tertentu. Terapkan pemeriksaan kata sandi lemah.
* Kunci API seharusnya tidak digunakan untuk otentikasi pengguna, tetapi untuk [otentikasi aplikasi/proyek klien][5]. 

## Referensi

### OWASP

* [OWASP Key Management Cheat Sheet][6]  
* [OWASP Authentication Cheatsheet][3]
* [Credential Stuffing][1]

### Eksternal 

* [CWE-798: Penggunaan Kredensial Hard-coded][7]

[1]: https://www.owasp.org/index.php/Credential_stuffing
[2]: https://github.com/danielmiessler/SecLists
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
[4]: https://www.owasp.org/index.php/Testing_for_Weak_lock_out_mechanism_(OTG-AUTHN-003) 
[5]: https://cloud.google.com/endpoints/docs/openapi/when-why-api-key
[6]: https://www.owasp.org/index.php/Key_Management_Cheat_Sheet
[7]: https://cwe.mitre.org/data/definitions/798.html