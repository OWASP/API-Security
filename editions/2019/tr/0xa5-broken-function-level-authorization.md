# API5:2019 Fonksiyon Düzeyinde Yetkilendirme Eksikliği

| Tehdit aktörleri / Saldırı vektörleri | Güvenlik Zayıflığı | Etkiler |
| - | - | - |
| API'ye Özgü : İstismar Edilebilirlik **3** | Yaygınlık **2** : Tespit Edilebilirlik **1** | Teknik **2** : Kuruluşa özgü |
| İstismar için saldırganın, erişim yetkisi olmaması gereken bir API uç noktasına meşru API çağrıları göndermesi yeterlidir. Bu uç noktalar anonim kullanıcılara veya ayrıcalıksız normal kullanıcılara açık olabilir. API'ler daha yapılandırılmış olduğundan ve belirli fonksiyonlara erişim yöntemi daha öngörülebilir olduğundan (örn. HTTP yöntemini `GET`'ten `PUT`'a değiştirmek veya URL'deki "users" ifadesini "admins" ile değiştirmek), bu tür açıkları API'lerde tespit etmek daha kolaydır. | Bir fonksiyon veya kaynak için yetkilendirme kontrolleri genellikle yapılandırma üzerinden, bazen de kod düzeyinde yönetilir. Modern uygulamalar birçok rol veya grup türü ve karmaşık kullanıcı hiyerarşisi (örn. alt kullanıcılar, birden fazla role sahip kullanıcılar) içerebildiğinden, uygun kontrollerin uygulanması kafa karıştırıcı bir görev olabilir. | Bu tür açıklar, saldırganların yetkisiz işlevlere erişmesine olanak tanır. Yönetimsel fonksiyonlar bu tür saldırılar için başlıca hedeflerdir. |

## API Bu Zafiyete Açık mı?

Fonksiyon düzeyinde yetkilendirme eksikliği sorunlarını bulmanın en iyi
yolu, uygulamadaki kullanıcı hiyerarşisini, farklı rolleri veya grupları
göz önünde bulundurarak yetkilendirme mekanizmasının derinlemesine
analizini yapmak ve şu soruları sormaktır:

* Normal bir kullanıcı yönetimsel uç noktalara erişebiliyor mu?
* Bir kullanıcı, yalnızca HTTP yöntemini değiştirerek (örn. `GET`'ten
  `DELETE`'e) erişim yetkisi olmaması gereken hassas işlemleri (örn.
  oluşturma, değiştirme veya silme) gerçekleştirebiliyor mu?
* X grubundaki bir kullanıcı, yalnızca uç nokta URL'sini ve
  parametrelerini tahmin ederek (örn. `/api/v1/users/export_all`)
  yalnızca Y grubundaki kullanıcılara açık olması gereken bir fonksiyona
  erişebiliyor mu?

Bir API uç noktasının yalnızca URL yoluna bakarak normal mi yoksa
yönetimsel mi olduğunu varsaymayın.

Geliştiriciler yönetimsel uç noktaların çoğunu `api/admins` gibi belirli
bir göreli yol altında açığa çıkarmayı tercih etse de, bu yönetimsel uç
noktaların `api/users` gibi normal uç noktalarla birlikte başka göreli
yollar altında bulunması da oldukça yaygındır.

## Örnek Saldırı Senaryoları

### Senaryo #1

Yalnızca davet edilen kullanıcıların katılabildiği bir uygulamanın kayıt
süreci sırasında, mobil uygulama `GET /api/invites/{invite_guid}` şeklinde
bir API çağrısı tetikler. Yanıt, davetin ayrıntılarını, kullanıcının
rolünü ve kullanıcının e-postasını içeren bir JSON içerir.

Bir saldırgan isteği kopyalar ve HTTP yöntemi ile uç noktayı `POST
/api/invites/new` olarak değiştirir. Bu uç noktaya yalnızca yöneticiler
tarafından yönetici konsolu üzerinden erişilmelidir; ancak uç nokta
fonksiyon düzeyinde yetkilendirme kontrolleri uygulamamaktadır.

Saldırgan bu açığı istismar ederek kendisine yönetici hesabı oluşturacak
bir davet gönderir:

```
POST /api/invites/new

{"email":"hugo@malicious.com","role":"admin"}
```

### Senaryo #2

Bir API, yalnızca yöneticilere açık olması gereken bir uç nokta içerir:
`GET /api/admin/v1/users/all`. Bu uç nokta, uygulamanın tüm
kullanıcılarının bilgilerini döndürür ve fonksiyon düzeyinde
yetkilendirme kontrolleri uygulamaz. API yapısını öğrenen bir saldırgan,
bilinçli bir tahminde bulunarak bu uç noktaya erişmeyi başarır ve bu da
uygulama kullanıcılarının hassas bilgilerinin ifşa olmasına yol açar.

## Nasıl Önlenir?

Uygulamanız, tüm iş fonksiyonlarınızdan çağrılan tutarlı ve analiz
edilmesi kolay bir yetkilendirme modülüne sahip olmalıdır. Bu tür bir
koruma çoğunlukla, uygulama kodunun dışındaki bir veya daha fazla bileşen
tarafından sağlanır.

* Uygulama mekanizması(ları), varsayılan olarak tüm erişimi reddetmeli ve
  her fonksiyona erişim için belirli rollere açık izin verilmesini
  gerektirmelidir.
* Uygulamanın iş mantığını ve grup hiyerarşisini göz önünde bulundurarak
  API uç noktalarınızı fonksiyon düzeyinde yetkilendirme açıkları
  açısından gözden geçirin.
* Tüm yönetimsel denetleyicilerinizin, kullanıcının grubuna/rolüne dayalı
  yetkilendirme kontrolleri uygulayan soyut bir yönetimsel
  denetleyiciden türediğinden emin olun.
* Normal bir denetleyici içindeki yönetimsel fonksiyonların, kullanıcının
  grubuna ve rolüne dayalı yetkilendirme kontrolleri uyguladığından emin
  olun.

## Kaynaklar

### OWASP

* [Forced Browsing Hakkında OWASP Makalesi][1]
* [OWASP Top 10 2013-A7-Eksik Fonksiyon Düzeyinde Erişim Kontrolü][2]
* [OWASP Geliştirme Rehberi: Yetkilendirme Bölümü][3]

### Harici Kaynaklar

* [CWE-285: Hatalı Yetkilendirme][4]

[1]: https://www.owasp.org/index.php/Forced_browsing
[2]: https://www.owasp.org/index.php/Top_10_2013-A7-Missing_Function_Level_Access_Control
[3]: https://www.owasp.org/index.php/Category:Access_Control
[4]: https://cwe.mitre.org/data/definitions/285.html
