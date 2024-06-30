# API3:2019 Pemaparan Data yang Berlebihan

| Agen Ancaman/Vektor Serangan | Kelemahan Keamanan | Dampak |
| - | - | - |
| Khusus API: Eksploitasi **3** | Prevalensi **2** : Deteksi **2** | Teknis **2** : Spesifik Bisnis |
| Eksploitasi Pemaparan Data Berlebihan sederhana, dan biasanya dilakukan dengan menyadap lalu lintas untuk menganalisis respon API, mencari pemaparan data sensitif yang seharusnya tidak dikembalikan ke pengguna. | API mengandalkan klien untuk melakukan penyaringan data. Karena API digunakan sebagai sumber data, terkadang pengembang mencoba mengimplementasikannya secara generik tanpa memikirkan sensitivitas data yang terpapar. Alat otomatis biasanya tidak dapat mendeteksi jenis kerentanan ini karena sulit membedakan antara data yang sah dikembalikan dari API, dan data sensitif yang tidak boleh dikembalikan tanpa pemahaman mendalam tentang aplikasi. | Pemaparan Data Berlebihan umumnya mengarah pada pemaparan data sensitif. |

## Apakah API Rentan?

API mengembalikan data sensitif ke klien berdasarkan desain. Data ini biasanya disaring di sisi klien sebelum ditampilkan ke pengguna. Penyerang dengan mudah dapat menyadap lalu lintas dan melihat data sensitif.

## Skenario Serangan Contoh 

### Skenario #1

Tim seluler menggunakan endpoint `/api/articles/{articleId}/comments/{commentId}` dalam tampilan artikel untuk merender metadata komentar. Menyadap lalu lintas aplikasi seluler, seorang penyerang mengetahui bahwa data sensitif lain terkait penulis komentar juga dikembalikan. Implementasi endpoint menggunakan metode `toJSON()` generik pada model `User`, yang berisi PII, untuk men-serialisasi objek.

### Skenario #2 

Sistem pengawasan berbasis IOT memungkinkan administrator membuat pengguna dengan izin yang berbeda. Seorang admin membuat akun pengguna untuk satpam baru yang hanya boleh mengakses bangunan tertentu di situs tersebut. Setelah satpam menggunakan aplikasi selulernya, panggilan API dipicu ke: `/api/sites/111/cameras` untuk menerima data tentang kamera yang tersedia dan menampilkannya di dashboard. Respons berisi daftar dengan rincian tentang kamera dalam format berikut: `{"id":"xxx","live_access_token":"xxxx-bbbbb","building_id":"yyy"}`. Meskipun GUI klien hanya menampilkan kamera yang seharusnya satpam ini akses, respons API aktual berisi daftar lengkap semua kamera di situs.  

## Cara Mencegah

* Jangan pernah mengandalkan sisi klien untuk menyaring data sensitif.
* Tinjau respon dari API untuk memastikan hanya berisi data yang sah. 
* Insinyur backend harus selalu bertanya pada diri sendiri "siapa konsumen data ini?" sebelum memaparkan endpoint API baru.  
* Hindari menggunakan metode generik seperti `to_json()` dan `to_string()`. Sebaliknya, pilih properti spesifik yang benar-benar ingin Anda kembalikan.
* Klasifikasikan informasi sensitif dan pribadi (PII) yang disimpan dan dikelola aplikasi Anda, meninjau semua panggilan API yang mengembalikan informasi tersebut untuk melihat apakah respons ini menimbulkan masalah keamanan.
* Implementasikan mekanisme validasi respons berbasis skema sebagai lapisan keamanan tambahan. Sebagai bagian dari mekanisme ini, tentukan dan paksakan data yang dikembalikan oleh semua metode API, termasuk kesalahan.


## Referensi 

### Eksternal

* [CWE-213: Pemaparan Informasi yang Disengaja][1]

[1]: https://cwe.mitre.org/data/definitions/213.html