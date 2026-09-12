# API4:2019 Kaynak ve Hız Sınırlaması Eksikliği

| Tehdit aktörleri / Saldırı vektörleri | Güvenlik Zayıflığı | Etkiler |
| - | - | - |
| API'ye Özgü : İstismar Edilebilirlik **2** | Yaygınlık **3** : Tespit Edilebilirlik **3** | Teknik **2** : Kuruluşa özgü |
| İstismar için basit API istekleri yeterlidir. Kimlik doğrulamaya gerek yoktur. Tek bir yerel bilgisayardan veya bulut bilişim kaynakları kullanılarak birden fazla eşzamanlı istek gönderilebilir. | İstek sınırlandırması uygulamayan veya sınırların doğru ayarlanmadığı API'lere sıkça rastlanır. | İstismar, API'yi yanıt vermez hâle getiren hatta tamamen kullanılamaz kılan bir Hizmet Reddine (DoS) yol açabilir. |

## API Bu Zafiyete Açık mı?

API istekleri; ağ, CPU, bellek ve depolama gibi kaynakları tüketir. Bir
isteği karşılamak için gereken kaynak miktarı büyük ölçüde kullanıcı
girdisine ve uç noktanın iş mantığına bağlıdır. Ayrıca, birden fazla API
istemcisinden gelen isteklerin kaynaklar için birbiriyle yarıştığını da
göz önünde bulundurun. Aşağıdaki sınırlardan en az birinin eksik olması
veya uygunsuz biçimde ayarlanması (örn. çok düşük/yüksek) durumunda API
zafiyete açıktır:

* Yürütme zaman aşımları (execution timeouts)
* Tahsis edilebilecek maksimum bellek
* Dosya tanımlayıcısı (file descriptor) sayısı
* İşlem (process) sayısı
* İstek gövdesi boyutu (örn. dosya yüklemeleri)
* İstemci/kaynak başına istek sayısı
* Tek bir istek yanıtında döndürülecek kayıt sayısı

## Örnek Saldırı Senaryoları

### Senaryo #1

Bir saldırgan, `/api/v1/images` adresine bir POST isteği göndererek büyük
boyutlu bir görsel yükler. Yükleme tamamlandığında API, farklı boyutlarda
birden fazla küçük resim (thumbnail) oluşturur. Yüklenen görselin boyutu
nedeniyle, küçük resimlerin oluşturulması sırasında kullanılabilir bellek
tükenir ve API yanıt vermez hâle gelir.

### Senaryo #2

Bir uygulamada, kullanıcı listesini sayfa başına `200` kullanıcıyla
sınırlayan bir arayüz bulunmaktadır. Kullanıcı listesi sunucudan şu
sorguyla alınır: `/api/users?page=1&size=200`. Bir saldırgan, `size`
parametresini `200000` olarak değiştirerek veritabanında performans
sorunlarına yol açar. Bu esnada API yanıt vermez hâle gelir ve bu
istemciden veya başka herhangi bir istemciden gelen istekleri
işleyemez hâle gelir (yani DoS).

Aynı senaryo, Integer Overflow veya Buffer Overflow hatalarını tetiklemek
için de kullanılabilir.

## Nasıl Önlenir?

* Docker; [bellek][1], [CPU][2], [yeniden başlatma sayısı][3] ve [dosya
  tanımlayıcıları ile işlem sayısını][4] sınırlamayı kolaylaştırır.
* İstemcinin API'yi belirli bir zaman aralığında ne sıklıkla
  çağırabileceğine dair bir sınır uygulayın.
* Sınır aşıldığında istemciye, sınır sayısını ve sınırın ne zaman
  sıfırlanacağını bildirerek bilgi verin.
* Sorgu dizesi ve istek gövdesi parametreleri için, özellikle yanıtta
  döndürülecek kayıt sayısını kontrol eden parametre için uygun sunucu
  taraflı doğrulama ekleyin.
* Dizelerin maksimum uzunluğu ve dizilerdeki maksimum eleman sayısı gibi,
  tüm gelen parametreler ve veri yükleri için maksimum veri boyutunu
  tanımlayın ve zorunlu kılın.

## Kaynaklar

### OWASP

* [Kaba Kuvvet Saldırılarını Engelleme][5]
* [Docker Hızlı Başvuru Rehberi - Kaynakları Sınırlama (bellek, CPU,
  dosya tanımlayıcıları, işlemler, yeniden başlatmalar)][6]
* [REST Değerlendirme Hızlı Başvuru Rehberi][7]

### Harici Kaynaklar

* [CWE-307: Aşırı Kimlik Doğrulama Denemelerinin Yetersiz Kısıtlanması][8]
* [CWE-770: Sınır veya Kısıtlama Olmadan Kaynak Tahsisi][9]
* "_Rate Limiting (Throttling)_" - [Mikroservis Tabanlı Uygulama
  Sistemleri için Güvenlik Stratejileri][10], NIST

[1]: https://docs.docker.com/config/containers/resource_constraints/#memory
[2]: https://docs.docker.com/config/containers/resource_constraints/#cpu
[3]: https://docs.docker.com/engine/reference/commandline/run/#restart-policies---restart
[4]: https://docs.docker.com/engine/reference/commandline/run/#set-ulimits-in-container---ulimit
[5]: https://www.owasp.org/index.php/Blocking_Brute_Force_Attacks
[6]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/Docker_Security_Cheat_Sheet.md#rule-7---limit-resources-memory-cpu-file-descriptors-processes-restarts
[7]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/REST_Assessment_Cheat_Sheet.md
[8]: https://cwe.mitre.org/data/definitions/307.html
[9]: https://cwe.mitre.org/data/definitions/770.html
[10]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-204-draft.pdf
