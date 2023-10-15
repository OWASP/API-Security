# Apa Selanjutnya untuk DevSecOps

Karena pentingnya dalam arsitektur aplikasi modern, membangun API yang aman adalah suatu keharusan. Keamanan tidak boleh diabaikan, dan itu harus menjadi bagian dari seluruh siklus pengembangan. Pemindaian dan pengujian penetrasi setahun sekali tidak lagi cukup.

DevSecOps harus bergabung dengan upaya pengembangan, memfasilitasi pengujian keamanan berkelanjutan di seluruh siklus pengembangan perangkat lunak. Tujuan Anda harus meningkatkan jalur pengembangan dengan otomatisasi keamanan, tanpa memengaruhi kecepatan pengembangan.

Jika ragu, tetap terinformasi, dan lihat [Manifesto DevSecOps][1].

| | |
|-|-|
| **Mengerti Model Ancaman** | Prioritas pengujian berasal dari model ancaman. Jika Anda tidak memiliki satu, pertimbangkan untuk menggunakan [Standar Verifikasi Keamanan Aplikasi OWASP (ASVS)][2], dan [Panduan Pengujian OWASP][3] sebagai masukan. Melibatkan tim pengembangan akan membantu membuat mereka lebih sadar akan keamanan. |
| **Mengerti SDLC** | Bergabunglah dengan tim pengembangan untuk lebih memahami Siklus Hidup Pengembangan Perangkat Lunak. Kontribusi Anda pada pengujian keamanan berkelanjutan harus sesuai dengan orang, proses, dan alat. Semua orang harus setuju dengan proses tersebut, sehingga tidak ada gesekan atau resistensi yang tidak perlu. |
| **Strategi Pengujian** | Karena pekerjaan Anda tidak boleh memengaruhi kecepatan pengembangan, Anda harus bijak memilih teknik terbaik (sederhana, cepat, paling akurat) untuk memverifikasi persyaratan keamanan. [Kerangka Pengetahuan Keamanan OWASP][4] dan [Standar Verifikasi Keamanan Aplikasi OWASP][2] dapat menjadi sumber besar persyaratan keamanan fungsional dan nonfungsional. Ada sumber-sumber besar lainnya untuk [proyek][5] dan [alat][6] yang serupa dengan yang ditawarkan oleh [komunitas DevSecOps][7]. |
| **Mencapai Cakupan dan Akurasi** | Anda adalah jembatan antara tim pengembangan dan tim operasi. Untuk mencapai cakupan, Anda harus fokus tidak hanya pada fungsionalitas, tetapi juga orkestrasi. Bekerja dekat dengan kedua tim pengembangan dan operasi sejak awal sehingga Anda dapat mengoptimalkan waktu dan usaha Anda. Anda harus bertujuan untuk mencapai keamanan yang esensial diverifikasi secara berkelanjutan. |
| **Komunikasikan Temuan dengan Jelas** | Memberikan nilai tanpa atau dengan sedikit gesekan. Sampaikan temuan tepat waktu, dalam alat yang digunakan tim pengembangan (bukan file PDF). Bergabung dengan tim pengembangan untuk mengatasi temuan. Manfaatkan kesempatan ini untuk memberi mereka pendidikan, dengan menjelaskan dengan jelas kelemahan dan bagaimana itu bisa dieksploitasi, termasuk skenario serangan untuk membuatnya nyata. |

[1]: https://www.devsecops.org/
[2]: https://owasp.org/www-project-application-security-verification-standard/
[3]: https://owasp.org/www-project-web-security-testing-guide/
[4]: https://owasp.org/www-project-security-knowledge-framework/
[5]: http://devsecops.github.io/
[6]: https://github.com/devsecops/awesome-devsecops
[7]: http://devsecops.org