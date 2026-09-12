# Geliştiricileri Neler Bekliyor?

Güvenli uygulamalar oluşturmak ve bunların güvenliğini sürdürmek ya da
mevcut uygulamaları düzeltme görevi zor olabilir. API'ler için de durum
farklı değildir.

Eğitim ve farkındalığın, güvenli yazılım yazmanın temel unsurları
olduğuna inanıyoruz. Bu hedefi gerçekleştirmek için gereken her şey,
**tekrarlanabilir güvenlik süreçlerinin ve standart güvenlik
kontrollerinin oluşturulmasına ve kullanılmasına** bağlıdır.

OWASP, güvenliği ele almanıza yardımcı olacak çok sayıda ücretsiz ve
açık kaynak sunar. Mevcut projelerin kapsamlı bir listesi için lütfen
[OWASP Projeler sayfasını][1] ziyaret edin.

| | |
|-|-|
| **Eğitim** | Mesleğinize ve ilgi alanınıza göre [OWASP Eğitim Projesi materyallerini][2] okumaya başlayabilirsiniz. Uygulamalı öğrenme için **crAPI** - **C**ompletely **R**idiculous **API**'yi [yol haritamıza][3] ekledik. Bu arada, kullanıcılara modern web uygulamalarını ve API'leri güvenlik açıkları için nasıl test edeceklerini ve gelecekte daha güvenli API'ler nasıl yazacaklarını öğretmeyi amaçlayan zafiyetli bir WebApp ve API servisi olan [OWASP DevSlop Pixi Module][4] ile WebAppSec pratiği yapabilirsiniz. Ayrıca [OWASP AppSec Conference][5] eğitim oturumlarına katılabilir veya [yerel topluluğunuza katılabilirsiniz][6]. |
| **Güvenlik Gereksinimleri** | Güvenlik, en başından itibaren her projenin bir parçası olmalıdır. Gereksinimleri tanımlarken, o proje için "güvenli"nin ne anlama geldiğini tanımlamak önemlidir. OWASP, güvenlik gereksinimlerini belirlemek için bir rehber olarak [OWASP Application Security Verification Standard (ASVS)][7] kullanmanızı önerir. Dış kaynak kullanıyorsanız, yerel yasa ve düzenlemelere göre uyarlanması gereken [OWASP Secure Software Contract Annex][8]'i göz önünde bulundurun. |
| **Güvenlik Mimarisi** | Güvenlik, tüm proje aşamalarında bir öncelik olarak kalmalıdır. [OWASP Prevention Cheat Sheets][9], mimari aşamada güvenliği tasarlama konusunda rehberlik için iyi bir başlangıç noktasıdır. Diğerlerinin yanı sıra, [REST Security Cheat Sheet][10] ve [REST Assessment Cheat Sheet][11]'i orada bulacaksınız. |
| **Standart Güvenlik Kontrolleri** | Standart güvenlik kontrollerini benimsemek, kendi mantığınızı yazarken güvenlik zayıflıkları oluşturma riskini azaltır. Birçok modern çerçeve artık etkili yerleşik standart kontrollerle geliyor olsa da, [OWASP Proactive Controls][12] projenize hangi güvenlik kontrollerini dâhil etmeniz gerektiği konusunda size iyi bir genel bakış sunar. OWASP ayrıca doğrulama kontrolleri gibi değerli bulabileceğiniz bazı kütüphaneler ve araçlar sağlar. |
| **Güvenli Yazılım Geliştirme Yaşam Döngüsü** | API'ler oluştururken süreci geliştirmek için [OWASP Software Assurance Maturity Model (SAMM)][13] kullanabilirsiniz. Farklı API geliştirme aşamalarında size yardımcı olacak, örneğin [OWASP Code Review Project][14] gibi, başka birçok OWASP projesi de mevcuttur. |

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
