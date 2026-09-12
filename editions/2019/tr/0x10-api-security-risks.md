# API Güvenliği Riskleri

Risk analizi yapılırken [OWASP Risk Değerlendirme Metodolojisi][1] kullanılmıştır.

Aşağıdaki tabloda risk skoruyla ilişkili terminoloji özetlenmiştir.

| Tehdit Aktörleri | İstismar Edilebilirlik | Zayıflığın Yaygınlığı | Zayıflığın Tespit Edilebilirliği | Teknik Etki | İş Etkileri |
| :-: | :-: | :-: | :-: | :-: | :-: |
| API'ye Özgü | Kolay: **3** | Çok yaygın **3** | Kolay **3** | Ciddi **3** | Kuruluşa özgü |
| API'ye Özgü | Orta: **2** | Yaygın **2** | Orta **2** | Orta **2** | Kuruluşa özgü |
| API'ye Özgü | Zor: **1** | Nadir **1** | Zor **1** | Düşük **1** | Kuruluşa özgü |

**Not**: Bu yaklaşım, tehdit aktörünün saldırıyı gerçekleştirme olasılığını
dikkate almaz. Ayrıca uygulamanıza özgü teknik ayrıntıları da hesaba katmaz.
Bu unsurlardan herhangi biri, bir saldırganın belirli bir zafiyeti bulma ve
istismar etme olasılığını önemli ölçüde etkileyebilir. Bu derecelendirme,
kuruluşunuzun maruz kalacağı gerçek iş etkisini de değerlendirmez.
Kuruluşunuz; kurum kültürü, faaliyet gösterdiği sektör ve tabi olduğu
düzenleyici ortamı göz önünde bulundurarak uygulamalardan ve API'lerden
kaynaklanan güvenlik risklerinin ne kadarını kabul edebileceğine kendisi
karar vermelidir. OWASP API Security Top 10'un amacı, bu risk analizini
kuruluşunuz adına yapmak değildir.

## Kaynaklar

### OWASP

* [OWASP Risk Değerlendirme Metodolojisi][1]
* [Tehdit/Risk Modellemesi Hakkında Makale][2]

### Harici Kaynaklar

* [ISO 31000: Risk Yönetimi Standardı][3]
* [ISO 27001: BGYS][4]
* [NIST Siber Güvenlik Çerçevesi (ABD)][5]
* [ASD Stratejik Azaltım Önlemleri (AU)][6]
* [NIST CVSS 3.0][7]
* [Microsoft Tehdit Modelleme Aracı][8]

[1]: https://www.owasp.org/index.php/OWASP_Risk_Rating_Methodology
[2]: https://www.owasp.org/index.php/Threat_Risk_Modeling
[3]: https://www.iso.org/iso-31000-risk-management.html
[4]: https://www.iso.org/isoiec-27001-information-security.html
[5]: https://www.nist.gov/cyberframework
[6]: https://www.asd.gov.au/infosec/mitigationstrategies.htm
[7]: https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator
[8]: https://www.microsoft.com/en-us/download/details.aspx?id=49168
