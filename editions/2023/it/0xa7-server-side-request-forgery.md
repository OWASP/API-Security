# API7:2023 Server Side Request Forgery

| Agenti di Minaccia/Vettori di Attacco | Debolezza di Sicurezza | Impatti |
| - | - | - |
| Specifico per API : Sfruttabilità **Facile** | Diffusione **Comune** : Rilevabilità **Facile** | Tecnico **Moderato** : Specifico per il Business |
| Lo sfruttamento richiede che l'attaccante trovi un endpoint API che accede a un URI fornito dal client. In generale, un SSRF base (in cui la risposta viene restituita all'attaccante) è più facile da sfruttare rispetto a un Blind SSRF, in cui l'attaccante non riceve alcun feedback sull'esito dell'attacco. | I moderni paradigmi di sviluppo delle applicazioni incoraggiano gli sviluppatori ad accedere agli URI forniti dal client. La mancanza di validazione o una validazione inadeguata di tali URI sono problemi comuni. L'analisi regolare delle richieste e delle risposte API sarà necessaria per rilevare il problema. Quando la risposta non viene restituita (Blind SSRF), rilevare la vulnerabilità richiede maggiore impegno e creatività. | Un exploit riuscito potrebbe portare all'enumerazione dei servizi interni (ad esempio la scansione delle porte), alla divulgazione di informazioni, all'aggiramento di firewall o di altri meccanismi di sicurezza. In alcuni casi, può portare a DoS o all'utilizzo del server come proxy per nascondere attività malevole. |

## L'API è Vulnerabile?

Le falle di Server-Side Request Forgery (SSRF) si verificano quando un'API
recupera una risorsa remota senza validare l'URL fornito dall'utente. Ciò
consente a un attaccante di forzare l'applicazione a inviare una richiesta
artefatta a una destinazione inattesa, anche se protetta da un firewall o una
VPN.

I moderni paradigmi di sviluppo delle applicazioni rendono l'SSRF più comune
e più pericoloso.

Più comune — i seguenti paradigmi incoraggiano gli sviluppatori ad accedere a
una risorsa esterna in base all'input dell'utente: Webhook, recupero di file da
URL, SSO personalizzato e anteprime URL.

Più pericoloso — le tecnologie moderne come i provider cloud, Kubernetes e
Docker espongono canali di gestione e controllo tramite HTTP su percorsi noti
e prevedibili. Questi canali sono facili bersagli per un attacco SSRF.

Anche limitare il traffico in uscita dall'applicazione è più difficile, a causa
della natura interconnessa delle applicazioni moderne.

Il rischio SSRF non può sempre essere eliminato completamente. Nella scelta di
un meccanismo di protezione, è importante considerare i rischi e le esigenze
di business.

## Scenari di Attacco di Esempio

### Scenario #1

Un social network consente agli utenti di caricare immagini del profilo.
L'utente può scegliere di caricare il file immagine dal proprio dispositivo o
di fornire l'URL dell'immagine. Scegliendo la seconda opzione, verrà attivata
la seguente chiamata API:

```
POST /api/profile/upload_picture

{
  "picture_url": "http://example.com/profile_pic.jpg"
}
```

Un attaccante può inviare un URL malevolo e avviare la scansione delle porte
nella rete interna tramite l'endpoint API.

```
{
  "picture_url": "localhost:8080"
}
```

In base al tempo di risposta, l'attaccante può determinare se la porta è aperta
o meno.

### Scenario #2

Un prodotto di sicurezza genera eventi quando rileva anomalie nella rete. Alcuni
team preferiscono esaminare gli eventi in un sistema di monitoraggio più ampio
e generico, come un SIEM (Security Information and Event Management). A tal
fine, il prodotto fornisce l'integrazione con altri sistemi tramite webhook.

Come parte della creazione di un nuovo webhook, viene inviata una mutazione
GraphQL con l'URL dell'API SIEM.

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

Durante il processo di creazione, il back-end dell'API invia una richiesta di
test all'URL del webhook fornito e mostra all'utente la risposta.

Un attaccante può sfruttare questo flusso e fare in modo che l'API richieda
una risorsa sensibile, come un servizio interno di metadati cloud che espone
le credenziali:

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

Poiché l'applicazione mostra la risposta della richiesta di test, l'attaccante
può visualizzare le credenziali dell'ambiente cloud.

## Come Prevenire

* Isolare il meccanismo di recupero delle risorse nella rete: solitamente queste
  funzionalità sono pensate per recuperare risorse remote e non interne.
* Dove possibile, utilizzare allowlist di:
    * Origini remote da cui gli utenti possono scaricare risorse (ad esempio
      Google Drive, Gravatar, ecc.)
    * Schemi e porte URL
    * Tipi di media accettati per una determinata funzionalità
* Disabilitare i redirect HTTP.
* Utilizzare un parser URL ben testato e mantenuto per evitare problemi causati
  da inconsistenze nel parsing degli URL.
* Validare e sanificare tutti i dati di input forniti dal client.
* Non inviare risposte grezze ai client.

## Riferimenti

### OWASP

* [Server Side Request Forgery][1]
* [Server-Side Request Forgery Prevention Cheat Sheet][2]

### Esterni

* [CWE-918: Server-Side Request Forgery (SSRF)][3]
* [URL confusion vulnerabilities in the wild: Exploring parser inconsistencies,
   Snyk][4]

[1]: https://owasp.org/www-community/attacks/Server_Side_Request_Forgery
[2]: https://cheatsheetseries.owasp.org/cheatsheets/Server_Side_Request_Forgery_Prevention_Cheat_Sheet.html
[3]: https://cwe.mitre.org/data/definitions/918.html
[4]: https://snyk.io/blog/url-confusion-vulnerabilities/