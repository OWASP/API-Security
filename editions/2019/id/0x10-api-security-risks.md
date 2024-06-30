# Risiko Keamanan API

[OWASP Risk Rating Methodology][1] digunakan untuk melakukan analisis risiko. 

Tabel di bawah ini merangkum terminologi yang terkait dengan skor risiko.

| Agen Ancaman | Dapat Dieksploitasi | Prevalensi Kelemahan | Dapat Dideteksi Kelemahan | Dampak Teknis | Dampak Bisnis |
| :-: | :-: | :-: | :-: | :-: | :-: |
| Khusus API | Mudah: **3** | Luas **3** | Mudah **3** | Parah **3** | Spesifik Bisnis |  
| Khusus API | Rata-rata: **2** | Umum **2** | Rata-rata **2** | Sedang **2** | Spesifik Bisnis |
| Khusus API | Sulit: **1** | Sulit **1** | Sulit **1** | Minor **1** | Spesifik Bisnis |

**Catatan**: Pendekatan ini tidak memperhitungkan kemungkinan agen ancaman. Juga tidak memperhitungkan berbagai detail teknis yang terkait dengan aplikasi tertentu Anda. Faktor-faktor apa pun dapat secara signifikan mempengaruhi kemungkinan keseluruhan penyerang menemukan dan mengeksploitasi kerentanan tertentu. Peringkat ini tidak memperhitungkan dampak aktual pada bisnis Anda. Organisasi Anda harus memutuskan seberapa banyak risiko keamanan dari aplikasi dan API yang akan diterima organisasi mengingat budaya, industri, dan lingkungan peraturan Anda. Tujuan OWASP API Security Top 10 bukan untuk melakukan analisis risiko ini untuk Anda.

## Referensi

### OWASP

* [OWASP Risk Rating Methodology][1]
* [Article on Threat/Risk Modeling][2]

### Eksternal

* [ISO 31000: Risk Management Std][3]
* [ISO 27001: ISMS][4]
* [NIST Cyber Framework (US)][5]
* [ASD Strategic Mitigations (AU)][6]
* [NIST CVSS 3.0][7]
* [Microsoft Threat Modeling Tool][8]

[1]: https://www.owasp.org/index.php/OWASP_Risk_Rating_Methodology
[2]: https://www.owasp.org/index.php/Threat_Risk_Modeling
[3]: https://www.iso.org/iso-31000-risk-management.html
[4]: https://www.iso.org/isoiec-27001-information-security.html
[5]: https://www.nist.gov/cyberframework
[6]: https://www.asd.gov.au/infosec/mitigationstrategies.htm
[7]: https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator
[8]: https://www.microsoft.com/en-us/download/details.aspx?id=49168
