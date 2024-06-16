# API7:2023 Server Side Request Forgery

| Facteurs de menace / Vecteurs d'attaque | Faille de sécurité | Impacts |
| - | - | - |
| Spécifique à l'API : Exploitabilité **Facile** | Prévalence **Courante** : Détectabilité **Facile** | Technique **Modérée** : Spécifique à l'organisation |
| L'exploitation nécessite que l'attaquant trouve un point d'accès API qui accède à une URI fournie par le client. En général, l'exploitation de la SSRF de base (lorsque la réponse est renvoyée à l'attaquant) est plus facile que la SSRF aveugle, dans laquelle l'attaquant n'a aucun retour d'information sur le succès de l'attaque. | Les concepts modernes de développement d'applications encouragent les développeurs à accéder à des URI fournies par le client. Le manque de validation ou une validation incorrecte de ces URI sont des problèmes courants. L'analyse des réponses et des requêtes associées sera nécessaire pour détecter le problème. Lorsque la réponse n'est pas renvoyée (SSRF aveugle), la détection de la vulnérabilité nécessite plus d'efforts et de créativité. | L'exploitation réussie peut entraîner une énumération des services internes (par exemple, un balayage de ports), une divulgation d'informations, le contournement des pare-feu ou d'autres mécanismes de sécurité. Dans certains cas, cela peut entraîner un déni de service ou l'utilisation du serveur comme proxy pour masquer des activités malveillantes. |

## L'API est-elle vulnérable ?

La SSRF (Server-Side Request Forgery) se produit lorsqu'une API récupère une ressource distante sans valider l'URL fournie par l'utilisateur. Cela permet à un attaquant de forcer l'application à envoyer une requête forgée vers une destination inattendue, même si elle est protégée par un pare-feu ou un VPN.

Les concepts modernes de développement d'applications rendent la SSRF plus courante et plus dangereuse.

Encore plus courant - les concepts suivants encouragent les développeurs à accéder à une ressource externe en fonction de l'entrée utilisateur : les webhooks, le téléchargement de fichiers à partir d'URL, les SSO personnalisés et les aperçus d'URL.

Encore plus dangereux - les technologies modernes comme les fournisseurs de cloud, Kubernetes et Docker exposent des canaux de gestion et de contrôle via HTTP sur des chemins prévisibles et bien connus. Ces canaux sont une cible facile pour une attaque SSRF.

Il est de plus en plus difficile de limiter le trafic sortant de votre application, en raison de la nature connectée des applications modernes.

Le risque de SSRF ne peut pas toujours être complètement éliminé. Lors du choix d'un mécanisme de protection, il est important de tenir compte des risques et des besoins de l'entreprise.

## Exemple de scénarios d'attaque

### Scénario #1

Un réseau social permet aux utilisateurs de télécharger des photos de profil. L'utilisateur peut choisir de télécharger le fichier image depuis sa machine, ou de fournir l'URL de l'image. En choisissant la seconde option, cela déclenchera l'appel API suivant :

```
POST /api/profile/upload_picture

{
  "picture_url": "http://example.com/profile_pic.jpg"
}
```

Un attaquant peut envoyer une URL malveillante et initier un balayage de ports à l'intérieur du réseau interne en utilisant le point d'accès API.

```
{
  "picture_url": "localhost:8080"
}
```

En fonction du temps de réponse, l'attaquant peut déterminer si le port est ouvert ou non.

### Scénario #2

Un service de sécurité génère des événements lorsqu'il détecte des anomalies dans le réseau. Certaines équipes préfèrent examiner les événements dans un système de surveillance plus large et plus générique, tel qu'un SIEM (Security Information and Event Management). À cette fin, le produit fournit une intégration avec d'autres systèmes en utilisant des webhooks.

Dans le cadre de la création d'un nouveau webhook, une mutation GraphQL est envoyée avec l'URL de l'API SIEM.

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

Pendant le processus de création, l'API back-end envoie une requête de test à l'URL du webhook fournie, et présente à l'utilisateur la réponse.

Un attaquant peut exploiter ce flux, et faire en sorte que l'API envoie une requête à une ressource sensible, telle qu'un service interne cloud de métadonnées qui expose des informations d'identification :

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

Puisque l'application affiche la réponse de la requête de test, l'attaquant peut voir les informations d'identification de l'environnement cloud.

## Comment s'en prémunir

* Isoler le mécanisme de récupération des ressources dans votre réseau : ces fonctionnalités sont généralement destinées à récupérer des ressources distantes et non internes.
* Chaque fois que possible, utilisez des listes d'autorisation :
    * Les origines distantes à partir desquelles les utilisateurs sont censés télécharger des ressources (par exemple, Google Drive, Gravatar, etc.)
    * Les schémas d'URL et les ports
    * Les types de médias acceptés pour une fonctionnalité donnée
* Désactivez les redirections HTTP.
* Utilisez un analyseur d'URL bien testé et maintenu pour éviter les problèmes causés par des incohérences d'analyse d'URL.
* Validez et assainissez toutes les données d'entrée fournies par le client.
* Ne renvoyez pas de réponses brutes aux clients.

## Références

### OWASP

* [Server Side Request Forgery][1]
* [Server-Side Request Forgery Prevention Cheat Sheet][2]

### Externes

* [CWE-918: Server-Side Request Forgery (SSRF)][3]
* [URL confusion vulnerabilities in the wild: Exploring parser inconsistencies,
   Snyk][4]

[1]: https://owasp.org/www-community/attacks/Server_Side_Request_Forgery
[2]: https://cheatsheetseries.owasp.org/cheatsheets/Server_Side_Request_Forgery_Prevention_Cheat_Sheet.html
[3]: https://cwe.mitre.org/data/definitions/918.html
[4]: https://snyk.io/blog/url-confusion-vulnerabilities/
