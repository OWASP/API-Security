# Catatan Rilis

Ini adalah edisi kedua OWASP API Security Top 10, tepat empat tahun setelah rilis pertama. Banyak perubahan terjadi dalam area keamanan API. Lalu lintas API meningkat dalam fase yang cepat, beberapa protokol API mendapatkan banyak daya tarik, berbagai solusi/vendor keamanan API telah bermunculan, dan tentu saja, para penyerang telah mengembangkan kemampuan dan teknik baru untuk menyerang API. Sudah saatnya untuk memperbarui daftar sepuluh risiko paling kritis keamanan API.

Dengan semakin matangnya industri keamanan API, untuk pertama kalinya, ada [panggilan publik untuk data][1]. Namun sayangnya, tidak ada data yang dikontribusikan, namun berdasarkan pengalaman tim proyek, tinjauan cermat spesialis keamanan API, dan masukan dari komunitas, kami membuat daftar baru ini. Dalam bagian 
[Metodologi dan Data][2], anda akan menemukan informasi rinci mengenai bagaimana versi ini dikembangkan. Informasi lebih rinci mengenai risiko keamanan silakan mengacu ke bagian
[Risiko Keamanan API][3].

OWASP API Security Top 10 2023 adalah dokumen kesadaran berwawasan ke depan untuk industri yang berkembang cepat. Dokumen ini tidak menggantikan TOP 10 lainnya. Dalam edisi ini:

* Kami telah menggabungkan Paparan Data Berlebihan dan  Penugasan Massal dengan berfokus pada akar masalah yang sama: kegagalan validasi otorisasi tingkat properti obyek.
* Kami lebih menekankan pada konsumsi sumber daya, daripada berfokus pada kecepatan mereka dihabiskan.
* Kami telah membuat kategori baru "Akses Tanpa Batas ke Aliran Bisnis Sensitif" untuk mengatasi ancaman baru, termasuk ancaman yang dapat dimitigasi dengan menggunakan pembatasan. 
* Kami menambahkan "Konsumsi API yang Tidak Aman" untuk mengatasi sesuatu hal yang mulai kami jumpai: penyerang telah mulai menyasar layanan integrasi target, alih-alih menyerang API target secara langsung. Saat ini adalah saat yang tepat untuk mulai membuat kesadaran atas meningkatnya risiko ini.

API memainkan peranan penting dalam arsitektur mikroservice modern, Single Page Applications (SPA), aplikasi mobile, IoT, dsb. OWASP API Security
Top 10 adalah upaya yang dibutuhkan untuk menciptakan kesadaran mengenai isu-isu keamanan API modern.

Pembaruan ini hanya dimungkinkan berkat usaha besar beberapa sukarelawan yang tercantum dalam bagian  [Ucapan Terima Kasih][4] section.

Thank you!

[1]: https://owasp.org/www-project-api-security/announcements/cfd/2022/
[2]: ./0xd0-about-data.md
[3]: ./0x10-api-security-risks.md
[4]: ./0xd1-acknowledgments.md
