# API10:2019 Pencatatan & Pemantauan yang Tidak Memadai

| Agen Ancaman/Vektor Serangan | Kelemahan Keamanan | Dampak |
| - | - | - |
| Khusus API: Eksploitasi **2** | Prevalensi **3** : Deteksi **1** | Teknis **2** : Spesifik Bisnis |
| Penyerang memanfaatkan kurangnya pencatatan dan pemantauan untuk menyalahgunakan sistem tanpa disadari. | Tanpa pencatatan dan pemantauan, atau dengan pencatatan dan pemantauan yang tidak memadai, hampir mustahil untuk melacak kegiatan mencurigakan dan menanggapinya tepat waktu. | Tanpa visibilitas atas kegiatan berbahaya yang sedang berlangsung, penyerang memiliki banyak waktu untuk sepenuhnya mengkompromikan sistem. |  

## Apakah API Rentan?

API rentan jika:

* Tidak menghasilkan log apa pun, level pencatatan tidak disetel dengan benar, atau pesan log tidak menyertakan detail yang cukup. 
* Integritas log tidak dijamin (misalnya, [Log Injection][1]).
* Log tidak dipantau secara terus menerus.  
* Infrastruktur API tidak dipantau secara terus menerus.

## Skenario Serangan Contoh  

### Skenario #1

Kunci akses administratif API bocor di repositori publik. Pemilik repositori diberi tahu melalui email tentang kebocoran potensial, tetapi membutuhkan waktu lebih dari 48 jam untuk menindaklanjuti insiden, dan paparan kunci akses mungkin telah mengizinkan akses ke data sensitif. Karena pencatatan yang tidak memadai, perusahaan tidak dapat menilai data apa yang diakses oleh aktor berbahaya.

### Skenario #2

Platform berbagi video terkena serangan "skala besar" stuffing kredensial. Meskipun login gagal dicatat, tidak ada peringatan yang dipicu selama rentang waktu serangan. Sebagai reaksi atas keluhan pengguna, log API dianalisis dan serangan terdeteksi. Perusahaan harus membuat pengumuman publik yang meminta pengguna mereset kata sandi mereka, dan melaporkan insiden kepada otoritas peraturan.

## Cara Mencegah

* Catat semua upaya otentikasi gagal, akses yang ditolak, dan kesalahan validasi input.  
* Log harus ditulis menggunakan format yang sesuai untuk dikonsumsi oleh solusi manajemen log, dan harus mencakup detail yang cukup untuk mengidentifikasi pelaku jahat.
* Log harus ditangani sebagai data sensitif, dan integritasnya harus dijamin saat diam dan dalam transit.
* Konfigurasikan sistem pemantauan untuk secara terus menerus memantau infrastruktur, jaringan, dan fungsi API.
* Gunakan sistem Manajemen Informasi dan Keamanan (SIEM) untuk menggabungkan dan mengelola log dari semua komponen tumpukan API dan host.
* Konfigurasikan dashboard dan peringatan kustom, memungkinkan kegiatan mencurigakan terdeteksi dan direspon lebih awal.

## Referensi


### OWASP

* [OWASP Logging Cheat Sheet][2]
* [OWASP Proactive Controls: Implement Logging and Intrusion Detection][3]
* [OWASP Application Security Verification Standard: V7: Error Handling and
  Logging Verification Requirements][4]

### Eksternal

* [CWE-223: Omission of Security-relevant Information][5]
* [CWE-778: Insufficient Logging][6]

[1]: https://www.owasp.org/index.php/Log_Injection
[2]: https://www.owasp.org/index.php/Logging_Cheat_Sheet
[3]: https://www.owasp.org/index.php/OWASP_Proactive_Controls
[4]: https://github.com/OWASP/ASVS/blob/master/4.0/en/0x15-V7-Error-Logging.md
[5]: https://cwe.mitre.org/data/definitions/223.html
[6]: https://cwe.mitre.org/data/definitions/778.html
