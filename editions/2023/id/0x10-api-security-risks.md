# Risiko Keamanan API

[Metodologi Pemeringkatan Risiko OWASP][1] digunakan untuk melakukan analisis risiko.

Tabel berikut merangkum istilah yang diasosiasikan dengan nilai risiko.

| Agen Ancaman | Eksploitasi | Prevalensi Kelemahan | Deteksi Kelemahan | Dampak Teknikal | Dampak Bisnis |
| :-: | :-: | :-: | :-: | :-: | :-: |
| Spesifik API | Mudah : **3** | Tersebar luas **3** | Mudah **3** | Severe **3** | Spesifik Bisnis |
| Spesifik API | Menengah: **2** | Umum **2** | Menengah **2** | Sedang **2** | Spesifik Bisnis |
| Spesifik API | Sukar: **1** | Sukar **1** | Sukar **1** | Minor **1** | Spesifik Bisnis |

**Catatan**: Pendekatan ini tidak mempertimbangkan kemungkinan agen ancaman, dan juga tidak mempertimbangkan berbagai rincian teknikal yang terkait dengan aplikasi anda. Semua faktor ini dapat secara signifikan mempengaruhi kemungkinan penyerang menemukan dan mengeksploitasi kerentanan tertentu. Pemeringkatan ini tidak mempertimbangkan dampak aktual terhadap bisnis anda. Organisasi anda perlu menentukan tingkat risiko keamanan aplikasi dan API yang dapat diterima berdasarkan budaya, industri, dan lingkungan regulasi anda.  OWASP API Security Top
10 tidak bertujuan melakukan risiko analisis ini untuk anda. Oleh karena edisi ini bukan berdasarkan data, namun berdasarkan konsensus umum di antara anggota tim.

## Referensi

### OWASP

* [Metodologi Pemeringkatan Risiko OWASP][1]
* [Artikel tentang Pemodelan Ancaman/Risiko][2]

### Eksternal

* [ISO 31000: Risk Management Std][3]
* [ISO 27001: ISMS][4]
* [NIST Cyber Framework (US)][5]
* [ASD Strategic Mitigations (AU)][6]
* [NIST CVSS 3.0][7]
* [Microsoft Threat Modeling Tool][8]

[1]: https://owasp.org/www-project-risk-assessment-framework/
[2]: https://owasp.org/www-community/Threat_Modeling
[3]: https://www.iso.org/iso-31000-risk-management.html
[4]: https://www.iso.org/isoiec-27001-information-security.html
[5]: https://www.nist.gov/cyberframework
[6]: https://www.asd.gov.au/infosec/mitigationstrategies.htm
[7]: https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator
[8]: https://www.microsoft.com/en-us/download/details.aspx?id=49168
