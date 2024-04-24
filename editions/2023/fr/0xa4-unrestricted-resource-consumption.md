# API4:2023 Unrestricted Resource Consumption

| Facteurs de menace / Vecteurs d'attaque | Faille de sécurité | Impact |
| - | - | - |
| Spécifique à l'API : Exploitabilité **Moyenne** | Prévalence **Répandue** : Détection **Facile** | Technique **Grave** : Spécifique à l'organisation |
| L'exploitation de cette faille nécessite des requêtes API simples. Plusieurs requêtes simultanées peuvent être effectuées à partir d'un seul ordinateur local ou en utilisant des ressources cloud. La plupart des outils automatisés disponibles sont conçus pour provoquer un déni de service (DoS) via des charges de trafic élevées, impactant le taux de service des API. | Il est courant de trouver des API qui ne limitent pas les interactions client ou la consommation de ressources. Écrire et tester avec des requêtes API incluant des paramètres qui contrôlent le nombre de ressources à renvoyer et qui effectuent une analyse de l'état/du temps/de la longueur de la réponse, devraient permettre d'identifier le problème. Il en va de même pour les opérations groupées. Bien que les attaquants n'aient pas de visibilité sur l'impact des coûts, cela peut être déduit en fonction du modèle commercial/tarifaire des fournisseurs de services (par exemple, le fournisseur de services cloud). | L'exploitation peut entraîner un déni de service (DoS) en raison de l'épuisement des ressources, mais elle peut également entraîner une augmentation des coûts opérationnels tels que ceux liés à l'infrastructure : en raison d'une demande accrue en CPU, l'augmentation des besoins en stockage sur le cloud, etc. |

## L'API est-elle vulnérable ?

Satisfaire les requêtes API nécessite des ressources telles que la bande passante réseau, le CPU, la mémoire et le stockage. Parfois, les ressources requises sont mises à disposition par les fournisseurs de services via des intégrations API, et payées par requête, comme l'envoi d'e-mails/SMS/appels téléphoniques, la validation biométrique, etc.

Une API est vulnérable si au moins l'une des limites suivantes est manquante ou définie de manière inappropriée (par exemple, trop basse/élevée) :

* Limites de temps d'exécution
* Mémoire allouable maximale
* Nombre maximal de descripteurs de fichiers (file descriptors)
* Nombre maximal de processus
* Taille maximale de fichier téléchargeable (upload)
* Nombre d'opérations à effectuer dans une seule requête client API (par exemple, le regroupement GraphQL)
* Nombre d'enregistrements par page à renvoyer dans une seule requête-réponse
* Limite de dépenses des fournisseurs de services tiers

## Exemple de scénarios d'attaque

### Scénario #1

Un réseau social a mis en place un flux de "mot de passe oublié" utilisant la vérification par SMS, permettant à l'utilisateur de recevoir un jeton unique via SMS pour réinitialiser son mot de passe.

Une fois qu'un utilisateur clique sur "mot de passe oublié", un appel API est envoyé depuis le navigateur de l'utilisateur vers l'API back-end :

```
POST /initiate_forgot_password

{
  "step": 1,
  "user_number": "6501113434"
}
```

Ensuite, en coulisses, un appel API est envoyé depuis le back-end vers une API tierce qui se charge de l'envoi du SMS :

```
POST /sms/send_reset_pass_code

Host: willyo.net

{
  "phone_number": "6501113434"
}
```

Le fournisseur tiers, Willyo, facture 0,05 $ par envoi SMS.

Un attaquant écrit un script qui envoie le premier appel API des dizaines de milliers de fois. Le back-end suit et demande à Willyo d'envoyer des dizaines de milliers de SMS, ce qui conduit l'entreprise à perdre des milliers de dollars en quelques minutes.

### Scénario #2

Un endpoint API GraphQL permet à l'utilisateur de télécharger une photo de profil.

```
POST /graphql

{
  "query": "mutation {
    uploadPic(name: \"pic1\", base64_pic: \"R0FOIEFOR0xJVA…\") {
      url
    }
  }"
}
```

Une fois le téléchargement terminé, l'API génère plusieurs miniatures de tailles différentes basées sur l'image téléchargée. Cette opération graphique consomme beaucoup de mémoire.

L'API met en œuvre une protection traditionnelle de "rate limiting" - un utilisateur ne peut pas accéder trop de fois à l'endpoint GraphQL en peu de temps. L'API vérifie également la taille de l'image téléchargée avant de générer des miniatures pour éviter de traiter des images trop grandes.

