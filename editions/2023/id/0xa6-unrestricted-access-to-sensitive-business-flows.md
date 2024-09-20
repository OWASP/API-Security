# API6:2023 Akses Tanpa Batas ke Aliran Bisnis Sensitif

| Agen ancaman/Vektor serangan | Kelemahan Keamanan | Dampak |
| - | - | - |
| Khusus API: **Mudah** dieksploitasi | Prevalensi **Luas** : Terdeteksi **Rata-rata** | Teknis **Sedang** : Spesifik Bisnis |
| Eksploitasi biasanya melibatkan pemahaman model bisnis yang didukung oleh API, menemukan aliran bisnis sensitif, dan mengotomatisasi akses ke aliran tersebut, yang merugikan bisnis. | Kurangnya pandangan holistik tentang API untuk sepenuhnya mendukung persyaratan bisnis cenderung berkontribusi pada prevalensi masalah ini. Penyerang secara manual mengidentifikasi sumber daya (misalnya endpoint) apa yang terlibat dalam alur kerja target dan bagaimana mereka bekerja sama. Jika mekanisme mitigasi sudah ada, penyerang perlu menemukan cara untuk melewatinya. | Secara umum, dampak teknis tidak diharapkan. Eksploitasi mungkin merugikan bisnis dengan berbagai cara, misalnya: mencegah pengguna sah membeli produk, atau menyebabkan inflasi dalam perekonomian internal sebuah game. |

## Apakah API Rentan?

Saat membuat Endpoint API, penting untuk memahami aliran bisnis apa yang dieksposnya. Beberapa aliran bisnis lebih sensitif daripada yang lain, dalam artian akses berlebihan ke dalamnya dapat merugikan bisnis. 

Contoh umum aliran bisnis sensitif dan risiko akses berlebihan yang terkait dengannya:

* Aliran pembelian produk - seorang penyerang dapat membeli semua persediaan item yang sangat diminati secara sekaligus dan menjual kembali dengan harga yang lebih tinggi (penimbunan)
* Aliran membuat komentar/posting - seorang penyerang dapat men-spam sistem  
* Melakukan reservasi - seorang penyerang dapat memesan semua slot waktu yang tersedia dan mencegah pengguna lain menggunakan sistem

Risiko akses berlebihan mungkin berubah antar industri dan bisnis. Misalnya - pembuatan post oleh skrip mungkin dianggap sebagai risiko spam oleh satu jejaring sosial, tetapi didorong oleh jejaring sosial lainnya.

Sebuah Endpoint API rentan jika mengekspos aliran bisnis sensitif, tanpa membatasi akses ke dalamnya dengan tepat.

## Contoh Skenario Serangan

### Skenario #1  

Sebuah perusahaan teknologi mengumumkan akan merilis konsol game baru di hari Thanksgiving. Produk ini memiliki permintaan yang sangat tinggi dan persediaannya terbatas. Seorang penyerang menulis kode untuk secara otomatis membeli produk baru dan menyelesaikan transaksi. 

Pada hari rilis, penyerang menjalankan kode yang didistribusikan di berbagai alamat IP dan lokasi. API tidak menerapkan perlindungan yang tepat dan memungkinkan penyerang untuk membeli sebagian besar persediaan sebelum pengguna sah lainnya. 

Kemudian, penyerang menjual produk di platform lain dengan harga jauh lebih tinggi.

### Skenario #2

Sebuah maskapai penerbangan menawarkan pembelian tiket online tanpa biaya pembatalan. Seorang pengguna dengan niat jahat memesan 90% kursi penerbangan yang diinginkan.

Beberapa hari sebelum penerbangan pengguna jahat membatalkan semua tiket sekaligus, yang memaksa maskapai untuk memberikan diskon harga tiket untuk mengisi penerbangan. 

Pada titik ini, pengguna membeli satu tiket untuk dirinya sendiri yang jauh lebih murah dari yang asli.

### Skenario #3  

Sebuah aplikasi ride-sharing menyediakan program referral - pengguna dapat mengundang teman mereka dan mendapatkan kredit untuk setiap teman yang bergabung dengan aplikasi. Kredit ini kemudian dapat digunakan sebagai uang tunai untuk memesan tumpangan.

Seorang penyerang mengeksploitasi alur ini dengan menulis skrip untuk mengotomatisasi proses pendaftaran, dengan setiap pengguna baru menambahkan kredit ke dompet penyerang. 

Penyerang kemudian dapat menikmati tumpangan gratis atau menjual akun dengan kredit berlebihan untuk uang tunai.

## Cara Mencegah

Perencanaan mitigasi harus dilakukan dalam dua lapisan:

* Bisnis - identifikasi aliran bisnis yang mungkin merugikan bisnis jika digunakan secara berlebihan.
* Rekayasa - pilih mekanisme perlindungan yang tepat untuk memitigasi risiko bisnis.

    Beberapa mekanisme perlindungan lebih sederhana sementara yang lain lebih sulit diterapkan. Metode berikut digunakan untuk memperlambat ancaman otomatis:

    * Fingerprinting perangkat: menolak layanan ke perangkat klien yang tidak diharapkan (misalnya headless browser) cenderung membuat aktor ancaman menggunakan solusi yang lebih canggih, sehingga lebih mahal bagi mereka
    * Deteksi manusia: menggunakan captcha atau solusi biometrik tingkat lanjut (misalnya pola pengetikan)
    * Pola non-manusia: menganalisis alur pengguna untuk mendeteksi pola non-manusia (misalnya pengguna mengakses fungsi "tambah ke keranjang" dan "selesaikan pembelian" dalam waktu kurang dari satu detik)
    * Pertimbangkan memblokir alamat IP dari node keluar Tor dan proxy terkenal

  Amankan dan batasi akses ke API yang dikonsumsi langsung oleh mesin (seperti API pengembang dan B2B). Mereka cenderung menjadi target yang mudah bagi penyerang karena seringkali tidak menerapkan semua mekanisme perlindungan yang diperlukan.
  
## Referensi

### OWASP

* [OWASP Ancaman Otomatis ke Aplikasi Web][1]  
* [API10:2019 Pencatatan & Pemantauan yang Tidak Memadai][2]

[1]: https://owasp.org/www-project-automated-threats-to-web-applications/
[2]: https://owasp.org/API-Security/editions/2019/id/0xaa-insufficient-logging-monitoring/
