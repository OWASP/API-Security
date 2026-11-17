# API2:2023 Kimlik Doğrulama Eksikliği

| Tehdit aktörleri / Saldırı vektörleri | Güvenlik Zayıflığı | Etkiler |
| - | - | - |
| API'ye Özgü · İstismar edilebilirlik: **Kolay** | Yaygınlık: **Yaygın** · Tespit edilebilirlik: **Kolay** | Teknik etki: **Ciddi** · İş etkisi: **Kuruluşa özgü** |
| Kimlik doğrulama mekanizması, herkese açık olduğu için saldırganlar açısından kolay bir hedeftir. Bazı kimlik doğrulama açıklarını istismar etmek daha ileri düzey teknik beceriler gerektirse de, istismar araçları genellikle mevcuttur. | Yazılım ve güvenlik mühendislerinin kimlik doğrulama sınırlarına ilişkin yanlış varsayımları ve doğal uygulama karmaşıklığı, kimlik doğrulama sorunlarını yaygın hâle getirir. Kimlik doğrulama eksikliğini tespit etmeye yönelik yöntemler mevcuttur ve kolayca oluşturulabilir. | Saldırganlar, sistemdeki diğer kullanıcıların hesaplarının tam kontrolünü ele geçirebilir, kişisel verilerini okuyabilir ve onlar adına hassas işlemler gerçekleştirebilir. Sistemlerin, saldırganların eylemlerini meşru kullanıcı eylemlerinden ayırt edebilmesi pek olası değildir. |

## API Bu Zafiyete Açık mı?

Kimlik doğrulama uç noktaları ve akışları korunması gereken varlıklardır.
Ayrıca "Şifremi unuttum / şifre sıfırlama" işlevi de kimlik doğrulama
mekanizmalarıyla aynı şekilde ele alınmalıdır.

Bir API aşağıdaki durumlarda zafiyete açıktır:

* Saldırganın geçerli kullanıcı adı ve şifre listesiyle kaba kuvvet
  uyguladığı kimlik bilgisi doldurma (credential stuffing) saldırılarına
  izin veriyorsa.
* Captcha/hesap kilitleme mekanizması sunmadan aynı kullanıcı hesabına
  yönelik kaba kuvvet saldırılarına izin veriyorsa.
* Zayıf şifrelere izin veriyorsa.
* Kimlik doğrulama belirteçleri ve şifreler gibi hassas kimlik doğrulama
  bilgilerini URL üzerinden gönderiyorsa.
* Kullanıcıların e-posta adreslerini, mevcut şifrelerini veya diğer hassas
  işlemlerini şifre onayı istemeden değiştirmesine izin veriyorsa.
* Belirteçlerin (token) özgünlüğünü doğrulamıyorsa.
* İmzasız veya zayıf imzalanmış JWT belirteçlerini (`{"alg":"none"}`) kabul
  ediyorsa.
* JWT'nin son kullanma tarihini doğrulamıyorsa.
* Düz metin, şifrelenmemiş veya zayıf biçimde hash'lenmiş şifreler
  kullanıyorsa.
* Zayıf şifreleme anahtarları kullanıyorsa.

Bunlara ek olarak, bir mikroservis aşağıdaki durumlarda zafiyete açıktır:

* Diğer mikroservisler kimlik doğrulama yapmadan ona erişebiliyorsa
* Kimlik doğrulamayı uygulamak için zayıf veya tahmin edilebilir
  belirteçler kullanıyorsa

## Örnek Saldırı Senaryoları

### Senaryo 1

Kullanıcı kimlik doğrulamasını gerçekleştirmek için istemcinin, kullanıcı
kimlik bilgileriyle aşağıdaki gibi bir API isteği göndermesi gerekir:

```
POST /graphql
{
  "query":"mutation {
    login (username:\"<username>\",password:\"<password>\") {
      token
    }
   }"
}
```

Kimlik bilgileri geçerliyse, kullanıcıyı tanımlamak için sonraki isteklerde
kullanılması gereken bir kimlik doğrulama belirteci döndürülür. Giriş
denemeleri sıkı bir istek sınırlandırmasına tabidir: dakikada yalnızca üç isteğe
izin verilir.

Kötü niyetli kişiler, kurbanın hesabına kaba kuvvetle giriş yapmak için
istek sınırlandırmasını aşmak ve saldırıyı hızlandırmak amacıyla GraphQL
sorgu toplu işlemesinden (query batching) yararlanır:

