# Metodoloji ve Veriler

## Genel Bakış

AppSec sektörü, API'lerin önemli bir rol oynadığı uygulamaların en
güncel mimarisine henüz özel olarak odaklanmadığından, herkese açık
bir veri çağrısına dayanarak en kritik 10 API güvenliği riskinin
listesini oluşturmak zor bir görev olurdu. Herkese açık bir veri
çağrısı yapılmamış olsa da, ortaya çıkan Top 10 listesi yine de
herkese açık verilere, güvenlik uzmanlarının katkılarına ve güvenlik
topluluğuyla yapılan açık tartışmalara dayanmaktadır.

## Metodoloji

İlk aşamada, API güvenliği olaylarına ilişkin herkese açık veriler bir
güvenlik uzmanları grubu tarafından toplandı, incelendi ve kategorize
edildi. Bu veriler, bug bounty platformlarından ve zafiyet veri
tabanlarından, bir yıllık bir zaman dilimi içinde toplandı ve
istatistiksel amaçlarla kullanıldı.

Sonraki aşamada, sızma testi deneyimine sahip güvenlik uzmanlarından
kendi Top 10 listelerini oluşturmaları istendi.

Risk analizini gerçekleştirmek için [OWASP Risk Değerlendirme
Metodolojisi][1] kullanıldı. Skorlar, güvenlik uzmanları arasında
tartışıldı ve gözden geçirildi. Bu konulardaki değerlendirmeler için
lütfen [API Güvenliği Riskleri][2] bölümüne bakın.

OWASP API Security Top 10 2019'un ilk taslağı, birinci aşamadaki
istatistiksel sonuçlar ile güvenlik uzmanlarının listeleri arasındaki
fikir birliğinden ortaya çıktı. Bu taslak, ardından API güvenliği
alanında ilgili deneyime sahip başka bir güvenlik uzmanları grubu
tarafından değerlendirilmek ve gözden geçirilmek üzere paylaşıldı.

OWASP API Security Top 10 2019, ilk kez OWASP Global AppSec Tel Aviv
etkinliğinde (Mayıs 2019) sunuldu. O zamandan bu yana, herkese açık
tartışma ve katkılar için GitHub üzerinde erişilebilir durumdadır.

Katkıda bulunanların listesi [Teşekkürler][3] bölümünde mevcuttur.

[1]: https://www.owasp.org/index.php/OWASP_Risk_Rating_Methodology
[2]: ./0x10-api-security-risks.md
[3]: ./0xd1-acknowledgments.md
