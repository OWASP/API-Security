# API2:2019 Kullanıcı Kimlik Doğrulama Eksikliği

| Tehdit aktörleri / Saldırı vektörleri | Güvenlik Zayıflığı | Etkiler |
| - | - | - |
| API'ye Özgü : İstismar Edilebilirlik **3** | Yaygınlık **2** : Tespit Edilebilirlik **2** | Teknik **3** : Kuruluşa özgü |
| API'lerde kimlik doğrulama karmaşık ve kafa karıştırıcı bir mekanizmadır. Yazılım ve güvenlik mühendisleri, kimlik doğrulamanın sınırlarının ne olduğu ve nasıl doğru uygulanacağı konusunda yanlış varsayımlara sahip olabilir. Ayrıca kimlik doğrulama mekanizması herkese açık olduğu için saldırganlar açısından kolay bir hedeftir. Bu iki unsur, kimlik doğrulama bileşenini birçok istismara potansiyel olarak açık hâle getirir. | İki alt sorun vardır: 1. Koruma mekanizmalarının eksikliği: kimlik doğrulamadan sorumlu API uç noktaları normal uç noktalardan farklı ele alınmalı ve ek koruma katmanları uygulamalıdır. 2. Mekanizmanın hatalı uygulanması: mekanizma, saldırı vektörleri göz önünde bulundurulmadan kullanılır/uygulanır ya da yanlış kullanım senaryosuna sahiptir (örn. IoT istemcileri için tasarlanmış bir kimlik doğrulama mekanizması, web uygulamaları için doğru seçim olmayabilir). | Saldırganlar, sistemdeki diğer kullanıcıların hesaplarının kontrolünü ele geçirebilir, kişisel verilerini okuyabilir ve para transferi ya da kişisel mesaj gönderme gibi hassas işlemleri onlar adına gerçekleştirebilir. |

## API Bu Zafiyete Açık mı?

Kimlik doğrulama uç noktaları ve akışları korunması gereken varlıklardır.
"Şifremi unuttum / şifre sıfırlama" işlevi de kimlik doğrulama
mekanizmalarıyla aynı şekilde ele alınmalıdır.

Bir API aşağıdaki durumlarda zafiyete açıktır:

* Saldırganın geçerli kullanıcı adı ve şifre listesine sahip olduğu
  [kimlik bilgisi doldurma (credential stuffing)][1] saldırılarına izin
  veriyorsa.
* Captcha/hesap kilitleme mekanizması sunmadan aynı kullanıcı hesabına
  yönelik kaba kuvvet saldırılarına izin veriyorsa.
* Zayıf şifrelere izin veriyorsa.
* Kimlik doğrulama belirteçleri ve şifreler gibi hassas kimlik doğrulama
  bilgilerini URL üzerinden gönderiyorsa.
* Belirteçlerin özgünlüğünü doğrulamıyorsa.
* İmzasız veya zayıf imzalanmış JWT belirteçlerini (`"alg":"none"`) kabul
  ediyorsa/son kullanma tarihlerini doğrulamıyorsa.
* Düz metin, şifrelenmemiş veya zayıf biçimde hash'lenmiş şifreler
  kullanıyorsa.
* Zayıf şifreleme anahtarları kullanıyorsa.

## Örnek Saldırı Senaryoları

### Senaryo #1

[Kimlik bilgisi doldurma][1] ([bilinen kullanıcı adı/şifre listeleri][2]
kullanılarak) yaygın bir saldırı türüdür. Bir uygulama otomatik tehdit
tespiti veya kimlik bilgisi doldurma koruması uygulamıyorsa, uygulama;
kimlik bilgilerinin geçerli olup olmadığını belirlemek için bir şifre
kâhini (oracle) olarak kullanılabilir.

### Senaryo #2

Bir saldırgan, `/api/system/verification-codes` adresine bir POST isteği
gönderip istek gövdesinde kullanıcı adını belirterek şifre kurtarma
sürecini başlatır. Ardından kurbanın telefonuna 6 haneli bir SMS belirteci
gönderilir. API bir istek sınırlandırma politikası uygulamadığından,
saldırgan `/api/system/verification-codes/{smsToken}` uç noktasına karşı
çok iş parçacıklı (multi-threaded) bir betikle tüm olası kombinasyonları
deneyerek doğru belirteci birkaç dakika içinde bulabilir.

## Nasıl Önlenir?

* API'ye kimlik doğrulamanın tüm olası akışlarını bildiğinizden emin olun
  (mobil/web/tek tıkla kimlik doğrulama uygulayan derin bağlantılar vb.).
* Mühendislerinize hangi akışları gözden kaçırdığınızı sorun.
* Kimlik doğrulama mekanizmalarınız hakkında bilgi edinin. Bunların ne
  olduğunu ve nasıl kullanıldığını anladığınızdan emin olun. OAuth bir
  kimlik doğrulama yöntemi değildir; API anahtarları da değildir.
* Kimlik doğrulama, belirteç üretimi veya şifre saklama konusunda
  tekerleği yeniden icat etmeyin. Standartları kullanın.
* Kimlik bilgisi kurtarma/şifremi unuttum uç noktaları; kaba kuvvet, istek
  sınırlandırma ve kilitleme korumaları açısından giriş uç noktalarıyla
  aynı şekilde ele alınmalıdır.
* [OWASP Kimlik Doğrulama Hızlı Başvuru Rehberi'ni][3] kullanın.
* Mümkün olduğunda çok faktörlü kimlik doğrulama uygulayın.
* Kimlik doğrulama uç noktalarınıza yönelik kimlik bilgisi doldurma,
  sözlük saldırıları ve kaba kuvvet saldırılarını azaltmak için kaba
  kuvvet karşıtı mekanizmalar uygulayın. Bu mekanizma, API'nizdeki olağan
  istek sınırlandırma mekanizmasından daha sıkı olmalıdır.
* Belirli kullanıcılara yönelik kaba kuvvet saldırılarını önlemek için
  [hesap kilitleme][4]/captcha mekanizması uygulayın. Zayıf şifre
  kontrolleri uygulayın.
* API anahtarları kullanıcı kimlik doğrulaması için değil, [istemci
  uygulaması/proje kimlik doğrulaması][5] için kullanılmalıdır.

## Kaynaklar

### OWASP

* [OWASP Anahtar Yönetimi Hızlı Başvuru Rehberi][6]
* [OWASP Kimlik Doğrulama Hızlı Başvuru Rehberi][3]
* [Kimlik Bilgisi Doldurma (Credential Stuffing)][1]

### Harici Kaynaklar

* [CWE-798: Sabit Kodlanmış Kimlik Bilgilerinin Kullanımı][7]

[1]: https://www.owasp.org/index.php/Credential_stuffing
[2]: https://github.com/danielmiessler/SecLists
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
[4]: https://www.owasp.org/index.php/Testing_for_Weak_lock_out_mechanism_(OTG-AUTHN-003)
[5]: https://cloud.google.com/endpoints/docs/openapi/when-why-api-key
[6]: https://www.owasp.org/index.php/Key_Management_Cheat_Sheet
[7]: https://cwe.mitre.org/data/definitions/798.html
