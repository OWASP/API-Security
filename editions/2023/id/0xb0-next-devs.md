# Apa Selanjutnya untuk Pengembang

Tugas untuk membuat dan memelihara aplikasi yang aman, atau memperbaiki aplikasi yang sudah ada, bisa menjadi sulit. Ini tidak berbeda untuk API.

Kami percaya bahwa pendidikan dan kesadaran adalah faktor kunci dalam menulis perangkat lunak yang aman. Semua yang diperlukan untuk mencapai tujuan ini bergantung pada **mendirikan dan menggunakan proses keamanan yang dapat diulang serta kendali keamanan standar**.

OWASP menyediakan banyak sumber daya gratis dan terbuka untuk membantu Anda mengatasi masalah keamanan. Silakan kunjungi [halaman Proyek OWASP][1] untuk daftar komprehensif proyek yang tersedia.

| | |
|-|-|
| **Pendidikan** | [Pemandu Keamanan Aplikasi][2] seharusnya memberi Anda gambaran baik tentang proyek-proyek yang tersedia untuk setiap tahap/fase Siklus Hidup Pengembangan Perangkat Lunak (SDLC). Untuk pembelajaran/latihan langsung, Anda dapat memulainya dengan [OWASP **crAPI** - **C**ompletely **R**idiculous **API**][3] atau [OWASP Juice Shop][4]: keduanya memiliki API yang rentan secara disengaja. [Proyek Direktori Aplikasi Web Rentan OWASP][5] menyediakan daftar aplikasi yang rentan secara disengaja: Anda akan menemukan beberapa API rentan lainnya di sana. Anda juga dapat menghadiri sesi pelatihan [Konferensi OWASP AppSec][6], atau [bergabung dengan cabang lokal Anda][7]. |
| **Persyaratan Keamanan** | Keamanan seharusnya menjadi bagian setiap proyek sejak awal. Ketika mendefinisikan persyaratan, penting untuk mendefinisikan apa arti "aman" untuk proyek tersebut. OWASP merekomendasikan Anda menggunakan [Standar Verifikasi Keamanan Aplikasi OWASP (ASVS)][8] sebagai panduan untuk menetapkan persyaratan keamanan. Jika Anda mengalihdayakan, pertimbangkan [Lampiran Kontrak Perangkat Lunak Aman OWASP][9], yang harus disesuaikan sesuai dengan hukum dan regulasi setempat. |
| **Arsitektur Keamanan** | Keamanan seharusnya tetap menjadi perhatian selama semua tahapan proyek. [Seri Contekan OWASP][10] adalah titik awal yang baik untuk panduan tentang bagaimana mendesain keamanan selama fase arsitektur. Di antara banyak lainnya, Anda akan menemukan [Contekan Keamanan REST][11] dan [Contekan Penilaian REST][12], serta [Contekan GraphQL][13]. |
| **Kendali Keamanan Standar** | Mengadopsi kendali keamanan standar mengurangi risiko memasukkan kelemahan keamanan saat menulis logika Anda sendiri. Meskipun banyak kerangka kerja modern sekarang dilengkapi dengan kendali standar yang efektif, [Kendali Proaktif OWASP][14] memberikan pandangan yang baik tentang kendali keamanan apa yang seharusnya Anda sertakan dalam proyek Anda. OWASP juga menyediakan beberapa perpustakaan dan alat yang mungkin Anda temukan berguna, seperti kendali validasi. |
| **Siklus Hidup Pengembangan Perangkat Lunak Aman** | Anda dapat menggunakan [Model Kematangan Jaminan Perangkat Lunak OWASP (SAMM)][15] untuk meningkatkan proses pembuatan API Anda. Beberapa proyek OWASP lainnya tersedia untuk membantu Anda dalam berbagai tahap pengembangan API, misalnya, [Panduan Tinjauan Kode OWASP][16]. |

[1]: https://owasp.org/projects/
[2]: https://owasp.org/projects/#owasp-projects-the-sdlc-and-the-security-wayfinder
[3]: https://owasp.org/www-project-crapi/
[4]: https://owasp.org/www-project-juice-shop/
[5]: https://owasp.org/www-project-vulnerable-web-applications-directory/
[6]: https://owasp.org/events/
[7]: https://owasp.org/chapters/
[8]: https://owasp.org/www-project-application-security-verification-standard/
[9]: https://owasp.org/www-community/OWASP_Secure_Software_Contract_Annex
[10]: https://cheatsheetseries.owasp.org/
[11]: https://cheatsheetseries.owasp.org/cheatsheets/REST_Security_Cheat_Sheet.html
[12]: https://cheatsheetseries.owasp.org/cheatsheets/REST_Assessment_Cheat_Sheet.html
[13]: https://cheatsheetseries.owasp.org/cheatsheets/GraphQL_Cheat_Sheet.html
[14]: https://owasp.org/www-project-proactive-controls/
[15]: https://owasp.org/www-project-samm/
[16]: https://owasp.org/www-project-code-review-guide/