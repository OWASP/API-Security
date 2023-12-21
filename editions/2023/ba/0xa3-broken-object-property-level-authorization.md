# API3:2023 Otorisasi Tingkat Properti Objek yang Rusak

| Agen ancaman/Vektor serangan | Kelemahan Keamanan | Dampak |
| - | - | - |
| Khusus API: **Mudah** dieksploitasi | **Umum** Prevalensi: **Mudah** Terdeteksi | **Sedang** Teknis: Spesifik Bisnis |
| API cenderung mengekspos endpoint yang mengembalikan semua properti objek. Ini khususnya berlaku untuk API REST. Untuk protokol lain seperti GraphQL, mungkin memerlukan permintaan yang dibuat untuk menentukan properti mana yang harus dikembalikan. Mengidentifikasi properti tambahan ini yang dapat dimanipulasi memerlukan lebih banyak upaya, tetapi ada beberapa alat otomatis yang tersedia untuk membantu tugas ini. | Memeriksa respons API sudah cukup untuk mengidentifikasi informasi sensitif dalam representasi objek yang dikembalikan. Fuzzing biasanya digunakan untuk mengidentifikasi properti tambahan (tersembunyi). Apakah mereka dapat diubah adalah masalah pembuatan permintaan API dan menganalisis respons. Analisis efek samping mungkin diperlukan jika properti target tidak dikembalikan dalam respons API. | Akses tanpa otorisasi ke properti objek privat/sensitif dapat mengakibatkan pengungkapan data, kehilangan data, atau kerusakan data. Dalam keadaan tertentu, akses tanpa otorisasi ke properti objek dapat mengarah ke eskalasi hak istimewa atau pengambilalihan akun parsial/total. | 

## Apakah API Rentan?

Saat mengizinkan pengguna mengakses objek menggunakan endpoint API, penting untuk memvalidasi bahwa pengguna memiliki akses ke properti objek tertentu yang mereka coba akses.

Sebuah endpoint API rentan jika:

* Endpoint API mengekspos properti objek yang dianggap sensitif dan tidak boleh dibaca oleh pengguna. (sebelumnya bernama: "[Paparan Data Berlebihan][1]")  
* Endpoint API memungkinkan pengguna untuk mengubah, menambah/atau menghapus nilai properti objek sensitif yang seharusnya tidak dapat diakses pengguna (sebelumnya bernama: "[Penugasan Massal][2]")

## Skenario Serangan Contoh

### Skenario #1

Sebuah aplikasi kencan memungkinkan pengguna melaporkan pengguna lain karena perilaku yang tidak pantas. Sebagai bagian dari alur ini, pengguna mengklik tombol "laporkan", dan panggilan API berikut terpicu:

```
POST /graphql
{
  "operationName":"reportUser",
  "variables":{
    "userId": 313,
    "reason":["offensive behavior"]
  },
  "query":"mutation reportUser($userId: ID!, $reason: String!) {
    reportUser(userId: $userId, reason: $reason) {
      status
      message
      reportedUser {
        id
        fullName
        recentLocation
      }
    }
  }"
}
```

Endpoint API rentan karena memungkinkan pengguna terautentikasi memiliki akses ke properti objek pengguna sensitif yang dilaporkan, seperti "fullName" dan "recentLocation" yang seharusnya tidak diakses oleh pengguna lain.

### Skenario #2

Sebuah platform marketplace online, yang menawarkan satu jenis pengguna ("host") untuk menyewakan apartemen mereka ke jenis pengguna lain ("tamu"), mensyaratkan host untuk menerima pemesanan yang dibuat oleh tamu, sebelum membebankan tamu untuk tinggal.

Sebagai bagian dari alur ini, panggilan API dikirim oleh host ke `POST /api/host/approve_booking` dengan payload sah berikut:

```
{
  "approved": true,
  "comment": "Check-in setelah pukul 3 sore" 
}
```

Host memutar ulang permintaan yang sah, dan menambahkan payload berbahaya berikut: 

```
{
  "approved": true, 
  "comment": "Check-in setelah pukul 3 sore",
  "total_stay_price": "$1,000,000"
}
```

Endpoint API rentan karena tidak ada validasi bahwa host harus memiliki akses ke properti objek internal - `total_stay_price`, dan tamu akan dikenakan biaya lebih dari yang seharusnya.

### Skenario #3

Sebuah jejaring sosial yang didasarkan pada video pendek, menerapkan filter konten yang membatasi dan sensor yang ketat. Bahkan jika video yang diunggah diblokir, pengguna dapat mengubah deskripsi video menggunakan permintaan API berikut:

```
PUT /api/video/update_video

{
  "description": "video lucu tentang kucing" 
}
```

Pengguna yang frustrasi dapat memutar ulang permintaan yang sah, dan menambahkan payload berbahaya berikut:

```
{
  "description": "video lucu tentang kucing",
  "blocked": false  
}
```

Endpoint API rentan karena tidak ada validasi apakah pengguna harus memiliki akses ke properti objek internal - `blocked`, dan pengguna dapat mengubah nilai dari `true` ke `false` dan membuka kunci konten mereka sendiri yang diblokir.

## Cara Mencegah

* Saat mengekspos objek menggunakan endpoint API, pastikan selalu bahwa pengguna harus memiliki akses ke properti objek yang Anda ekspos.
* Hindari menggunakan metode generik seperti `to_json()` dan `to_string()`. Sebaliknya, pilih properti objek tertentu yang ingin Anda kembalikan.  
* Jika memungkinkan, hindari menggunakan fungsi yang secara otomatis mengikat input klien ke dalam variabel kode, objek internal, atau properti objek ("Penugasan Massal").
* Izinkan perubahan hanya pada properti objek yang seharusnya diperbarui oleh klien.
* Terapkan mekanisme validasi respons berbasis skema sebagai lapisan keamanan tambahan. Sebagai bagian dari mekanisme ini, tentukan dan paksakan data yang dikembalikan oleh semua metode API.
* Jaga struktur data yang dikembalikan hanya sesuai persyaratan bisnis/fungsional untuk endpoint tersebut.

## Referensi

### OWASP

* [API3:2019 Paparan Data Berlebihan - OWASP API Security Top 10 2019][1]  
* [API6:2019 - Penugasan Massal - OWASP API Security Top 10 2019][2]
* [Cheat Sheet Penugasan Massal][3]

### Eksternal

* [CWE-213: Pengungkapan Informasi Sensitif karena Kebijakan yang Tidak Kompatibel][4]
* [CWE-915: Kontrol Modifikasi Atribut Objek yang Ditentukan Secara Dinamis secara Tidak Tepat][5]

[1]: https://owasp.org/API-Security/editions/2019/id/0xa3-excessive-data-exposure/
[2]: https://owasp.org/API-Security/editions/2019/id/0xa6-mass-assignment/ 
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Mass_Assignment_Cheat_Sheet.html
[4]: https://cwe.mitre.org/data/definitions/213.html
[5]: https://cwe.mitre.org/data/definitions/915.html

