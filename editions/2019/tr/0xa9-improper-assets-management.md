# API9:2019 Hatalı Varlık Yönetimi

| Tehdit aktörleri / Saldırı vektörleri | Güvenlik Zayıflığı | Etkiler |
| - | - | - |
| API'ye Özgü : İstismar Edilebilirlik **3** | Yaygınlık **3** : Tespit Edilebilirlik **2** | Teknik **2** : Kuruluşa özgü |
| Eski API sürümleri genellikle yamalanmamıştır ve en güncel API sürümlerini korumak için devreye alınmış olabilecek son teknoloji güvenlik mekanizmalarıyla uğraşmadan sistemleri ele geçirmenin kolay bir yoludur. | Güncel olmayan dokümantasyon, zafiyetlerin bulunmasını ve/veya düzeltilmesini zorlaştırır. Varlık envanterinin ve emeklilik stratejilerinin eksikliği, yamalanmamış sistemlerin çalışmaya devam etmesine ve hassas verilerin sızmasına yol açar. Uygulamaları kolayca dağıtılabilir ve bağımsız hâle getiren mikroservisler gibi modern yaklaşımlar nedeniyle, gereksiz yere açığa çıkmış API sunucularına sıkça rastlanır (örn. bulut bilişim, k8s). | Saldırganlar, aynı veritabanına bağlı eski ve yamalanmamış API sürümleri üzerinden hassas verilere erişim elde edebilir, hatta sunucuyu ele geçirebilir. |

## API Bu Zafiyete Açık mı?

API aşağıdaki durumlarda zafiyete açık olabilir:

* Bir API sunucusunun amacı belirsizse ve aşağıdaki sorulara açık
  yanıtlar yoksa:
    * API hangi ortamda çalışıyor (örn. üretim, staging, test,
      geliştirme)?
    * API'ye ağ erişimine kimler sahip olmalı (örn. herkese açık,
      dahili, iş ortakları)?
    * Hangi API sürümü çalışıyor?
    * API tarafından hangi veri toplanıyor ve işleniyor (örn. PII)?
    * Veri akışı nasıl gerçekleşiyor?
* Dokümantasyon yoksa veya mevcut dokümantasyon güncellenmiyorsa.
* Her API sürümü için bir emeklilik planı yoksa.
* Sunucu envanteri eksik veya güncel değilse.
* Birinci veya üçüncü taraf entegre servislerin envanteri eksik veya
  güncel değilse.
* Eski veya önceki API sürümleri yamalanmamış biçimde çalışıyorsa.

## Örnek Saldırı Senaryoları

### Senaryo #1

Uygulamalarını yeniden tasarladıktan sonra, yerel bir arama servisi
eski bir API sürümünü (`api.someservice.com/v1`) korumasız biçimde ve
kullanıcı veritabanına erişimi açık olarak çalışır durumda bırakır. En
son yayımlanan uygulamalardan birini hedef alan bir saldırgan, API
adresini (`api.someservice.com/v2`) bulur. URL'deki `v2` ifadesini `v1`
ile değiştiren saldırgan, eski ve korumasız API'ye erişim sağlar; bu da
100 milyondan fazla kullanıcının kişisel olarak tanımlanabilir
bilgilerinin (PII) ifşa olmasına yol açar.

### Senaryo #2

Bir sosyal ağ, saldırganların şifre sıfırlama belirteçlerini tahmin
etmek için kaba kuvvet kullanmasını engelleyen bir istek sınırlandırma
mekanizması uygulamıştır. Bu mekanizma, API kodunun kendisinin bir
parçası olarak değil, istemci ile resmi API (`www.socialnetwork.com`)
arasındaki ayrı bir bileşende uygulanmıştır. Bir araştırmacı, şifre
sıfırlama mekanizması dâhil aynı API'yi çalıştıran ancak istek
sınırlandırma mekanizması bulunmayan bir beta API sunucusu
(`www.mbasic.beta.socialnetwork.com`) bulur. Araştırmacı, 6 haneli
belirteci tahmin etmek için basit bir kaba kuvvet saldırısı kullanarak
herhangi bir kullanıcının şifresini sıfırlayabilir.

## Nasıl Önlenir?

* Tüm API sunucularının envanterini çıkarın ve her birinin önemli
  yönlerini belgeleyin; API ortamına (örn. üretim, staging, test,
  geliştirme), sunucuya ağ erişimine kimlerin sahip olması gerektiğine
  (örn. herkese açık, dahili, iş ortakları) ve API sürümüne odaklanın.
* Entegre servislerin envanterini çıkarın ve sistemdeki rolleri, hangi
  verilerin değiş tokuş edildiği (veri akışı) ve hassasiyetleri gibi
  önemli yönleri belgeleyin.
* Kimlik doğrulama, hatalar, yönlendirmeler, istek sınırlandırma,
  kaynaklar arası kaynak paylaşımı (CORS) politikası ve uç noktalar
  dâhil olmak üzere API'nizin tüm yönlerini; parametreleri, istekleri
  ve yanıtlarıyla birlikte belgeleyin.
* Açık standartları benimseyerek dokümantasyonu otomatik olarak
  oluşturun. Dokümantasyon oluşturmayı CI/CD ardışık düzeninize dâhil
  edin.
* API dokümantasyonunu yalnızca API'yi kullanmaya yetkili olanlara
  açık hâle getirin.
* Yalnızca mevcut üretim sürümü için değil, API'lerinizin açığa çıkmış
  tüm sürümleri için API güvenlik duvarları gibi harici koruma
  önlemleri kullanın.
* Üretim dışı API dağıtımlarında üretim verisi kullanmaktan kaçının.
  Bu kaçınılmazsa, bu uç noktalar üretim uç noktalarıyla aynı güvenlik
  muamelesini görmelidir.
* API'lerin daha yeni sürümleri güvenlik iyileştirmeleri içerdiğinde,
  eski sürüm için gereken risk azaltma eylemlerine karar vermek üzere
  bir risk analizi yapın: örneğin, iyileştirmelerin API uyumluluğunu
  bozmadan geriye taşınıp taşınamayacağını veya eski sürümü hızla
  devre dışı bırakıp tüm istemcileri en son sürüme geçmeye zorlamanız
  gerekip gerekmediğini değerlendirin.

## Kaynaklar

### Harici Kaynaklar

* [CWE-1059: Eksik Dokümantasyon][1]
* [OpenAPI Initiative][2]

[1]: https://cwe.mitre.org/data/definitions/1059.html
[2]: https://www.openapis.org/
