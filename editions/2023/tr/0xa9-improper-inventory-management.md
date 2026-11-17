# API9:2023 Yetersiz Envanter Yönetimi

| Tehdit aktörleri / Saldırı vektörleri | Güvenlik Zayıflığı | Etkiler |
| - | - | - |
| API'ye Özgü · İstismar edilebilirlik: **Kolay** | Yaygınlık: **Çok yaygın** · Tespit edilebilirlik: **Orta** | Teknik etki: **Orta** · İş etkisi: **Kuruluşa özgü** |
| Tehdit aktörleri genellikle yamalanmamış ve daha zayıf güvenlik gereksinimleriyle çalışmaya devam eden eski API sürümleri veya uç noktaları aracılığıyla yetkisiz erişim elde eder. Bazı durumlarda istismar araçları mevcuttur. Alternatif olarak, verilerin paylaşılması için hiçbir gerekçe olmayan bir üçüncü taraf aracılığıyla hassas verilere erişim elde edebilirler. | Güncel olmayan dokümantasyon, zafiyetlerin bulunmasını ve/veya düzeltilmesini zorlaştırır. Varlık envanteri ve emeklilik stratejilerinin eksikliği, yamalanmamış sistemlerin çalışmaya devam etmesine ve hassas verilerin sızmasına yol açar. Mikroservisler gibi modern yaklaşımlar uygulamaları kolayca dağıtılabilir ve bağımsız hâle getirdiğinden (örn. bulut bilişim, K8S), gereksiz yere açığa çıkmış API sunucularına sıkça rastlanır. İnternete bağlı çeşitli sunucu türleri (web kameraları, yönlendiriciler, sunucular vb.) için basit Google Dorking, DNS kayıtlarının keşfi veya özel arama motorları kullanmak, hedefleri bulmak için yeterli olacaktır. | Saldırganlar hassas verilere erişim elde edebilir, hatta sunucuyu ele geçirebilir. Bazen farklı API sürümleri/dağıtımları gerçek verilerle aynı veritabanına bağlıdır. Tehdit aktörleri, yönetimsel fonksiyonlara erişmek veya bilinen zafiyetleri istismar etmek için eski API sürümlerinde bulunan kullanımdan kaldırılmış uç noktaları istismar edebilir. |

## API Bu Zafiyete Açık mı?

API'lerin ve modern uygulamaların yayılmış ve birbirine bağlı yapısı yeni
zorluklar getirir. Kuruluşların yalnızca kendi API'leri ve API uç
noktaları hakkında değil, aynı zamanda API'lerin harici üçüncü
taraflarla verileri nasıl depoladığı veya paylaştığı konusunda da iyi
bir anlayışa ve görünürlüğe sahip olması önemlidir.

Bir API'nin birden fazla sürümünü çalıştırmak, API sağlayıcısından ek
yönetim kaynağı gerektirir ve saldırı yüzeyini genişletir.

Aşağıdaki durumlarda bir API'de "<ins>dokümantasyon kör noktası</ins>"
vardır:

* Bir API sunucusunun amacı belirsizse ve aşağıdaki sorulara açık
  yanıtlar yoksa
    * API hangi ortamda çalışıyor (örn. üretim, staging, test,
      geliştirme)?
    * API'ye ağ erişimine kimler sahip olmalı (örn. herkese açık,
      dahili, iş ortakları)?
    * Hangi API sürümü çalışıyor?
* Dokümantasyon yoksa veya mevcut dokümantasyon güncellenmiyorsa.
* Her API sürümü için bir emeklilik planı yoksa.
* Sunucu envanteri eksik veya güncel değilse.

Üçüncü taraf tarafında bir ihlal yaşanması durumunda, hassas veri
akışlarının görünürlüğü ve envanteri, olay müdahale planının önemli bir
parçası olarak rol oynar.

Aşağıdaki durumlarda bir API'de "<ins>veri akışı kör noktası</ins>"
vardır:

* API'nin hassas verileri üçüncü bir tarafla paylaştığı bir "hassas
  veri akışı" varsa ve
    * Akış için bir iş gerekçesi veya onayı yoksa
    * Akışın envanteri veya görünürlüğü yoksa
    * Ne tür hassas verilerin paylaşıldığına dair derin bir
      görünürlük yoksa

## Örnek Saldırı Senaryoları

### Senaryo 1

