# API1:2019 Otorisasi Tingkat Objek yang Rusak  

| Agen Ancaman/Vektor Serangan | Kelemahan Keamanan | Dampak |
| - | - | - |
| Khusus API: Eksploitasi **3** | Prevalensi **3** : Deteksi **2** | Teknis **3** : Spesifik Bisnis |
| Penyerang dapat memanfaatkan endpoint API yang rentan terhadap otorisasi tingkat objek yang rusak dengan memanipulasi ID objek yang dikirim dalam permintaan. Hal ini dapat menyebabkan akses tidak sah ke data sensitif. Masalah ini sangat umum dalam aplikasi berbasis API karena komponen server biasanya tidak sepenuhnya melacak status klien, dan sebaliknya, lebih bergantung pada parameter seperti ID objek, yang dikirim dari klien untuk memutuskan objek mana yang akan diakses. | Ini telah menjadi serangan paling umum dan berdampak pada API. Mekanisme otorisasi dan kontrol akses dalam aplikasi modern kompleks dan meluas. Bahkan jika aplikasi mengimplementasikan infrastruktur yang tepat untuk pemeriksaan otorisasi, pengembang mungkin lupa menggunakan pemeriksaan ini sebelum mengakses objek sensitif. Deteksi kontrol akses biasanya tidak dapat diterapkan untuk pengujian statis atau dinamis otomatis. | Akses tidak sah dapat mengakibatkan pengungkapan data ke pihak yang tidak berwenang, kehilangan data, atau manipulasi data. Akses tidak sah ke objek juga dapat mengarah ke pengambilalihan akun secara penuh. |

## Apakah API Rentan?

Otorisasi tingkat objek adalah mekanisme kontrol akses yang biasanya diimplementasikan di tingkat kode untuk memvalidasi bahwa satu pengguna hanya dapat mengakses objek yang seharusnya mereka akses. 

Setiap endpoint API yang menerima ID objek, dan melakukan jenis tindakan apa pun pada objek, harus menerapkan pemeriksaan otorisasi tingkat objek. Pemeriksaan harus memvalidasi bahwa pengguna yang login memiliki akses untuk melakukan tindakan yang diminta pada objek yang diminta. 

Kegagalan dalam mekanisme ini biasanya menyebabkan pengungkapan informasi yang tidak sah, modifikasi, atau penghancuran semua data.

## Skenario Serangan Contoh

### Skenario #1

Platform e-commerce untuk toko online (toko) menyediakan halaman daftar dengan grafik pendapatan untuk toko hosting mereka. Memeriksa permintaan browser, penyerang dapat mengidentifikasi endpoint API yang digunakan sebagai sumber data untuk grafik tersebut dan polanya `/shops/{shopName}/revenue_data.json`. Menggunakan endpoint API lainnya, penyerang dapat mendapatkan daftar semua nama toko yang di-host. Dengan skrip sederhana untuk memanipulasi nama di daftar, mengganti `{shopName}` dalam URL, penyerang mendapatkan akses ke data penjualan ribuan toko e-commerce.

### Skenario #2 

Saat memantau lalu lintas jaringan perangkat wearable, permintaan HTTP `PATCH` berikut menarik perhatian penyerang karena adanya header permintaan HTTP kustom `X-User-Id: 54796`. Mengganti nilai `X-User-Id` dengan `54795`, penyerang menerima respons HTTP yang berhasil, dan dapat memodifikasi data akun pengguna lain.

## Cara Mencegah

* Implementasikan mekanisme otorisasi yang tepat yang mengandalkan kebijakan dan hierarki pengguna.
* Gunakan mekanisme otorisasi untuk memeriksa apakah pengguna yang login memiliki akses untuk melakukan tindakan yang diminta pada catatan di setiap fungsi yang menggunakan input dari klien untuk mengakses catatan di database.  
* Lebih baik menggunakan nilai acak dan tidak terduga sebagai ID catatan. 
* Menulis tes untuk mengevaluasi mekanisme otorisasi. Jangan menerapkan perubahan rentan yang merusak tes.

## Referensi

### Eksternal

* [CWE-284: Kontrol Akses yang Tidak Tepat][1]  
* [CWE-285: Otorisasi yang Tidak Tepat][2]
* [CWE-639: Otorisasi Melewati Kunci yang Dikendalikan Pengguna][3]

[1]: https://cwe.mitre.org/data/definitions/284.html
[2]: https://cwe.mitre.org/data/definitions/285.html 
[3]: https://cwe.mitre.org/data/definitions/639.html