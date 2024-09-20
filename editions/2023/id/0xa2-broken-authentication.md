# API2:2023 Autentikasi yang Rusak  

| Agen ancaman/Vektor serangan | Kelemahan Keamanan | Dampak |
| - | - | - |
| Khusus API: **Mudah** dieksploitasi | **Umum** Prevalensi: **Mudah** Terdeteksi | **Parah** Teknis: Spesifik Bisnis |
| Mekanisme autentikasi adalah target yang mudah bagi penyerang karena terpapar ke semua orang. Meskipun keterampilan teknis yang lebih tinggi mungkin dibutuhkan untuk mengeksploitasi beberapa masalah autentikasi, alat eksploitasi umumnya tersedia. | Kesalahpahaman insinyur perangkat lunak dan keamanan mengenai batasan autentikasi dan kerumitan implementasi bawaan menjadikan masalah autentikasi hal yang lazim. Metodologi untuk mendeteksi autentikasi yang rusak tersedia dan mudah dibuat. | Penyerang dapat memperoleh kendali penuh atas akun pengguna lain dalam sistem, membaca data pribadi mereka, dan melakukan tindakan sensitif atas nama mereka. Sistem kemungkinan besar tidak dapat membedakan tindakan penyerang dari tindakan pengguna yang sah. |

## Apakah API Rentan? 

Endpoint dan alur autentikasi adalah aset yang perlu dilindungi. Selain itu, "Lupa kata sandi / reset kata sandi" harus diperlakukan sama dengan mekanisme autentikasi.

Sebuah API rentan bila:

* Mengizinkan credential stuffing ketika penyerang menggunakan brute force dengan daftar nama pengguna dan kata sandi yang valid. 
* Mengizinkan penyerang melakukan serangan brute force pada akun pengguna yang sama, tanpa menyajikan mekanisme captcha/penguncian akun.
* Mengizinkan kata sandi yang lemah. 
* Mengirim detail autentikasi sensitif, seperti token auth dan kata sandi di URL.
* Memungkinkan pengguna merubah alamat email mereka, kata sandi saat ini, atau melakukan operasi sensitif lainnya tanpa meminta konfirmasi kata sandi.
* Tidak memvalidasi keaslian token.  
* Menerima token JWT yang tidak ditandatangani/lemah ditandatangani (`{"alg":"none"}`)
* Tidak memvalidasi tanggal kadaluwarsa JWT. 
* Menggunakan kata sandi teks biasa, tidak dienkripsi, atau menggunakan hash yang lemah.
* Menggunakan kunci enkripsi yang lemah.

Selain itu, mikroservis itu rentan jika:

* Mikroservis lain dapat mengaksesnya tanpa otentikasi
* Menggunakan token lemah atau dapat diprediksi untuk memastikan otentikasi

## Skenario Serangan Contoh

## Skenario #1

Untuk melakukan autentikasi pengguna, klien harus mengirimkan permintaan API seperti di bawah ini dengan kredensial pengguna:

```
POST /graphql
{
  "query":"mutation {
    login (username:\"<username>\",password:\"<password>\") {
      token
    }
   }"
}
```

Jika kredensial valid, lalu token auth akan dikembalikan yang harus diberikan dalam permintaan berikutnya untuk mengidentifikasi pengguna. Upaya login dibatasi dengan pembatasan laju yang ketat: hanya tiga permintaan yang diizinkan per menit. 

Untuk melakukan brute force login dengan akun korban, aktor jahat memanfaatkan query batching GraphQL untuk mengatasi pembatasan tingkat permintaan, mempercepat serangan:

```
POST /graphql
[
  {"query":"mutation{login(username:\"victim\",password:\"password\"){token}}"},
  {"query":"mutation{login(username:\"victim\",password:\"123456\"){token}}"},
  {"query":"mutation{login(username:\"victim\",password:\"qwerty\"){token}}"},
  ...
  {"query":"mutation{login(username:\"victim\",password:\"123\"){token}}"}, 
]
```

## Skenario #2

Untuk memperbarui alamat email yang terkait dengan akun pengguna, klien harus mengirimkan permintaan API seperti berikut ini:

```
PUT /account
Authorization: Bearer <token>

{ "email": "<new_email_address>" }
```

Karena API tidak mengharuskan pengguna untuk mengkonfirmasi identitas mereka dengan memberikan kata sandi saat ini, aktor jahat yang mampu menempatkan diri dalam posisi untuk mencuri token auth mungkin dapat mengambil alih akun korban dengan memulai alur kerja reset kata sandi setelah memperbarui alamat email akun korban.

## Cara Mencegah

* Pastikan Anda mengetahui semua alur kemungkinan untuk mengotentikasi API (mobile/web/tautan langsung yang mengimplementasikan otentikasi satu klik/dll.). Tanyakan pada insinyur Anda alur apa yang Anda lewatkan.
* Bacalah tentang mekanisme autentikasi Anda. Pastikan Anda memahami apa dan bagaimana mereka digunakan. OAuth bukan otentikasi, dan demikian pula kunci API. 
* Jangan menciptakan ulang dalam otentikasi, pembuatan token, atau penyimpanan kata sandi. Gunakan standar.
* Endpoint pemulihan kredensial/lupa kata sandi harus diperlakukan seperti endpoint login dalam hal brute force, pembatasan tingkat, dan perlindungan penguncian.
* Haruskan otentikasi ulang untuk operasi sensitif (misalnya mengubah alamat email pemilik akun/nomor telepon 2FA). 
* Gunakan [Cheat Sheet Autentikasi OWASP][1].  
* Jika memungkinkan, terapkan otentikasi multifaktor.
* Terapkan mekanisme anti-brute force untuk memitigasi credential stuffing, serangan kamus, dan serangan brute force pada endpoint otentikasi Anda. Mekanisme ini harus lebih ketat dari mekanisme pembatasan tingkat biasa pada API Anda.  
* Implementasikan mekanisme penguncian akun/captcha untuk mencegah serangan brute force terhadap pengguna tertentu. Terapkan pemeriksaan kata sandi lemah.  
* Kunci API tidak boleh digunakan untuk otentikasi pengguna. Mereka hanya boleh digunakan untuk otentikasi [klien API][2].

## Referensi 

### OWASP

* [Authentication Cheat Sheet][1]
* [Key Management Cheat Sheet][4]
* [Credential Stuffing][5]

### Eksternal

* [CWE-204: Observable Response Discrepancy][6]
* [CWE-307: Improper Restriction of Excessive Authentication Attempts][7]

[1]: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
[2]: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/04-Authentication_Testing/03-Testing_for_Weak_Lock_Out_Mechanism(OTG-AUTHN-003)
[3]: https://cloud.google.com/endpoints/docs/openapi/when-why-api-key
[4]: https://cheatsheetseries.owasp.org/cheatsheets/Key_Management_Cheat_Sheet.html
[5]: https://owasp.org/www-community/attacks/Credential_stuffing
[6]: https://cwe.mitre.org/data/definitions/204.html
[7]: https://cwe.mitre.org/data/definitions/307.html

