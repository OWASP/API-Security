# API7:2023 Pemalsuan Permintaan Sisi Server 

| Agen ancaman/Vektor serangan | Kelemahan Keamanan | Dampak |
| - | - | - |
| Khusus API: **Mudah** dieksploitasi | Prevalensi **Umum** : **Mudah** Terdeteksi | Teknis **Sedang** : Spesifik Bisnis |  
| Eksploitasi membutuhkan penyerang untuk menemukan endpoint API yang mengakses URI yang disediakan oleh klien. Secara umum, SSRF dasar (saat respons dikembalikan ke penyerang) lebih mudah dieksploitasi daripada Blind SSRF ketika penyerang tidak menerima informasi apakah serangan berhasil atau tidak. | Konsep modern dalam pengembangan aplikasi mendorong pengembang untuk mengakses URI yang disediakan oleh klien. Kurangnya atau validasi yang tidak tepat dari URI tersebut adalah masalah yang umum. Permintaan dan analisis respons API reguler akan dibutuhkan untuk mendeteksi masalah tersebut. Ketika respons tidak dikembalikan (Blind SSRF) mendeteksi kerentanan membutuhkan lebih banyak upaya dan kreativitas. | Eksploitasi yang berhasil mungkin mengarah ke enumerasi layanan internal (misalnya pemindaian port), pengungkapan informasi, menghindari firewall, atau mekanisme keamanan lainnya. Dalam beberapa kasus, dapat mengarah ke DoS atau server digunakan sebagai proxy untuk menyembunyikan kegiatan berbahaya. |

## Apakah API Rentan?

Celah Pemalsuan Permintaan Sisi Server (SSRF) terjadi ketika API mengambil sumber daya jarak jauh tanpa memvalidasi URL yang diberikan pengguna. Hal ini memungkinkan penyerang memaksa aplikasi untuk mengirim permintaan yang dibuat ke tujuan yang tidak terduga, bahkan ketika dilindungi oleh firewall atau VPN.

Konsep modern dalam pengembangan aplikasi membuat SSRF lebih umum dan lebih berbahaya. 

Lebih umum - konsep berikut mendorong pengembang untuk mengakses sumber daya eksternal berdasarkan masukan pengguna: Webhook, mengambil file dari URL, SSO kustom, dan pratinjau URL.

Lebih berbahaya - Teknologi modern seperti penyedia cloud, Kubernetes, dan Docker mengekspos saluran manajemen dan kontrol melalui HTTP pada jalur yang dapat diprediksi dan dikenal dengan baik. Saluran tersebut adalah target yang mudah untuk serangan SSRF. 

Juga lebih menantang untuk membatasi lalu lintas keluar aplikasi Anda, karena sifat terhubung aplikasi modern.

Risiko SSRF tidak selalu dapat sepenuhnya dihilangkan. Saat memilih mekanisme perlindungan, penting untuk mempertimbangkan risiko bisnis dan kebutuhan.

## Contoh Skenario Serangan

### Skenario #1

Sebuah jejaring sosial memungkinkan pengguna mengunggah foto profil. Pengguna dapat memilih untuk mengunggah file gambar dari mesin mereka, atau menyediakan URL gambar. Memilih opsi kedua, akan memicu panggilan API berikut:

```
POST /api/profile/upload_picture 

{
  "picture_url": "http://example.com/profile_pic.jpg" 
}
```

Seorang penyerang dapat mengirim URL berbahaya dan memulai pemindaian port di jaringan internal menggunakan Endpoint API.

```
{
  "picture_url": "localhost:8080"
}
```

Berdasarkan waktu respons, penyerang dapat mengetahui apakah port terbuka atau tidak. 

### Skenario #2

Sebuah produk keamanan menghasilkan peristiwa ketika mendeteksi anomali di jaringan. Beberapa tim lebih suka meninjau peristiwa dalam sistem pemantauan yang lebih luas dan generik, seperti SIEM (Security Information and Event Management). Untuk tujuan ini, produk menyediakan integrasi dengan sistem lain menggunakan webhook.

Sebagai bagian dari pembuatan webhook baru, mutasi GraphQL dikirim dengan URL API SIEM.

```
POST /graphql

[
  {
    "variables": {},
    "query": "mutation {
      createNotificationChannel(input: {
        channelName: \"ch_piney\",
        notificationChannelConfig: {
          customWebhookChannelConfigs: [
            {
              url: \"http://www.siem-system.com/create_new_event\",
              send_test_req: true
            }
          ]
    	  }
  	  }){
    	channelId
  	}
	}"
  }
]

```

Selama proses pembuatan, back-end API mengirim permintaan uji ke URL webhook yang diberikan, dan menyajikan respons ke pengguna. 

Seorang penyerang dapat memanfaatkan alur ini, dan membuat permintaan API untuk sumber daya sensitif, seperti layanan metadata cloud internal yang mengekspos kredensial:

```
POST /graphql

[
  {
    "variables": {},
    "query": "mutation {
      createNotificationChannel(input: {
        channelName: \"ch_piney\",
        notificationChannelConfig: {
          customWebhookChannelConfigs: [
            {
              url: \"http://169.254.169.254/latest/meta-data/iam/security-credentials/ec2-default-ssm\",
              send_test_req: true
            }
          ]
        }
      }) {
        channelId
      }
    }
  }
]
```

Karena aplikasi menampilkan respons dari permintaan uji, penyerang dapat melihat kredensial lingkungan cloud.

## Cara Mencegah

* Isolasi mekanisme pengambilan sumber daya di jaringan Anda: biasanya fitur ini bertujuan untuk mengambil sumber daya jarak jauh dan bukan internal.
* Kapan pun memungkinkan, gunakan allow list untuk:
    * Asal lokasi sumber daya (misalnya Google Drive, Gravatar, dll.) yang diharapkan digunakan pengguna untuk mengunduh sumber daya
    * Skema URL dan port
    * Jenis media yang diterima untuk fungsionalitas tertentu
* Nonaktifkan pengalihan HTTP. 
* Gunakan parser URL yang diuji dan dikelola dengan baik untuk menghindari masalah yang disebabkan oleh inkonsistensi parsing URL.
* Validasi dan bersihkan semua data input yang diberikan klien.  
* Jangan kirim respons mentah ke klien.

## Referensi

### OWASP

* [Server Side Request Forgery][1]
* [Server-Side Request Forgery Prevention Cheat Sheet][2]

### Eksternal

* [CWE-918: Server-Side Request Forgery (SSRF)][3]
* [URL confusion vulnerabilities in the wild: Exploring parser inconsistencies,
   Snyk][4]

[1]: https://owasp.org/www-community/attacks/Server_Side_Request_Forgery
[2]: https://cheatsheetseries.owasp.org/cheatsheets/Server_Side_Request_Forgery_Prevention_Cheat_Sheet.html
[3]: https://cwe.mitre.org/data/definitions/918.html
[4]: https://snyk.io/blog/url-confusion-vulnerabilities/
