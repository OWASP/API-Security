# API7:2023 Sunucu Taraflı İstek Sahteciliği

| Tehdit aktörleri / Saldırı vektörleri | Güvenlik Zayıflığı | Etkiler |
| - | - | - |
| API'ye Özgü · İstismar edilebilirlik: **Kolay** | Yaygınlık: **Yaygın** · Tespit edilebilirlik: **Kolay** | Teknik etki: **Orta** · İş etkisi: **Kuruluşa özgü** |
| İstismar için saldırganın, istemci tarafından sağlanan bir URI'ye erişen bir API uç noktası bulması gerekir. Genel olarak, yanıtın saldırgana döndürüldüğü temel SSRF, saldırganın saldırının başarılı olup olmadığına dair geri bildirim alamadığı Kör (Blind) SSRF'den istismar etmesi daha kolaydır. | Uygulama geliştirmedeki modern yaklaşımlar, geliştiricileri istemci tarafından sağlanan URI'lere erişmeye teşvik eder. Bu tür URI'lerin doğrulanmaması veya yetersiz doğrulanması yaygın bir sorundur. Sorunu tespit etmek için düzenli API istek ve yanıt analizi gerekir. Yanıt döndürülmediğinde (Kör SSRF) zafiyeti tespit etmek daha fazla çaba ve yaratıcılık gerektirir. | Başarılı bir istismar; dahili servislerin keşfedilmesine (örn. port taraması), bilgi ifşasına, güvenlik duvarlarının veya diğer güvenlik mekanizmalarının aşılmasına yol açabilir. Bazı durumlarda DoS'a veya sunucunun kötü amaçlı etkinlikleri gizlemek için proxy olarak kullanılmasına yol açabilir. |

## API Bu Zafiyete Açık mı?

Sunucu Taraflı İstek Sahteciliği (SSRF) kusurları, bir API'nin
kullanıcı tarafından sağlanan URL'yi doğrulamadan uzak bir kaynağa
erişmesi durumunda ortaya çıkar. Bu durum, bir güvenlik duvarı veya
VPN tarafından korunuyor olsa dahi, saldırganın uygulamayı beklenmedik
bir hedefe özel olarak hazırlanmış bir istek göndermeye zorlamasına
olanak tanır.

Uygulama geliştirmedeki modern yaklaşımlar SSRF'yi daha yaygın ve daha
tehlikeli hâle getirir.

Daha yaygın: Webhook'lar, URL'lerden dosyalara erişme, özel SSO ve URL
önizlemeleri gibi yaklaşımlar, geliştiricileri kullanıcı girdisine dayalı
olarak harici kaynaklara erişmeye yöneltir.

Daha tehlikeli: Bulut sağlayıcılar, Kubernetes ve Docker gibi modern
teknolojiler, yönetim ve kontrol kanallarını HTTP üzerinden öngörülebilir,
iyi bilinen yollarda açığa çıkarır. Bu kanallar, SSRF saldırısı için
kolay bir hedeftir.

Modern uygulamaların bağlantılı doğası nedeniyle, uygulamanızdan
giden trafiği sınırlamak da daha zordur.

SSRF riski her zaman tamamen ortadan kaldırılamaz. Bir koruma
mekanizması seçerken, iş risklerini ve ihtiyaçlarını göz önünde
bulundurmak önemlidir.

## Örnek Saldırı Senaryoları

### Senaryo 1

Bir sosyal ağ, kullanıcıların profil resmi yüklemesine izin verir.
Kullanıcı, resim dosyasını kendi cihazından yüklemeyi veya resmin
URL'sini sağlamayı seçebilir. İkincisini seçmek şu API çağrısını
tetikler:

```
POST /api/profile/upload_picture

{
  "picture_url": "http://example.com/profile_pic.jpg"
}
```

Bir saldırgan, kötü amaçlı bir URL göndererek API uç noktasını
kullanarak iç ağda port taraması başlatabilir.

