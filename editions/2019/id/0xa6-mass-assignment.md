# API6:2019 - Mass Assignment

| Agen Ancaman/Vektor Serangan | Kelemahan Keamanan | Dampak |
| - | - | - |
| Khusus API: Eksploitasi **2** | Prevalensi **2** : Deteksi **2** | Teknis **2** : Spesifik Bisnis |
| Eksploitasi biasanya memerlukan pemahaman tentang logika bisnis, hubungan objek, dan struktur API. Eksploitasi penugasan massal lebih mudah dalam API, karena secara desain mereka mengekspos implementasi aplikasi yang mendasari beserta nama properti. | Kerangka kerja modern mendorong pengembang untuk menggunakan fungsi yang secara otomatis mengikat masukan dari klien ke dalam variabel kode dan objek internal. Penyerang dapat menggunakan metodologi ini untuk memperbarui atau menimpa properti objek sensitif yang sebenarnya tidak dimaksudkan untuk diekspos oleh pengembang. | Eksploitasi dapat menyebabkan eskalasi hak istimewa, perusakan data, menghindari mekanisme keamanan, dan lainnya. |

## Apakah API Rentan?

Objek dalam aplikasi modern mungkin berisi banyak properti. Beberapa properti ini harus diperbarui langsung oleh klien (misalnya, `user.first_name` atau `user.address`) dan beberapa tidak boleh (misalnya, flag `user.is_vip`). 

Titik akhir API rentan jika secara otomatis mengubah parameter klien menjadi properti objek internal, tanpa mempertimbangkan sensitivitas dan tingkat paparan properti tersebut. Hal ini bisa memungkinkan penyerang untuk memperbarui properti objek yang seharusnya tidak mereka akses.

Contoh properti sensitif:

* **Properti terkait izin**: `user.is_admin`, `user.is_vip` hanya boleh diatur oleh admin.
* **Properti tergantung proses**: `user.cash` hanya boleh diatur secara internal setelah verifikasi pembayaran.  
* **Properti internal**: `article.created_time` hanya boleh diatur secara internal oleh aplikasi.

## Skenario Serangan Contoh

### Skenario #1

Aplikasi berbagi tumpangan memberi pengguna opsi untuk mengedit informasi dasar untuk profil mereka. Selama proses ini, panggilan API dikirim ke `PUT /api/v1/users/me` dengan objek JSON yang sah:

```json
{"user_name":"inons","age":24} 
```

Permintaan `GET /api/v1/users/me` menyertakan properti credit_balance tambahan: 

```json 
{"user_name":"inons","age":24,"credit_balance":10}
```

Penyerang memutar ulang permintaan pertama dengan payload berikut:

```json
{"user_name":"attacker","age":60,"credit_balance":99999}
```

Karena endpoint rentan terhadap penugasan massal, penyerang menerima kredit tanpa membayar.

### Skenario #2

Portal berbagi video memungkinkan pengguna mengunggah konten dan mengunduh konten dalam format yang berbeda. Seorang penyerang yang menjelajahi API menemukan bahwa endpoint `GET /api/v1/videos/{video_id}/meta_data` mengembalikan objek JSON dengan properti video. Salah satu propertinya adalah `"mp4_conversion_params":"-v codec h264"` yang menunjukkan bahwa aplikasi menggunakan perintah shell untuk mengubah video.

Penyerang juga menemukan endpoint `POST /api/v1/videos/new` rentan terhadap penugasan massal dan memungkinkan klien mengatur properti apa pun dari objek video. Penyerang menetapkan nilai berbahaya sebagai berikut: `"mp4_conversion_params":"-v codec h264 && format C:/"`. Nilai ini akan menyebabkan injeksi perintah shell setelah penyerang mengunduh video sebagai MP4.

## Cara Mencegah

* Jika memungkinkan, hindari menggunakan fungsi yang secara otomatis mengikat masukan klien ke dalam variabel kode atau objek internal.  
* Daftar putih hanya properti yang seharusnya diperbarui oleh klien.
* Gunakan fitur bawaan untuk daftar hitam properti yang tidak boleh diakses oleh klien.
* Jika berlaku, tentukan dan tegakkan secara eksplisit skema untuk muatan data masukan.

## Referensi

### Eksternal

* [CWE-915: Pengontrolan yang Tidak Tepat dari Modifikasi Atribut Objek yang Ditentukan Secara Dinamis][1]

[1]: https://cwe.mitre.org/data/definitions/915.html