Un attaquant peut facilement contourner ces mécanismes, en exploitant la nature flexible de GraphQL :

```
POST /graphql

[
  {"query": "mutation {uploadPic(name: \"pic1\", base64_pic: \"R0FOIEFOR0xJVA…\") {url}}"},
  {"query": "mutation {uploadPic(name: \"pic2\", base64_pic: \"R0FOIEFOR0xJVA…\") {url}}"},
  ...
  {"query": "mutation {uploadPic(name: \"pic999\", base64_pic: \"R0FOIEFOR0xJVA…\") {url}}"},
}
```

Comme l'API ne limite pas le nombre de fois où l'opération `uploadPic` peut être tentée, l'appel entraînera l'épuisement de la mémoire du serveur et un déni de service.

### Scénario #3

Un fournisseur de services permet aux clients de télécharger des fichiers de grande taille via une API. Ces fichiers sont stockés dans un stockage d'objets cloud et ne changent pas souvent. Le fournisseur de services s'appuie sur un service de cache pour avoir un meilleur taux de service et pour maintenir une faible consommation de bande passante. Le service de cache ne met en cache que les fichiers ayant une taille de maximum 15 Go.

Quand l'un des fichiers est mis à jour, sa taille augmente à 18 Go. Tous les clients du service commencent immédiatement à télécharger la nouvelle version. Comme il n'y a pas eu d'alertes sur le coût de consommation, ni de limite de coût maximal pour le service cloud, la facture mensuelle suivante passe de 13 $ en moyenne à 8 000 $.

## Comment s'en prémunir

* Utilisez une solution qui facilite la limitation de la [mémoire][1], du [CPU][2], du [nombre de redémarrages][3], des descripteurs de fichiers et des processus tels que les conteneurs / le code Serverless (par exemple, les Lambdas).
* Définissez et appliquez une taille maximale de données sur tous les paramètres et payloads entrants, telle que la longueur maximale des chaînes, le nombre maximal d'éléments dans les tableaux et la taille maximale des fichiers téléchargés (qu'ils soient stockés localement ou dans un stockage cloud).
* Mettez en place une limite sur la fréquence à laquelle un client peut interagir avec l'API dans un intervalle de temps défini (rate limiting).
* Le "rate limiting" doit être ajustée méticuleusement en fonction des besoins de l'entreprise. Certains points d'accès API peuvent nécessiter des politiques plus strictes.
* Limitez/ralentissez le nombre de fois ou la fréquence à laquelle un client/utilisateur API défini peut exécuter certaines opérations (par exemple, valider un OTP, ou demander une récupération de mot de passe sans visiter l'URL à usage unique).
* Ajoutez une validation appropriée côté serveur pour les paramètres de la requête et son contenu, en particulier ceux qui contrôlent le nombre d'enregistrements à renvoyer dans la réponse (principe de pagination).
* Configurez des limites de dépenses pour tous les fournisseurs de services/intégrations API. Lorsque cela n'est pas possible, configurez plutôt des alertes de facturation.

## Références

### OWASP

* ["Availability" - Web Service Security Cheat Sheet][5]
* ["DoS Prevention" - GraphQL Cheat Sheet][6]
* ["Mitigating Batching Attacks" - GraphQL Cheat Sheet][7]

### Externes

* [CWE-770: Allocation of Resources Without Limits or Throttling][8]
* [CWE-400: Uncontrolled Resource Consumption][9]
* [CWE-799: Improper Control of Interaction Frequency][10]
* "Rate Limiting (Throttling)" - [Security Strategies for Microservices-based
  Application Systems][11], NIST

[1]: https://docs.docker.com/config/containers/resource_constraints/#memory
[2]: https://docs.docker.com/config/containers/resource_constraints/#cpu
[3]: https://docs.docker.com/engine/reference/commandline/run/#restart
[4]: https://docs.docker.com/engine/reference/commandline/run/#ulimit
[5]: https://cheatsheetseries.owasp.org/cheatsheets/Web_Service_Security_Cheat_Sheet.html#availability
[6]: https://cheatsheetseries.owasp.org/cheatsheets/GraphQL_Cheat_Sheet.html#dos-prevention
[7]: https://cheatsheetseries.owasp.org/cheatsheets/GraphQL_Cheat_Sheet.html#mitigating-batching-attacks
[8]: https://cwe.mitre.org/data/definitions/770.html
[9]: https://cwe.mitre.org/data/definitions/400.html
[10]: https://cwe.mitre.org/data/definitions/799.html
[11]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-204.pdf
