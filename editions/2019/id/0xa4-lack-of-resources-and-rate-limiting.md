# API4:2019 Kurangnya Sumber Daya & Pembatasan Laju

| Agen Ancaman/Vektor Serangan | Kelemahan Keamanan | Dampak |
| - | - | - |
| Khusus API: Eksploitasi **2** | Prevalensi **3** : Deteksi **3** | Teknis **2** : Spesifik Bisnis |  
| Eksploitasi memerlukan permintaan API sederhana. Tidak ada otentikasi yang diperlukan. Beberapa permintaan secara bersamaan dapat dilakukan dari satu komputer lokal atau dengan menggunakan sumber daya komputasi cloud. | Umum ditemukan API yang tidak menerapkan pembatasan laju atau API di mana batas tidak ditetapkan dengan benar. | Eksploitasi dapat mengarah ke DoS, membuat API tidak responsif atau bahkan tidak tersedia. |

## Apakah API Rentan?

Permintaan API mengonsumsi sumber daya seperti jaringan, CPU, memori, dan penyimpanan. Jumlah sumber daya yang diperlukan untuk memenuhi permintaan sangat bergantung pada input pengguna dan logika bisnis endpoint. Juga, pertimbangkan fakta bahwa permintaan dari beberapa klien API bersaing untuk sumber daya. API rentan jika setidaknya satu dari batasan berikut hilang atau disetel secara tidak tepat (misalnya, terlalu rendah/tinggi):

* Batas waktu eksekusi  
* Memori maksimum yang dapat dialokasikan
* Jumlah deskriptor berkas
* Jumlah proses
* Ukuran muatan permintaan (misalnya, unggahan) 
* Jumlah permintaan per klien/sumber daya
* Jumlah catatan per halaman untuk dikembalikan dalam satu respons permintaan

## Skenario Serangan Contoh

### Skenario #1

Seorang penyerang mengunggah gambar besar dengan menerbitkan permintaan POST ke `/api/v1/images`. Saat unggahan selesai, API membuat beberapa thumbnail dengan ukuran yang berbeda. Karena ukuran gambar yang diunggah, memori yang tersedia habis selama pembuatan thumbnail dan API menjadi tidak responsif.

### Skenario #2

Kami memiliki aplikasi yang berisi daftar pengguna di UI dengan batas `200` pengguna per halaman. Daftar pengguna diambil dari server menggunakan kueri berikut: `/api/users?page=1&size=200`. Seorang penyerang mengubah parameter `size` menjadi `200.000`, menyebabkan masalah kinerja pada basis data. Sementara itu, API menjadi tidak responsif dan tidak dapat menangani permintaan lebih lanjut dari klien ini atau klien lainnya (alias DoS).

Skenario yang sama dapat digunakan untuk memancing kesalahan Integer Overflow atau Buffer Overflow.

## Cara Mencegah

* Docker memudahkan untuk membatasi [memori][1], [CPU][2], [jumlah restart][3], [deskriptor berkas, dan proses][4].
* Terapkan batas seberapa sering klien dapat memanggil API dalam rentang waktu tertentu.  
* Beri tahu klien saat batas terlampaui dengan menyediakan nomor batas dan waktu saat batas akan direset.
* Tambahkan validasi server-side yang tepat untuk parameter string kueri dan body permintaan, khususnya yang mengendalikan jumlah catatan yang akan dikembalikan dalam respons.
* Tentukan dan tegakkan ukuran maksimum data pada semua parameter dan muatan masukan seperti panjang maksimum untuk string dan jumlah elemen maksimum dalam array.


## Referensi

### OWASP

* [Blocking Brute Force Attacks][5]
* [Docker Cheat Sheet - Limit resources (memory, CPU, file descriptors,
  processes, restarts)][6]
* [REST Assessment Cheat Sheet][7]

### Eksternal

* [CWE-307: Improper Restriction of Excessive Authentication Attempts][8]
* [CWE-770: Allocation of Resources Without Limits or Throttling][9]
* “_Rate Limiting (Throttling)_” - [Security Strategies for Microservices-based
  Application Systems][10], NIST

[1]: https://docs.docker.com/config/containers/resource_constraints/#memory
[2]: https://docs.docker.com/config/containers/resource_constraints/#cpu
[3]: https://docs.docker.com/engine/reference/commandline/run/#restart-policies---restart
[4]: https://docs.docker.com/engine/reference/commandline/run/#set-ulimits-in-container---ulimit
[5]: https://www.owasp.org/index.php/Blocking_Brute_Force_Attacks
[6]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/Docker_Security_Cheat_Sheet.md#rule-7---limit-resources-memory-cpu-file-descriptors-processes-restarts 
[7]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/REST_Assessment_Cheat_Sheet.md
[8]: https://cwe.mitre.org/data/definitions/307.html
[9]: https://cwe.mitre.org/data/definitions/770.html
[10]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-204-draft.pdf