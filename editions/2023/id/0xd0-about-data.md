# Metodologi dan Data

## Ringkasan

Untuk pembaruan daftar ini, tim Keamanan API OWASP menggunakan metodologi yang sama dengan yang digunakan untuk daftar tahun 2019 yang sukses dan banyak diadopsi, dengan tambahan [Panggilan Data Publik][1] selama 3 bulan. Sayangnya, panggilan data ini tidak menghasilkan data yang memungkinkan analisis statistik yang relevan mengenai masalah keamanan API yang paling umum.

Namun, dengan industri keamanan API yang lebih matang dan mampu memberikan umpan balik dan wawasan langsung, proses pembaruan terus berlanjut dengan menggunakan metodologi yang sama seperti sebelumnya.

Sampai di sini, kami percaya bahwa kami telah memiliki dokumen kesadaran yang fokus ke depan untuk tiga atau empat tahun mendatang, yang lebih berfokus pada masalah khusus API modern. Tujuan dari proyek ini bukanlah menggantikan daftar 10 besar lainnya, tetapi sebaliknya untuk menangani risiko keamanan API teratas yang ada dan yang akan datang, yang menurut kami harus diperhatikan oleh industri.

## Metodologi

Dalam fase pertama, data yang tersedia secara publik tentang insiden keamanan API dikumpulkan, ditinjau, dan dikategorikan. Data tersebut dikumpulkan dari platform bug bounty dan laporan yang tersedia secara publik. Hanya masalah yang dilaporkan antara 2019 dan 2022 yang dipertimbangkan. Data ini digunakan untuk memberikan gambaran pada tim mengenai ke arah mana daftar 10 besar sebelumnya seharusnya berkembang serta membantu mengatasi bias atas data yang disumbangkan.

[Panggilan Data Publik][1] berjalan mulai dari 1 September hingga 30 November 2022. Secara paralel, tim proyek mulai mendiskusikan apa yang telah berubah sejak 2019. Diskusi tersebut mencakup dampak dari daftar sebelumnya, umpan balik yang diterima dari komunitas, dan tren baru dalam keamanan API.

Tim proyek mempromosikan pertemuan dengan spesialis tentang ancaman keamanan API yang relevan untuk mendapatkan wawasan tentang bagaimana korban terpengaruh dan bagaimana ancaman-ancaman tersebut dapat diatasi.

Upaya ini menghasilkan draf awal tentang apa yang tim percayai sebagai sepuluh risiko keamanan API yang paling kritis. [Metodologi Penilaian Risiko OWASP][2] digunakan untuk melakukan analisis risiko. Peringkat prevalensi diputuskan dari konsensus di antara anggota tim proyek, berdasarkan pengalaman mereka di lapangan. Untuk pertimbangan-pertimbangan tentang masalah ini, silakan lihat bagian [Risiko Keamanan API][3].

Draf awal kemudian dibagikan untuk ditinjau oleh praktisi keamanan dengan pengalaman relevan di bidang keamanan API. Komentar mereka ditinjau, didiskusikan, dan jika berlaku, dimasukkan dalam dokumen. Dokumen yang dihasilkan [dipublikasikan sebagai Calon Rilis][4] untuk [diskusi terbuka][5]. Beberapa [kontribusi komunitas][6] dimasukkan ke dalam dokumen final.

Daftar kontributor tersedia dalam bagian [Ucapan Terimakasih][7].

## Risiko Khusus API

Daftar ini dibangun untuk mengatasi risiko keamanan yang lebih spesifik untuk API.

Hal ini tidak berarti bahwa risiko keamanan aplikasi generik lainnya tidak ada dalam aplikasi berbasis API. Sebagai contoh, kami tidak memasukkan risiko seperti "Komponen yang Rentan dan Sudah Ketinggalan Zaman" atau "Injection", meskipun Anda mungkin menemukannya dalam aplikasi berbasis API. Risiko-risiko ini bersifat generik, mereka tidak berperilaku berbeda dalam API, dan eksploitasi mereka juga tidak berbeda.

Tujuan kami adalah meningkatkan kesadaran tentang risiko keamanan yang memerlukan perhatian khusus dalam API.

[1]: https://owasp.org/www-project-api-security/announcements/cfd/2022/
[2]: https://www.owasp.org/index.php/OWASP_Risk_Rating_Methodology
[3]: ./0x10-api-security-risks.md
[4]: https://owasp.org/www-project-api-security/announcements/2023/02/api-top10-2023rc
[5]: https://github.com/OWASP/API-Security/issues?q=is%3Aissue+label%3A2023RC
[6]: https://github.com/OWASP/API-Security/pulls?q=is%3Apr+label%3A2023RC
[7]: ./0xd1-acknowledgments.md
