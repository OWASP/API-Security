# API1:2023 Nesne Düzeyinde Yetkilendirme Eksikliği

| Tehdit aktörleri / Saldırı vektörleri                                                                                                                                                                                                                                                                                                                                                                                                | Güvenlik Zayıflığı                                                                                                                                                                                                                                                                                                                                            | Etkiler                                                                                                                                                                                                                                                |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| API'ye Özgü · İstismar edilebilirlik: **Kolay**                                                                                                                                                                                                                                                                                                                                                                                      | Yaygınlık: **Çok yaygın** · Tespit edilebilirlik: **Kolay**                                                                                                                                                                                                                                                                                                   | Teknik etki: **Orta** · İş etkisi: **Kuruluşa özgü**                                                                                                                                                                                                   |
| Saldırganlar, istekte gönderilen bir nesnenin ID'sini değiştirerek nesne düzeyinde yetkilendirme kontrolleri yetersiz olan API uç noktalarını istismar edebilir. Nesne ID'leri; sıralı tam sayılar, UUID'ler veya herhangi bir karakter dizisi olabilir. Veri türünden bağımsız olarak bu ID'ler; istek hedefinde (yol veya sorgu dizesi parametrelerinde), istek başlıklarında ya da istek gövdesinde kolaylıkla tespit edilebilir. | Bu sorun API tabanlı uygulamalarda son derece yaygındır. Bunun nedeni, sunucu bileşeninin genellikle istemcinin durumunu tam olarak takip etmemesi ve erişilecek nesneleri belirlemek için istemciden gönderilen nesne ID'leri gibi parametrelere güvenmesidir. Sunucunun verdiği yanıt, isteğin başarılı olup olmadığını anlamak için çoğu zaman yeterlidir. | Başka kullanıcılara ait nesnelere yetkisiz erişim; verilerin yetkisiz kişilere açıklanmasına, kaybolmasına veya değiştirilmesine yol açabilir. Belirli koşullarda nesnelere yetkisiz erişim, bir hesabın tamamen ele geçirilmesiyle de sonuçlanabilir. |

## API Bu Zafiyete Açık mı?

Nesne düzeyinde yetkilendirme, bir kullanıcının yalnızca erişim iznine sahip olduğu nesnelere erişebilmesini sağlamak amacıyla genellikle kod düzeyinde uygulanan bir erişim kontrolü mekanizmasıdır.

Bir nesnenin ID'sini alan ve bu nesne üzerinde herhangi bir işlem gerçekleştiren her API uç noktası, nesne düzeyinde yetkilendirme kontrolleri uygulamalıdır. Bu kontroller, oturum açmış kullanıcının istenen nesne üzerinde talep edilen işlemi gerçekleştirme yetkisine sahip olduğunu doğrulamalıdır.

Bu mekanizmadaki eksiklikler genellikle verilerin yetkisiz biçimde açıklanmasına, değiştirilmesine veya silinmesine yol açar.

Mevcut oturumdaki kullanıcı ID'sini, örneğin JWT'den çıkararak, istemciden gelen ID parametresiyle karşılaştırmak; Nesne Düzeyinde Yetkilendirme Eksikliği (BOLA) sorununu çözmek için yeterli değildir. Bu yaklaşım yalnızca sınırlı sayıdaki senaryoyu kapsayabilir.

BOLA durumunda kullanıcının ilgili API uç noktasına veya fonksiyona erişebilmesi tasarım gereğidir. Yetkilendirme ihlali, ID'nin değiştirilmesiyle nesne düzeyinde gerçekleşir. Saldırgan, erişim yetkisi bulunmayan bir API uç noktasına veya fonksiyona erişebiliyorsa bu durum BOLA değil, [Fonksiyon Düzeyinde Yetkilendirme Eksikliği][5] (BFLA) olarak değerlendirilir.

## Örnek Saldırı Senaryoları

### Senaryo 1

Çevrimiçi mağazalara hizmet veren bir e-ticaret platformu, barındırdığı mağazaların gelir grafiklerini gösteren bir listeleme sayfası sunar. Tarayıcı isteklerini inceleyen bir saldırgan, bu grafiklerin veri kaynağı olarak kullanılan API uç noktasını ve URL yapısını tespit edebilir:

`/shops/{shopName}/revenue_data.json`

Saldırgan, başka bir API uç noktasını kullanarak platformda barındırılan tüm mağazaların adlarını elde edebilir. Ardından basit bir betikle URL'deki `{shopName}` değerini listedeki mağaza adlarıyla değiştirerek binlerce e-ticaret mağazasının satış verilerine erişebilir.

### Senaryo 2

Bir otomobil üreticisi, sürücünün cep telefonuyla iletişim kuran bir mobil API aracılığıyla araçların uzaktan kontrol edilmesini sağlar. API; sürücünün motoru uzaktan çalıştırıp durdurmasına, kapıları kilitlemesine ve kilidini açmasına olanak tanır.

Bu işlem sırasında kullanıcı, Araç Kimlik Numarasını (VIN) API'ye gönderir. API, gönderilen VIN'in oturum açmış kullanıcıya ait bir aracı temsil edip etmediğini doğrulamazsa BOLA zafiyeti ortaya çıkar. Böylece bir saldırgan, kendisine ait olmayan araçlara erişebilir.

### Senaryo 3

Çevrimiçi bir belge depolama hizmeti, kullanıcıların belgelerini görüntülemesine, düzenlemesine, saklamasına ve silmesine olanak tanır. Bir belge silindiğinde, belge ID'sini içeren bir GraphQL mutation isteği API'ye gönderilir.

```http
POST /graphql
{
  "operationName":"deleteReports",
  "variables":{
    "reportKeys":["<DOCUMENT_ID>"]
  },
  "query":"mutation deleteReports($siteId: ID!, $reportKeys: [String]!) {
    {
      deleteReports(reportKeys: $reportKeys)
    }
  }"
}
```

## Nasıl Önlenir?

- Kullanıcı politikalarını, rollerini ve yetki hiyerarşisini temel alan uygun bir yetkilendirme mekanizması uygulayın.
- İstemciden alınan bir değerle veritabanındaki bir kayda erişen her fonksiyonda, oturum açmış kullanıcının istenen işlemi söz konusu kayıt üzerinde gerçekleştirme yetkisine sahip olduğunu yetkilendirme mekanizmasıyla doğrulayın.
- Kayıt ID'leri için GUID gibi rastgele ve tahmin edilmesi zor değerleri tercih edin. Ancak bu değerlerin tek başına bir yetkilendirme kontrolü olmadığını unutmayın.
- Yetkilendirme mekanizmasındaki zafiyetleri tespit edecek testler yazın. Bu testlerin başarısız olmasına neden olan değişiklikleri canlı ortama dağıtmayın.

**Not**

* Tahmin edilebilir tanımlayıcılar yerine GUID'ler/UUID'ler kullanmak, nesne numaralandırma (object enumeration) saldırılarının etkisini azaltmaya yardımcı olur. Ancak geçerli bir tanımlayıcı başka bir uç nokta (endpoint), aşırı veri ifşası (excessive data exposure), loglama veya başka bir güvenlik açığı nedeniyle açığa çıktığında artık herkese açık (kamuya açık) bir bilgi olarak kabul edilmelidir.

* Yetkilendirme kararları asla nesne tanımlayıcılarının gizliliğine veya tahmin edilemezliğine dayanmamalıdır. Her istek, kimliği doğrulanmış kullanıcının talep edilen nesneye erişim yetkisi olduğunu bağımsız olarak doğrulamalıdır.

## Kaynaklar

### OWASP

- [Yetkilendirme Hızlı Başvuru Rehberi][1]
- [Yetkilendirme Testlerinin Otomasyonu Hızlı Başvuru Rehberi][2]

### Harici Kaynaklar

- [CWE-285: Hatalı Yetkilendirme][3]
- [CWE-639: Kullanıcı Tarafından Denetlenen Anahtar Aracılığıyla Yetkilendirmeyi Aşma][4]

[1]: https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html
[2]: https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Testing_Automation_Cheat_Sheet.html
[3]: https://cwe.mitre.org/data/definitions/285.html
[4]: https://cwe.mitre.org/data/definitions/639.html
[5]: ./0xa5-broken-function-level-authorization.md