```
{
  "picture_url": "localhost:8080"
}
```

Yanıt süresine dayanarak, saldırgan portun açık olup olmadığını
anlayabilir.

### Senaryo 2

Bir güvenlik ürünü, ağda anomali tespit ettiğinde olaylar üretir. Bazı
ekipler, olayları SIEM (Security Information and Event Management) gibi
daha geniş, daha genel bir izleme sisteminde incelemeyi tercih eder. Bu
amaçla ürün, webhook'lar kullanarak diğer sistemlerle entegrasyon
sağlar.

Yeni bir webhook oluşturma sürecinin bir parçası olarak, SIEM API'sinin
URL'sini içeren bir GraphQL mutation'ı gönderilir.

```
POST /graphql

[
  {
    "variables": {},
    "query": "mutation {
      createNotificationChannel(input: {
        channelName: \"ch_piney\",
        notificationChannelConfig: {
          customWebhookChannelConfigs: [
            {
              url: \"http://www.siem-system.com/create_new_event\",
              send_test_req: true
            }
          ]
    	  }
  	  }){
    	channelId
  	}
	}"
  }
]

```

Oluşturma süreci sırasında, API arka ucu sağlanan webhook URL'sine bir
test isteği gönderir ve yanıtı kullanıcıya sunar.

Bir saldırgan bu akıştan yararlanarak, API'nin kimlik bilgilerini
ifşa eden dahili bir bulut meta veri servisi gibi hassas bir kaynağa
istek göndermesini sağlayabilir:

```
POST /graphql

[
  {
    "variables": {},
    "query": "mutation {
      createNotificationChannel(input: {
        channelName: \"ch_piney\",
        notificationChannelConfig: {
          customWebhookChannelConfigs: [
            {
              url: \"http://169.254.169.254/latest/meta-data/iam/security-credentials/ec2-default-ssm\",
              send_test_req: true
            }
          ]
        }
      }) {
        channelId
      }
    }
  }
]
```

Uygulama, test isteğinin yanıtını gösterdiği için saldırgan, bulut
ortamının kimlik bilgilerini görebilir.

## Nasıl Önlenir?

* Kaynaklara erişen mekanizmayı ağınızda izole edin: Bu tür özellikler
  genellikle dahili kaynaklara değil, uzak kaynaklara erişmek için kullanılır.
* Mümkün olduğunda şunlar için izin listeleri (allow list) kullanın:
    * Kullanıcıların kaynak indirmesi beklenen uzak kaynaklar (örn.
      Google Drive, Gravatar vb.)
    * URL şemaları ve portları
    * Belirli bir işlevsellik için kabul edilen medya türleri
* HTTP yönlendirmelerini devre dışı bırakın.
* URL ayrıştırma tutarsızlıklarından kaynaklanan sorunları önlemek
  için iyi test edilmiş ve bakımı yapılan bir URL ayrıştırıcı
  kullanın.
* İstemci tarafından sağlanan tüm girdi verilerini doğrulayın ve
  temizleyin (sanitize).
* İstemcilere ham yanıtlar göndermeyin.

## Kaynaklar

### OWASP

* [Server Side Request Forgery][1]
* [Sunucu Taraflı İstek Sahteciliğini Önleme Hızlı Başvuru Rehberi][2]

### Harici Kaynaklar

* [CWE-918: Sunucu Taraflı İstek Sahteciliği (SSRF)][3]
* [URL confusion vulnerabilities in the wild: Exploring parser inconsistencies,
   Snyk][4]

[1]: https://owasp.org/www-community/attacks/Server_Side_Request_Forgery
[2]: https://cheatsheetseries.owasp.org/cheatsheets/Server_Side_Request_Forgery_Prevention_Cheat_Sheet.html
[3]: https://cwe.mitre.org/data/definitions/918.html
[4]: https://snyk.io/blog/url-confusion-vulnerabilities/
