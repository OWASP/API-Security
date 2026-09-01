# API1:2019 Nesne Düzeyinde Yetkilendirme Eksikliği

| Tehdit aktörleri / Saldırı vektörleri | Güvenlik Zayıflığı | Etkiler |
| - | - | - |
| API'ye Özgü : İstismar Edilebilirlik **3** | Yaygınlık **3** : Tespit Edilebilirlik **2** | Teknik **3** : Kuruluşa özgü |
| Saldırganlar, istekte gönderilen bir nesnenin ID'sini değiştirerek nesne düzeyinde yetkilendirmeye karşı savunmasız API uç noktalarını istismar edebilir. Bu durum, hassas verilere yetkisiz erişime yol açabilir. Bu sorun API tabanlı uygulamalarda son derece yaygındır çünkü sunucu bileşeni genellikle istemcinin durumunu tam olarak takip etmez; bunun yerine, hangi nesnelere erişileceğine karar vermek için istemciden gönderilen nesne ID'leri gibi parametrelere daha çok güvenir. | Bu, API'lere yönelik en yaygın ve en etkili saldırı türü olmuştur. Modern uygulamalardaki yetkilendirme ve erişim kontrolü mekanizmaları karmaşık ve yaygındır. Uygulama, yetkilendirme kontrolleri için uygun bir altyapı uygulasa bile geliştiriciler, hassas bir nesneye erişmeden önce bu kontrolleri kullanmayı unutabilir. Erişim kontrolü eksikliklerinin tespiti, genellikle otomatik statik veya dinamik testlere uygun değildir. | Yetkisiz erişim; verilerin yetkisiz taraflara açıklanmasına, kaybolmasına veya değiştirilmesine yol açabilir. Nesnelere yetkisiz erişim, bir hesabın tamamen ele geçirilmesiyle de sonuçlanabilir. |

## API Bu Zafiyete Açık mı?

Nesne düzeyinde yetkilendirme, bir kullanıcının yalnızca erişim izni olması
gereken nesnelere erişebildiğini doğrulamak amacıyla genellikle kod
düzeyinde uygulanan bir erişim kontrolü mekanizmasıdır.

Bir nesnenin ID'sini alan ve bu nesne üzerinde herhangi bir işlem
gerçekleştiren her API uç noktası, nesne düzeyinde yetkilendirme kontrolleri
uygulamalıdır. Bu kontroller, oturum açmış kullanıcının istenen nesne
üzerinde talep edilen işlemi gerçekleştirme yetkisine sahip olduğunu
doğrulamalıdır.

Bu mekanizmadaki eksiklikler genellikle tüm verilerin yetkisiz biçimde
açıklanmasına, değiştirilmesine veya yok edilmesine yol açar.

## Örnek Saldırı Senaryoları

### Senaryo #1

Çevrimiçi mağazalara hizmet veren bir e-ticaret platformu, barındırdığı
mağazaların gelir grafiklerini gösteren bir listeleme sayfası sunar.
Tarayıcı isteklerini inceleyen bir saldırgan, bu grafiklerin veri kaynağı
olarak kullanılan API uç noktalarını ve bunların
`/shops/{shopName}/revenue_data.json` kalıbını tespit edebilir. Saldırgan,
başka bir API uç noktasını kullanarak barındırılan tüm mağazaların adlarının
listesini elde edebilir. Listedeki adları kullanarak URL'deki `{shopName}`
değerini değiştiren basit bir betikle saldırgan, binlerce e-ticaret
mağazasının satış verilerine erişim sağlar.

### Senaryo #2

Giyilebilir bir cihazın ağ trafiği izlenirken, bir saldırganın dikkatini bir
HTTP `PATCH` isteği çeker; çünkü istekte özel bir `X-User-Id: 54796` başlığı
yer almaktadır. Saldırgan, `X-User-Id` değerini `54795` ile değiştirdiğinde
başarılı bir HTTP yanıtı alır ve böylece başka kullanıcıların hesap
verilerini değiştirebilir.

## Nasıl Önlenir?

* Kullanıcı politikalarına ve hiyerarşisine dayanan uygun bir yetkilendirme
  mekanizması uygulayın.
* İstemciden alınan bir girdiyle veritabanındaki bir kayda erişen her
  fonksiyonda, oturum açmış kullanıcının istenen işlemi söz konusu kayıt
  üzerinde gerçekleştirme yetkisine sahip olup olmadığını kontrol eden bir
  yetkilendirme mekanizması kullanın.
* Kayıtların ID'leri için rastgele ve tahmin edilmesi zor değerler olan
  GUID'leri tercih edin.
* Yetkilendirme mekanizmasındaki zafiyetleri tespit edecek testler yazın.
  Bu testlerin başarısız olmasına neden olan değişiklikleri canlı ortama
  dağıtmayın.

## Kaynaklar

### Harici Kaynaklar

* [CWE-284: Hatalı Erişim Kontrolü][1]
* [CWE-285: Hatalı Yetkilendirme][2]
* [CWE-639: Kullanıcı Tarafından Denetlenen Anahtar Aracılığıyla
  Yetkilendirmeyi Aşma][3]

[1]: https://cwe.mitre.org/data/definitions/284.html
[2]: https://cwe.mitre.org/data/definitions/285.html
[3]: https://cwe.mitre.org/data/definitions/639.html
