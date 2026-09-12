# API10:2019 Yetersiz Loglama ve İzleme

| Tehdit aktörleri / Saldırı vektörleri | Güvenlik Zayıflığı | Etkiler |
| - | - | - |
| API'ye Özgü : İstismar Edilebilirlik **2** | Yaygınlık **3** : Tespit Edilebilirlik **1** | Teknik **2** : Kuruluşa özgü |
| Saldırganlar, fark edilmeden sistemleri istismar etmek için loglama ve izleme eksikliğinden yararlanır. | Loglama ve izleme olmadan veya yetersiz loglama ve izlemeyle, şüpheli etkinlikleri takip etmek ve bunlara zamanında müdahale etmek neredeyse imkânsızdır. | Devam eden kötü amaçlı etkinlikler üzerinde görünürlük olmadan, saldırganların sistemleri tamamen ele geçirmek için bol miktarda zamanı olur. |

## API Bu Zafiyete Açık mı?

API aşağıdaki durumlarda zafiyete açıktır:

* Herhangi bir log üretmiyorsa, log seviyesi doğru ayarlanmamışsa
  veya log mesajları yeterli ayrıntı içermiyorsa.
* Log bütünlüğü garanti edilmiyorsa (örn. [Log Enjeksiyonu][1]).
* Loglar sürekli olarak izlenmiyorsa.
* API altyapısı sürekli olarak izlenmiyorsa.

## Örnek Saldırı Senaryoları

### Senaryo #1

Yönetimsel bir API'nin erişim anahtarları herkese açık bir
repository'de sızdırılır. Repository sahibi, olası sızıntı hakkında
e-postayla bilgilendirilir; ancak olaya müdahale etmesi 48 saatten
uzun sürer ve bu sürede erişim anahtarlarının ifşası hassas verilere
erişime izin vermiş olabilir. Yetersiz loglama nedeniyle şirket, kötü
niyetli kişilerin hangi verilere eriştiğini tespit edemez.

### Senaryo #2

Bir video paylaşım platformu "büyük ölçekli" bir kimlik bilgisi
doldurma saldırısına maruz kalır. Başarısız girişler loglansa da,
saldırının sürdüğü süre boyunca herhangi bir uyarı tetiklenmez.
Kullanıcı şikâyetlerine tepki olarak API logları incelenir ve saldırı
tespit edilir. Şirket, kullanıcılardan şifrelerini sıfırlamalarını
isteyen bir kamuoyu duyurusu yapmak ve olayı düzenleyici otoritelere
bildirmek zorunda kalır.

## Nasıl Önlenir?

* Başarısız tüm kimlik doğrulama denemelerini, reddedilen erişimleri
  ve girdi doğrulama hatalarını loglayın.
* Loglar, bir log yönetimi çözümü tarafından tüketilmeye uygun bir
  formatta yazılmalı ve kötü niyetli kişiyi tanımlamaya yetecek kadar
  ayrıntı içermelidir.
* Loglar hassas veri olarak ele alınmalı ve hem bekleme hem de aktarım
  sırasında bütünlükleri garanti altına alınmalıdır.
* Altyapıyı, ağı ve API'nin çalışmasını sürekli olarak izlemek için
  bir izleme sistemi yapılandırın.
* API yığınının tüm bileşenlerinden ve sunucularından gelen logları
  toplamak ve yönetmek için bir Güvenlik Bilgi ve Olay Yönetimi (SIEM)
  sistemi kullanın.
* Şüpheli etkinliklerin daha erken tespit edilip müdahale
  edilebilmesini sağlayan özel panolar (dashboard) ve uyarılar
  yapılandırın.

## Kaynaklar

### OWASP

* [OWASP Loglama Hızlı Başvuru Rehberi][2]
* [OWASP Proaktif Kontroller: Loglama ve Saldırı Tespiti Uygulama][3]
* [OWASP Uygulama Güvenliği Doğrulama Standardı: V7: Hata Yönetimi ve
  Loglama Doğrulama Gereksinimleri][4]

### Harici Kaynaklar

* [CWE-223: Güvenlikle İlgili Bilginin İhmal Edilmesi][5]
* [CWE-778: Yetersiz Loglama][6]

[1]: https://www.owasp.org/index.php/Log_Injection
[2]: https://www.owasp.org/index.php/Logging_Cheat_Sheet
[3]: https://www.owasp.org/index.php/OWASP_Proactive_Controls
[4]: https://github.com/OWASP/ASVS/blob/master/4.0/en/0x15-V7-Error-Logging.md
[5]: https://cwe.mitre.org/data/definitions/223.html
[6]: https://cwe.mitre.org/data/definitions/778.html
