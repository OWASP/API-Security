# Apa Selanjutnya untuk Pengembang

Tugas untuk membuat dan memelihara perangkat lunak yang aman, atau memperbaiki perangkat lunak yang ada, dapat sulit. API tidak berbeda. 

Kami yakin bahwa pendidikan dan kesadaran adalah faktor kunci untuk menulis perangkat lunak yang aman. Semua hal lain yang diperlukan untuk mencapai tujuan, bergantung pada **membangun dan menggunakan proses keamanan yang dapat diulang dan kontrol keamanan standar**.

OWASP memiliki berbagai sumber daya gratis dan terbuka untuk mengatasi masalah keamanan sejak awal proyek. Silakan kunjungi halaman [Proyek OWASP][1] untuk daftar lengkap proyek yang tersedia. 

| | |
|-|-|
| **Pendidikan** | Anda dapat mulai membaca [materi Proyek Pendidikan OWASP][2] sesuai dengan profesi dan minat Anda. Untuk pembelajaran hands-on, kami menambahkan **crAPI** - **C**ompletely **R**idiculous **API** dalam [roadmap kami][3]. Sementara itu, Anda dapat berlatih WebAppSec menggunakan [Modul Pixi DevSlop OWASP][4], layanan WebApp dan API rentan yang bertujuan untuk mengajari pengguna cara menguji aplikasi web dan API modern untuk masalah keamanan, dan cara menulis API yang lebih aman di masa depan. Anda juga dapat menghadiri sesi pelatihan [Konferensi OWASP AppSec][5], atau [bergabung dengan chapter lokal Anda][6]. |
| **Persyaratan Keamanan** | Keamanan harus menjadi bagian dari setiap proyek sejak awal. Saat melakukan elicitation persyaratan, penting untuk mendefinisikan apa artinya "aman" untuk proyek tersebut. OWASP merekomendasikan Anda menggunakan [OWASP Application Security Verification Standard (ASVS)][7] sebagai panduan untuk menetapkan persyaratan keamanan. Jika Anda outsourcing, pertimbangkan [OWASP Secure Software Contract Annex][8], yang harus disesuaikan sesuai hukum dan peraturan setempat. |
| **Arsitektur Keamanan** | Keamanan harus tetap menjadi perhatian selama semua tahapan proyek. [OWASP Prevention Cheat Sheets][9] merupakan titik awal yang baik untuk panduan tentang cara merancang keamanan selama fase arsitektur. Di antara banyak lainnya, Anda akan menemukan [REST Security Cheat Sheet][10] dan [REST Assessment Cheat Sheet][11]. | 
| **Kontrol Keamanan Standar** | Mengadopsi Kontrol Keamanan Standar mengurangi risiko memperkenalkan kelemahan keamanan saat menulis logika Anda sendiri. Meskipun fakta banyak kerangka kerja modern sekarang datang dengan kontrol efektif standar bawaan, [OWASP Proactive Controls][12] memberi Anda gambaran yang baik tentang kontrol keamanan apa yang harus Anda cari untuk dimasukkan dalam proyek Anda. OWASP juga menyediakan beberapa pustaka dan alat yang mungkin Anda anggap berharga, seperti kontrol validasi. |
| **Siklus Hidup Pengembangan Perangkat Lunak yang Aman** | Anda dapat menggunakan [OWASP Software Assurance Maturity Model (SAMM)][13] untuk meningkatkan proses saat membangun API. Beberapa proyek OWASP lainnya tersedia untuk membantu Anda selama fase pengembangan API yang berbeda misalnya, [OWASP Code Review Project][14]. |


[1]: https://www.owasp.org/index.php/Category:OWASP_Project
[2]: https://www.owasp.org/index.php/OWASP_Education_Material_Categorized
[3]: https://www.owasp.org/index.php/OWASP_API_Security_Project#tab=Road_Map
[4]: https://devslop.co/Home/Pixi
[5]: https://www.owasp.org/index.php/Category:OWASP_AppSec_Conference
[6]: https://www.owasp.org/index.php/OWASP_Chapter
[7]: https://www.owasp.org/index.php/Category:OWASP_Application_Security_Verification_Standard_Project
[8]: https://www.owasp.org/index.php/OWASP_Secure_Software_Contract_Annex
[9]: https://www.owasp.org/index.php/OWASP_Cheat_Sheet_Series
[10]: https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/REST_Security_Cheat_Sheet.md
[11]: https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/REST_Assessment_Cheat_Sheet.md
[12]: https://www.owasp.org/index.php/OWASP_Proactive_Controls#tab=OWASP_Proactive_Controls_2018
[13]: https://www.owasp.org/index.php/OWASP_SAMM_Project
[14]: https://www.owasp.org/index.php/Category:OWASP_Code_Review_Project
