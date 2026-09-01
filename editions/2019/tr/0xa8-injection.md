# API8:2019 Enjeksiyon

| Tehdit aktörleri / Saldırı vektörleri | Güvenlik Zayıflığı | Etkiler |
| - | - | - |
| API'ye Özgü : İstismar Edilebilirlik **3** | Yaygınlık **2** : Tespit Edilebilirlik **3** | Teknik **3** : Kuruluşa özgü |
| Saldırganlar, verinin bir yorumlayıcıya (interpreter) gönderilmesini bekleyerek mevcut olan enjeksiyon vektörleri (örn. doğrudan girdi, parametreler, entegre servisler vb.) aracılığıyla API'ye kötü amaçlı veri gönderir. | Enjeksiyon açıkları çok yaygındır ve genellikle SQL, LDAP veya NoSQL sorgularında, işletim sistemi komutlarında, XML ayrıştırıcılarında (parser) ve ORM'de bulunur. Bu açıklar kaynak kodu incelenirken kolayca tespit edilir. Saldırganlar tarayıcı (scanner) ve fuzzer araçlarını kullanabilir. | Enjeksiyon; bilgi ifşasına ve veri kaybına yol açabilir. Ayrıca Hizmet Reddine (DoS) veya sunucunun tamamen ele geçirilmesine de neden olabilir. |

## API Bu Zafiyete Açık mı?

API, aşağıdaki durumlarda enjeksiyon açıklarına karşı savunmasızdır:

* İstemci tarafından sağlanan veri, API tarafından doğrulanmıyor,
  filtrelenmiyor veya arındırılmıyorsa.
* İstemci tarafından sağlanan veri, doğrudan kullanılıyor veya
  SQL/NoSQL/LDAP sorgularına, işletim sistemi komutlarına, XML
  ayrıştırıcılarına ve Nesne İlişkisel Eşleyicisine (ORM)/Nesne
  Doküman Eşleyicisine (ODM) birleştiriliyorsa.
* Harici sistemlerden (örn. entegre sistemler) gelen veri, API
  tarafından doğrulanmıyor, filtrelenmiyor veya arındırılmıyorsa.

## Örnek Saldırı Senaryoları

### Senaryo #1

Bir ebeveyn kontrolü cihazının firmware'i, bir appId'nin multipart
parametre olarak gönderilmesini bekleyen `/api/CONFIG/restore` uç
noktasını sunar. Bir decompiler kullanan saldırgan, appId'nin herhangi
bir arındırma yapılmadan doğrudan bir sistem çağrısına aktarıldığını
keşfeder:

```c
snprintf(cmd, 128, "%srestore_backup.sh /tmp/postfile.bin %s %d",
         "/mnt/shares/usr/bin/scripts/", appid, 66);
system(cmd);
```

Aşağıdaki komut, saldırganın aynı savunmasız firmware'e sahip herhangi
bir cihazı kapatmasına olanak tanır:

```
$ curl -k "https://${deviceIP}:4567/api/CONFIG/restore" -F 'appid=$(/etc/pod/power_down.sh)'
```

### Senaryo #2

Rezervasyonlarla ilgili işlemler için temel CRUD işlevselliğine sahip
bir uygulamamız var. Bir saldırgan, rezervasyon silme isteğindeki
`bookingId` sorgu dizesi parametresi üzerinden NoSQL enjeksiyonunun
mümkün olabileceğini tespit etmeyi başarır. İstek şu şekilde
görünmektedir: `DELETE /api/bookings?bookingId=678`.

API sunucusu, silme isteklerini işlemek için şu fonksiyonu kullanır:

```javascript
router.delete('/bookings', async function (req, res, next) {
  try {
      const deletedBooking = await Bookings.findOneAndRemove({'_id' : req.query.bookingId});
      res.status(200);
  } catch (err) {
     res.status(400).json({error: 'Unexpected error occured while processing a request'});
  }
});
```

Saldırgan isteği yakalar ve `bookingId` sorgu dizesi parametresini
aşağıdaki gibi değiştirir. Bu durumda saldırgan, başka bir kullanıcının
rezervasyonunu silmeyi başarır:

```
DELETE /api/bookings?bookingId[$ne]=678
```

## Nasıl Önlenir?

Enjeksiyonu önlemek, veriyi komutlardan ve sorgulardan ayrı tutmayı
gerektirir.

* Veri doğrulamasını tek, güvenilir ve aktif olarak bakımı yapılan bir
  kütüphane kullanarak gerçekleştirin.
* İstemci tarafından sağlanan veya entegre sistemlerden gelen tüm
  veriyi doğrulayın, filtreleyin ve arındırın.
* Özel karakterler, hedef yorumlayıcıya özgü sözdizimi kullanılarak
  kaçışa (escape) uğratılmalıdır.
* Parametreleştirilmiş bir arayüz sunan güvenli bir API'yi tercih
  edin.
* Enjeksiyon durumunda toplu veri ifşasını önlemek için döndürülen
  kayıt sayısını her zaman sınırlandırın.
* Gelen veriyi, her girdi parametresi için yalnızca geçerli değerlere
  izin verecek yeterli filtrelerle doğrulayın.
* Tüm string parametreleri için veri tiplerini ve katı örüntüleri
  (pattern) tanımlayın.

## Kaynaklar

### OWASP

* [OWASP Enjeksiyon Açıkları][1]
* [SQL Enjeksiyonu][2]
* [Nesneler ve Dizilerle NoSQL Enjeksiyonu][3]
* [Komut Enjeksiyonu][4]

### Harici Kaynaklar

* [CWE-77: Komut Enjeksiyonu][5]
* [CWE-89: SQL Enjeksiyonu][6]

[1]: https://www.owasp.org/index.php/Injection_Flaws
[2]: https://www.owasp.org/index.php/SQL_Injection
[3]: https://www.owasp.org/images/e/ed/GOD16-NOSQL.pdf
[4]: https://www.owasp.org/index.php/Command_Injection
[5]: https://cwe.mitre.org/data/definitions/77.html
[6]: https://cwe.mitre.org/data/definitions/89.html
