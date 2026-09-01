# API6:2019 Toplu Atama

| Tehdit aktörleri / Saldırı vektörleri | Güvenlik Zayıflığı | Etkiler |
| - | - | - |
| API'ye Özgü : İstismar Edilebilirlik **2** | Yaygınlık **2** : Tespit Edilebilirlik **2** | Teknik **2** : Kuruluşa özgü |
| İstismar genellikle iş mantığının, nesneler arası ilişkilerin ve API yapısının anlaşılmasını gerektirir. Toplu atamanın istismarı API'lerde daha kolaydır; çünkü API'ler tasarımı gereği uygulamanın alttaki gerçekleştirimini, özellik adlarıyla birlikte dışarıya açar. | Modern framework'ler, geliştiricileri istemciden gelen girdiyi otomatik olarak kod değişkenlerine ve iç nesnelere bağlayan fonksiyonlar kullanmaya teşvik eder. Saldırganlar bu yöntemi kullanarak, geliştiricilerin hiçbir zaman dışarıya açmayı amaçlamadığı hassas nesne özelliklerini güncelleyebilir veya üzerine yazabilir. | İstismar; yetki yükseltmeye (privilege escalation), veri bütünlüğünün bozulmasına, güvenlik mekanizmalarının atlatılmasına ve daha fazlasına yol açabilir. |

## API Bu Zafiyete Açık mı?

Modern uygulamalardaki nesneler birçok özellik içerebilir. Bu
özelliklerin bir kısmı istemci tarafından doğrudan güncellenebilmelidir
(örn. `user.first_name` veya `user.address`), bir kısmı ise
güncellenememelidir (örn. `user.is_vip` bayrağı).

Bir API uç noktası, istemci parametrelerini bu özelliklerin
hassasiyetini ve açığa çıkma düzeyini göz önünde bulundurmadan otomatik
olarak iç nesne özelliklerine dönüştürüyorsa zafiyete açıktır. Bu durum,
bir saldırganın erişimi olmaması gereken nesne özelliklerini
güncellemesine olanak tanıyabilir.

Hassas özelliklere örnekler:

* **İzinle ilgili özellikler**: `user.is_admin`, `user.is_vip` yalnızca
  yöneticiler tarafından ayarlanmalıdır.
* **Sürece bağlı özellikler**: `user.cash` yalnızca ödeme doğrulaması
  sonrasında sistem tarafından ayarlanmalıdır.
* **İç özellikler**: `article.created_time` yalnızca uygulama
  tarafından sistem içinde ayarlanmalıdır.

## Örnek Saldırı Senaryoları

### Senaryo #1

Bir araç paylaşım uygulaması, kullanıcıya profilinin temel bilgilerini
düzenleme seçeneği sunar. Bu süreçte, aşağıdaki meşru JSON nesnesiyle
`PUT /api/v1/users/me` adresine bir API çağrısı gönderilir:

```json
{"user_name":"inons","age":24}
```

`GET /api/v1/users/me` isteği ise ek olarak bir `credit_balance`
özelliği içerir:

```json
{"user_name":"inons","age":24,"credit_balance":10}
```

Saldırgan, ilk isteği aşağıdaki veri yüküyle tekrar gönderir:

```json
{"user_name":"attacker","age":60,"credit_balance":99999}
```

Uç nokta toplu atamaya karşı savunmasız olduğundan, saldırgan ödeme
yapmadan kredi kazanır.

### Senaryo #2

Bir video paylaşım platformu, kullanıcıların içerik yüklemesine ve
farklı formatlarda içerik indirmesine olanak tanır. API'yi inceleyen
bir saldırgan, `GET /api/v1/videos/{video_id}/meta_data` uç noktasının,
videonun özelliklerini içeren bir JSON nesnesi döndürdüğünü keşfeder.
Bu özelliklerden biri olan `"mp4_conversion_params":"-v codec h264"`,
uygulamanın videoyu dönüştürmek için bir shell komutu kullandığını
göstermektedir.

Saldırgan ayrıca `POST /api/v1/videos/new` uç noktasının toplu atamaya
karşı savunmasız olduğunu ve istemcinin video nesnesinin herhangi bir
özelliğini ayarlamasına izin verdiğini keşfeder. Saldırgan şu kötü
amaçlı değeri ayarlar: `"mp4_conversion_params":"-v codec h264 && format C:/"`.
Bu değer, saldırgan videoyu MP4 olarak indirdiğinde bir shell komut
enjeksiyonuna yol açar.

## Nasıl Önlenir?

* Mümkünse, istemcinin girdisini otomatik olarak kod değişkenlerine
  veya iç nesnelere bağlayan fonksiyonları kullanmaktan kaçının.
* Yalnızca istemci tarafından güncellenmesi gereken özellikleri izin
  verilenler listesine (whitelist) ekleyin.
* İstemcilerin erişmemesi gereken özellikleri engellenenler listesine
  (blacklist) eklemek için yerleşik özellikleri kullanın.
* Uygunsa, girdi veri yükleri için şemaları açıkça tanımlayın ve
  zorunlu kılın.

## Kaynaklar

### Harici Kaynaklar

* [CWE-915: Dinamik Olarak Belirlenen Nesne Özniteliklerinin Uygunsuz
  Biçimde Denetlenen Değişikliği][1]

[1]: https://cwe.mitre.org/data/definitions/915.html