Bir sosyal ağ, saldırganların şifre sıfırlama belirteçlerini tahmin
etmek için kaba kuvvet kullanmasını engelleyen bir istek sınırlandırma
mekanizması uygulamıştır. Bu mekanizma, API kodunun kendisinin bir
parçası olarak değil, istemci ile resmi API (`api.socialnetwork.owasp.org`)
arasındaki ayrı bir bileşende uygulanmıştır. Bir araştırmacı, şifre
sıfırlama mekanizması dâhil aynı API'yi çalıştıran ancak istek sınırlandırma
mekanizması bulunmayan bir beta API sunucusu
(`beta.api.socialnetwork.owasp.org`) buldu. Araştırmacı, 6 haneli
belirteci tahmin etmek için basit kaba kuvvet kullanarak herhangi bir
kullanıcının şifresini sıfırlayabildi.

### Senaryo 2

Bir sosyal ağ, bağımsız uygulama geliştiricilerinin kendisiyle entegre
olmasına izin verir. Bu sürecin bir parçası olarak, sosyal ağın
kullanıcının kişisel bilgilerini bağımsız uygulamayla paylaşabilmesi
için son kullanıcıdan onay istenir.

Sosyal ağ ile bağımsız uygulamalar arasındaki veri akışı yeterince
kısıtlayıcı veya izlenen bir yapıda değildir; bu da bağımsız
uygulamaların yalnızca kullanıcı bilgilerine değil, aynı zamanda
kullanıcının tüm arkadaşlarının özel bilgilerine de erişmesine olanak
tanır.

Bir danışmanlık firması kötü amaçlı bir uygulama geliştirir ve 270.000
kullanıcının onayını almayı başarır. Bu açık nedeniyle danışmanlık
firması, 50.000.000 kullanıcının özel bilgilerine erişim elde etmeyi
başarır. Daha sonra danışmanlık firması bu bilgileri kötü amaçlarla
satar.

## Nasıl Önlenir?

* Tüm <ins>API sunucularının</ins> envanterini çıkarın ve her birinin
  önemli yönlerini belgeleyin; API ortamına (örn. üretim, staging,
  test, geliştirme), sunucuya ağ erişimine kimlerin sahip olması
  gerektiğine (örn. herkese açık, dahili, iş ortakları) ve API
  sürümüne odaklanın.
* <ins>Entegre servislerin</ins> envanterini çıkarın ve sistemdeki
  rolleri, hangi verilerin değiş tokuş edildiği (veri akışı) ve
  hassasiyetleri gibi önemli yönleri belgeleyin.
* Kimlik doğrulama, hatalar, yönlendirmeler, istek sınırlandırma, kaynaklar
  arası kaynak paylaşımı (CORS) politikası ve parametreleri, istekleri
  ve yanıtları dâhil olmak üzere uç noktalar gibi API'nizin tüm
  yönlerini belgeleyin.
* Açık standartları benimseyerek dokümantasyonu otomatik olarak
  oluşturun. Dokümantasyon oluşturmayı CI/CD ardışık düzeninize dâhil
  edin.
* API dokümantasyonunu yalnızca API'yi kullanmaya yetkili olanlara
  açık hâle getirin.
* Yalnızca mevcut üretim sürümü için değil, API'lerinizin açığa
  çıkmış tüm sürümleri için API güvenliğine özel çözümler gibi
  harici koruma önlemleri kullanın.
* Üretim dışı API dağıtımlarıyla üretim verisi kullanmaktan kaçının.
  Bu kaçınılmazsa, bu uç noktalar üretim uç noktalarıyla aynı güvenlik
  muamelesini görmelidir.
* API'lerin daha yeni sürümleri güvenlik iyileştirmeleri içerdiğinde,
  eski sürümler için gereken risk azaltma önlemlerini belirlemek üzere
  bir risk analizi yapın. Örneğin, iyileştirmelerin API uyumluluğunu
  bozmadan geriye taşınıp taşınamayacağını veya eski sürümü hızla
  devre dışı bırakıp tüm istemcileri en son sürüme geçmeye zorlamanız
  gerekip gerekmediğini değerlendirin.

## Kaynaklar

### OWASP

* [REST Güvenliği Hızlı Başvuru Rehberi][2]

### Harici Kaynaklar

* [CWE-1059: Eksik Dokümantasyon][1]
* "Envanter Yönetimi" - [Mikroservis Tabanlı Uygulama Sistemleri için
  Güvenlik Stratejileri][3], NIST

[1]: https://cwe.mitre.org/data/definitions/1059.html
[2]: https://cheatsheetseries.owasp.org/cheatsheets/REST_Security_Cheat_Sheet.html
[3]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-204.pdf
