# API3:2019 Aşırı Veri İfşası

| Tehdit aktörleri / Saldırı vektörleri | Güvenlik Zayıflığı | Etkiler |
| - | - | - |
| API'ye Özgü : İstismar Edilebilirlik **3** | Yaygınlık **2** : Tespit Edilebilirlik **2** | Teknik **2** : Kuruluşa özgü |
| Aşırı Veri İfşasının istismarı basittir; genellikle trafiği dinleyip API yanıtlarını analiz ederek kullanıcıya döndürülmemesi gereken hassas veri ifşalarını aramak yoluyla gerçekleştirilir. | API'ler, veri filtrelemeyi istemcilerin yapmasına güvenir. API'ler veri kaynağı olarak kullanıldığından, geliştiriciler bazen dışarıya açılan verinin hassasiyetini düşünmeden onları genel (generic) bir biçimde uygulamaya çalışır. Otomatik araçlar genellikle bu tür bir zafiyeti tespit edemez; çünkü API'den dönen meşru veriyle döndürülmemesi gereken hassas veriyi ayırt etmek, uygulamanın derinlemesine anlaşılmasını gerektirir. | Aşırı Veri İfşası genellikle hassas verilerin ifşa olmasına yol açar. |

## API Bu Zafiyete Açık mı?

API, tasarımı gereği istemciye hassas veri döndürür. Bu veri genellikle
kullanıcıya sunulmadan önce istemci tarafında filtrelenir. Bir saldırgan,
trafiği kolayca dinleyerek bu hassas veriyi görebilir.

## Örnek Saldırı Senaryoları

### Senaryo #1

Mobil ekip, yorum meta verilerini görüntülemek için makaleler görünümünde
`/api/articles/{articleId}/comments/{commentId}` uç noktasını kullanır.
Mobil uygulama trafiğini dinleyen bir saldırgan, yorumun yazarına ait başka
hassas verilerin de döndürüldüğünü keşfeder. Uç nokta, nesneyi
serileştirmek için PII içeren `User` modeli üzerinde genel bir `toJSON()`
metodu kullanmaktadır.

### Senaryo #2

IoT tabanlı bir gözetim sistemi, yöneticilerin farklı izinlere sahip
kullanıcılar oluşturmasına olanak tanır. Bir yönetici, sahadaki yalnızca
belirli binalara erişimi olması gereken yeni bir güvenlik görevlisi için
bir kullanıcı hesabı oluşturur. Güvenlik görevlisi mobil uygulamasını
kullandığında, mevcut kameralar hakkında veri almak ve bunları panoda
göstermek için `/api/sites/111/cameras` adresine bir API çağrısı
tetiklenir. Yanıt, kameralar hakkındaki ayrıntıları şu formatta içeren bir
liste döndürür: `{"id":"xxx","live_access_token":"xxxx-bbbbb","building_id":"yyy"}`.
İstemci arayüzü yalnızca güvenlik görevlisinin erişimi olması gereken
kameraları gösterirken, gerçek API yanıtı sahadaki tüm kameraların tam
listesini içerir.

## Nasıl Önlenir?

* Hassas veriyi filtrelemek için asla istemci tarafına güvenmeyin.
* API'den dönen yanıtları, yalnızca meşru veri içerdiklerinden emin olmak
  için gözden geçirin.
* Backend mühendisleri, yeni bir API uç noktasını dışarıya açmadan önce
  her zaman "verinin tüketicisi kim?" diye sormalıdır.
* `to_json()` ve `to_string()` gibi genel metotları kullanmaktan kaçının.
  Bunun yerine, gerçekten döndürmek istediğiniz belirli özellikleri tek
  tek seçin.
* Uygulamanızın sakladığı ve işlediği hassas ve kişisel olarak
  tanımlanabilir bilgileri (PII) sınıflandırın; bu tür bilgileri döndüren
  tüm API çağrılarını, bir güvenlik sorunu oluşturup oluşturmadığını
  görmek için gözden geçirin.
* Ek bir güvenlik katmanı olarak şemaya dayalı bir yanıt doğrulama
  mekanizması uygulayın. Bu mekanizmanın bir parçası olarak, hatalar dâhil
  tüm API metotlarının döndürdüğü veriyi tanımlayın ve zorunlu kılın.

## Kaynaklar

### Harici Kaynaklar

* [CWE-213: Kasıtlı Bilgi İfşası][1]

[1]: https://cwe.mitre.org/data/definitions/213.html
