# API7:2019 Hatalı Güvenlik Yapılandırması

| Tehdit aktörleri / Saldırı vektörleri | Güvenlik Zayıflığı | Etkiler |
| - | - | - |
| API'ye Özgü : İstismar Edilebilirlik **3** | Yaygınlık **3** : Tespit Edilebilirlik **3** | Teknik **2** : Kuruluşa özgü |
| Saldırganlar genellikle yetkisiz erişim veya sistem hakkında bilgi elde etmek amacıyla yamalanmamış açıkları, yaygın uç noktaları veya korumasız dosya ve dizinleri bulmaya çalışır. | Hatalı güvenlik yapılandırması, ağ düzeyinden uygulama düzeyine kadar API yığınının herhangi bir katmanında ortaya çıkabilir. Gereksiz servisler veya eski seçenekler gibi hatalı yapılandırmaları tespit etmek ve istismar etmek için otomatik araçlar mevcuttur. | Hatalı güvenlik yapılandırmaları yalnızca hassas kullanıcı verilerini değil, sunucunun tamamen ele geçirilmesine yol açabilecek sistem detaylarını da açığa çıkarabilir. |

## API Bu Zafiyete Açık mı?

API aşağıdaki durumlarda zafiyete açık olabilir:

* Uygulama yığınının herhangi bir bölümünde uygun güvenlik
  sıkılaştırması eksikse veya bulut servislerinde yanlış
  yapılandırılmış izinler varsa.
* En son güvenlik yamaları eksikse veya sistemler güncel değilse.
* Gereksiz özellikler etkinse (örn. HTTP fiilleri).
* Aktarım Katmanı Güvenliği (TLS) eksikse.
* Güvenlik yönergeleri istemcilere gönderilmiyorsa (örn. [Güvenlik
  Başlıkları][1]).
* Kaynaklar Arası Kaynak Paylaşımı (CORS) politikası eksikse veya
  yanlış ayarlanmışsa.
* Hata mesajları yığın izlerini (stack trace) içeriyorsa veya başka
  hassas bilgiler açığa çıkıyorsa.

## Örnek Saldırı Senaryoları

### Senaryo #1

Bir saldırgan, sunucunun kök dizininde DevOps ekibinin API'ye erişmek
için kullandığı komutları içeren `.bash_history` dosyasını bulur:

```
$ curl -X GET 'https://api.server/endpoint/' -H 'authorization: Basic Zm9vOmJhcg=='
```

Saldırgan ayrıca, yalnızca DevOps ekibi tarafından kullanılan ve
dokümante edilmemiş yeni uç noktaları da API üzerinde bulabilir.

### Senaryo #2

Belirli bir servisi hedeflemek için bir saldırgan, İnternet üzerinden
doğrudan erişilebilen bilgisayarları aramak amacıyla popüler bir arama
motoru kullanır. Saldırgan, varsayılan portu dinleyen, popüler bir
veritabanı yönetim sistemi çalıştıran bir sunucu bulur. Sunucu,
varsayılan olarak kimlik doğrulamanın devre dışı olduğu varsayılan
yapılandırmayı kullanmaktadır; saldırgan da PII, kişisel tercihler ve
kimlik doğrulama verileri içeren milyonlarca kayda erişim sağlar.

### Senaryo #3

Bir mobil uygulamanın trafiğini inceleyen bir saldırgan, tüm HTTP
trafiğinin güvenli bir protokol (örn. TLS) üzerinden yürütülmediğini
fark eder. Saldırgan bunun özellikle profil resimlerinin indirilmesi
için geçerli olduğunu tespit eder. Kullanıcı etkileşimi ikili
(binary) olduğundan, API trafiği güvenli bir protokol üzerinden
yürütülse bile saldırgan, API yanıtlarının boyutunda bir örüntü
(pattern) bulur ve bunu kullanıcının görüntülenen içeriğe (örn. profil
resimlerine) yönelik tercihlerini takip etmek için kullanır.

## Nasıl Önlenir?

API yaşam döngüsü şunları içermelidir:

* Güvenliği sıkılaştırılmış bir ortamın hızlı ve kolay biçimde devreye
  alınmasını sağlayan, tekrarlanabilir bir sıkılaştırma süreci.
* API yığınının tamamındaki yapılandırmaları gözden geçirmek ve
  güncellemek için bir görev. Bu gözden geçirme; orkestrasyon
  dosyalarını, API bileşenlerini ve bulut servislerini (örn. S3 bucket
  izinleri) kapsamalıdır.
* Statik varlıklara (örn. görseller) erişim dâhil tüm API
  etkileşimleri için güvenli bir iletişim kanalı.
* Tüm ortamlarda yapılandırma ve ayarların etkinliğini sürekli olarak
  değerlendiren otomatik bir süreç.

Ayrıca:

* İstisna izlerinin ve diğer değerli bilgilerin saldırganlara geri
  gönderilmesini önlemek amacıyla, uygunsa hata yanıtları da dâhil
  olmak üzere tüm API yanıt gövdesi şemalarını tanımlayın ve
  uygulayın.
* API'ye yalnızca belirtilen HTTP fiilleriyle erişilebildiğinden emin
  olun. Diğer tüm HTTP fiilleri devre dışı bırakılmalıdır (örn.
  `HEAD`).
* Tarayıcı tabanlı istemcilerden (örn. web uygulaması ön yüzü)
  erişilmesi beklenen API'ler, uygun bir Kaynaklar Arası Kaynak
  Paylaşımı (CORS) politikası uygulamalıdır.

## Kaynaklar

### OWASP

* [OWASP Secure Headers Project][1]
* [OWASP Test Rehberi: Yapılandırma Yönetimi][2]
* [OWASP Test Rehberi: Hata Kodları için Test][3]
* [OWASP Test Rehberi: Cross-Origin Resource Sharing Testi][9]

### Harici Kaynaklar

* [CWE-2: Ortama Bağlı Güvenlik Açıkları][4]
* [CWE-16: Yapılandırma][5]
* [CWE-388: Hata Yönetimi][6]
* [Genel Sunucu Güvenliği Rehberi][7], NIST
* [Let's Encrypt: ücretsiz, otomatik ve açık bir Sertifika Otoritesi][8]

[1]: https://www.owasp.org/index.php/OWASP_Secure_Headers_Project
[2]: https://www.owasp.org/index.php/Testing_for_configuration_management
[3]: https://www.owasp.org/index.php/Testing_for_Error_Code_(OTG-ERR-001)
[4]: https://cwe.mitre.org/data/definitions/2.html
[5]: https://cwe.mitre.org/data/definitions/16.html
[6]: https://cwe.mitre.org/data/definitions/388.html
[7]: https://csrc.nist.gov/publications/detail/sp/800-123/final
[8]: https://letsencrypt.org/
[9]: https://www.owasp.org/index.php/Test_Cross_Origin_Resource_Sharing_(OTG-CLIENT-007)
