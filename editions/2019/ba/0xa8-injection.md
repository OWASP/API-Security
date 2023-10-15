# API8:2019 Injeksi

| Agen Ancaman/Vektor Serangan | Kelemahan Keamanan | Dampak |
| - | - | - |
| Khusus API: Eksploitasi **3** | Prevalensi **2** : Deteksi **3** | Teknis **3** : Spesifik Bisnis |
| Penyerang akan memberi makan API dengan data berbahaya melalui vektor injeksi apa pun yang tersedia (misalnya, input langsung, parameter, layanan terintegrasi, dll.), berharap itu dikirim ke interpreter. | Celah injeksi sangat umum dan sering ditemukan dalam kueri SQL, LDAP, atau NoSQL, perintah OS, parser XML, dan ORM. Celah ini mudah ditemukan saat meninjau kode sumber. Penyerang dapat menggunakan scanner dan fuzzer. | Injeksi dapat menyebabkan pengungkapan informasi dan kehilangan data. Itu juga dapat menyebabkan DoS, atau pengambilalihan host secara total. |

## Apakah API Rentan?

API rentan terhadap celah injeksi jika:

* Data yang disediakan klien tidak divalidasi, difilter, atau disucihamakan oleh API.
* Data yang disediakan klien digunakan langsung atau digabungkan ke kueri SQL/NoSQL/LDAP, perintah OS, parser XML, dan Pemetaan Objek Relasional (ORM)/Pemetaan Dokumen Objek (ODM).
* Data yang berasal dari sistem eksternal (misalnya, sistem terintegrasi) tidak divalidasi, difilter, atau disucihamakan oleh API.

## Skenario Serangan Contoh

### Skenario #1

Firmware dari perangkat kontrol orang tua menyediakan endpoint `/api/CONFIG/restore` yang mengharapkan appId dikirim sebagai parameter multipart. Menggunakan dekompiler, seorang penyerang mengetahui bahwa appId dilewatkan langsung ke panggilan sistem tanpa pembersihan apa pun:

```c
snprintf(cmd, 128, "%srestore_backup.sh /tmp/postfile.bin %s %d", 
         "/mnt/shares/usr/bin/scripts/", appid, 66);
system(cmd);
```

Perintah berikut memungkinkan penyerang mematikan perangkat mana pun dengan firmware yang sama yang rentan:

```
$ curl -k "https://${deviceIP}:4567/api/CONFIG/restore" -F 'appid=$(/etc/pod/power_down.sh)' 
```

### Skenario #2

Kami memiliki aplikasi dengan fungsionalitas CRUD dasar untuk operasi dengan pemesanan. Seorang penyerang berhasil mengidentifikasi bahwa injeksi NoSQL mungkin dimungkinkan melalui parameter string kueri `bookingId` dalam permintaan penghapusan pemesanan. Beginilah permintaannya: `DELETE /api/bookings?bookingId=678`.

Server API menggunakan fungsi berikut untuk menangani permintaan penghapusan:

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

Penyerang menyadap permintaan dan mengubah parameter string kueri `bookingId` seperti di bawah ini. Dalam hal ini, penyerang berhasil menghapus pemesanan pengguna lain: 

```
DELETE /api/bookings?bookingId[$ne]=678
```

## Cara Mencegah

Mencegah injeksi memerlukan pemisahan data dari perintah dan kueri.

* Lakukan validasi data menggunakan satu pustaka yang tepercaya dan dikelola secara aktif.
* Validasi, filter, dan sucikan semua data yang disediakan klien, atau data lainnya yang berasal dari sistem terintegrasi.  
* Karakter khusus harus dilepas menggunakan sintaks spesifik untuk interpreter tujuan.
* Lebih baik menggunakan API yang aman yang menyediakan antarmuka terparameter.
* Selalu batasi jumlah catatan yang dikembalikan untuk mencegah pengungkapan massal jika terjadi injeksi.
* Validasi data masuk menggunakan filter yang cukup untuk hanya mengizinkan nilai yang valid untuk setiap parameter input.
* Tentukan jenis data dan pola ketat untuk semua parameter string.

## Referensi

### OWASP

* [OWASP Injection Flaws][1]  
* [SQL Injection][2]
* [NoSQL Injection Fun with Objects and Arrays][3]  
* [Command Injection][4]

### Eksternal

* [CWE-77: Command Injection][5]
* [CWE-89: SQL Injection][6]

[1]: https://www.owasp.org/index.php/Injection_Flaws
[2]: https://www.owasp.org/index.php/SQL_Injection
[3]: https://www.owasp.org/images/e/ed/GOD16-NOSQL.pdf
[4]: https://www.owasp.org/index.php/Command_Injection
[5]: https://cwe.mitre.org/data/definitions/77.html 
[6]: https://cwe.mitre.org/data/definitions/89.html