```
POST /graphql
[
  {"query":"mutation{login(username:\"victim\",password:\"password\"){token}}"},
  {"query":"mutation{login(username:\"victim\",password:\"123456\"){token}}"},
  {"query":"mutation{login(username:\"victim\",password:\"qwerty\"){token}}"},
  ...
  {"query":"mutation{login(username:\"victim\",password:\"123\"){token}}"},
]
```

### Senaryo 2

Bir kullanıcının hesabıyla ilişkili e-posta adresini güncellemek için
istemcilerin aşağıdaki gibi bir API isteği göndermesi gerekir:

```
PUT /account
Authorization: Bearer <token>

{ "email": "<new_email_address>" }
```

API, kullanıcılardan mevcut şifrelerini girerek kimliklerini doğrulamalarını
istemediği için, kimlik doğrulama belirtecini çalabilecek konuma gelen kötü
niyetli kişiler; kurbanın hesabının e-posta adresini güncelledikten sonra
şifre sıfırlama akışını başlatarak hesabı ele geçirebilir.

## Nasıl Önlenir?

* API'ye kimlik doğrulaması yapmak için olası tüm akışları bildiğinizden emin olun
  (mobil/web/tek tıkla kimlik doğrulama uygulayan derin bağlantılar vb.).
  Mühendislerinize hangi akışları gözden kaçırdığınızı sorun.
* Kimlik doğrulama mekanizmalarınız hakkında bilgi edinin. Bunların ne
  olduğunu ve nasıl kullanıldığını anladığınızdan emin olun. OAuth bir
  kimlik doğrulama yöntemi değildir; API anahtarları da değildir.
* Kimlik doğrulama, belirteç üretimi veya şifre saklama konusunda
  tekerleği yeniden icat etmeyin. Standartları kullanın.
* Kimlik bilgisi kurtarma/şifremi unuttum uç noktaları; kaba kuvvet, istek
  sınırlandırma ve kilitleme korumaları açısından giriş uç noktalarıyla aynı
  şekilde ele alınmalıdır.
* Hassas işlemler için (örn. hesap sahibi e-posta adresini/2FA telefon
  numarasını değiştirme) yeniden kimlik doğrulama isteyin.
* [OWASP Kimlik Doğrulama Hızlı Başvuru Rehberi'ni][1] kullanın.
* Mümkün olduğunda çok faktörlü kimlik doğrulama uygulayın.
* Kimlik doğrulama uç noktalarınıza yönelik kimlik bilgisi doldurma,
  sözlük saldırıları ve kaba kuvvet saldırılarını azaltmak için kaba
  kuvvet karşıtı mekanizmalar uygulayın. Bu mekanizma, API'lerinizdeki
  olağan istek sınırlandırma mekanizmalarından daha sıkı olmalıdır.
* Belirli kullanıcılara yönelik kaba kuvvet saldırılarını önlemek için
  [hesap kilitleme][2]/captcha mekanizmaları uygulayın. Zayıf şifre
  kontrolleri uygulayın.
* API anahtarları kullanıcı kimlik doğrulaması için kullanılmamalıdır.
  Yalnızca [API istemcilerinin][3] yetkilendirilmesi için
  kullanılmalıdır.

## Kaynaklar

### OWASP

* [Kimlik Doğrulama Hızlı Başvuru Rehberi][1]
* [Anahtar Yönetimi Hızlı Başvuru Rehberi][4]
* [Kimlik Bilgisi Doldurma (Credential Stuffing)][5]

### Harici Kaynaklar

* [CWE-204: Gözlemlenebilir Yanıt Tutarsızlığı][6]
* [CWE-307: Aşırı Kimlik Doğrulama Denemelerinin Yetersiz Kısıtlanması][7]

[1]: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
[2]: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/04-Authentication_Testing/03-Testing_for_Weak_Lock_Out_Mechanism(OTG-AUTHN-003)
[3]: https://cloud.google.com/endpoints/docs/openapi/when-why-api-key
[4]: https://cheatsheetseries.owasp.org/cheatsheets/Key_Management_Cheat_Sheet.html
[5]: https://owasp.org/www-community/attacks/Credential_stuffing
[6]: https://cwe.mitre.org/data/definitions/204.html
[7]: https://cwe.mitre.org/data/definitions/307.html
