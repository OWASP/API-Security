# API2:2023 Broken Authentication

| Facteurs de menace / Vecteurs d'attaque | Faille de sécurité | Impact |
| - | - | - |
| Spécifique à l'API : Exploitabilité **Facile** | Prévalence **Répandue** : Détectabilité **Facile** | Technique **Grave** : Spécifique à l'organisation |
| Le mécanisme d'authentification est une cible facile pour les attaquants car il est exposé à tout le monde. Bien que des compétences techniques plus avancées puissent être nécessaires pour exploiter certaines failles d'authentification, des outils d'exploitation sont généralement disponibles. | Les erreurs de conception commises par les ingénieurs logiciels et en sécurité ou la complexité d'implémentation rendent les problèmes courants pour l'authentification des utilisateurs. Les méthodologies de détection des problèmes d'authentification sont disponibles et faciles à créer. | Les attaquants peuvent prendre le contrôle complet des comptes d'autres utilisateurs du système, lire leurs données personnelles et effectuer des actions sensibles en leur nom. Les systèmes sont peu susceptibles de pouvoir distinguer les actions des attaquants de celles des utilisateurs légitimes. |


## L'API est-elle vulnérable ?

Les points d'accès (endpoints) et les flux d'authentification sont des actifs qui doivent être protégés. De plus, les mécanismes de "Mot de passe oublié / réinitialisation du mot de passe" doivent être traités de la même manière que les mécanismes d'authentification.

Une API est vulnérable si elle :

* Permet le bourrage d'informations d'identification, où l'attaquant utilise la force brute avec une liste de noms d'utilisateur et de mots de passe valides.
* Permet aux attaquants d'effectuer une attaque par force brute sur le même compte utilisateur, sans présenter de mécanisme de captcha/blocage de compte.
* Permet des mots de passe faibles.
* Envoie des détails d'authentification sensibles, tels que des jetons d'authentification et des mots de passe dans l'URL.
* Permet aux utilisateurs de modifier leur adresse e-mail, leur mot de passe actuel ou de réaliser d'autres opérations sensibles sans demander de confirmation de mot de passe.
* Ne valide pas l'authenticité des jetons.
* Accepte des jetons JWT non signés/faiblement signés (`{"alg":"none"}`)
* Ne valide pas la date d'expiration du JWT.
* Utilise des mots de passe en clair, non chiffrés ou faiblement hachés.
* Utilise des clés de chiffrement faibles.

De plus, un microservice est vulnérable si :

* D'autres microservices peuvent y accéder sans authentification.
* Il utilise des jetons faibles ou prévisibles pour appliquer l'authentification.

## Exemple de scénarios d'attaque

## Scénario #1

Pour effectuer une authentification utilisateur, le client doit envoyer une requête API comme celle-ci avec les informations d'identification de l'utilisateur :

```
POST /graphql
{
  "query":"mutation {
    login (username:\"<username>\",password:\"<password>\") {
      token
    }
   }"
}
```

Si les informations d'identification sont valides, un jeton d'authentification est renvoyé. Ce jeton doit être fourni dans les requêtes suivantes pour identifier l'utilisateur. Les tentatives de connexion sont soumises à une limitation de "rate limite": seules trois requêtes sont autorisées par minute.

Pour effectuer une connexion par force brute avec le compte d'une victime, les attaquants utilisent le regroupement de requêtes GraphQL pour contourner la limitation du taux de requêtes, accélérant ainsi l'attaque :

```
POST /graphql
[
  {"query":"mutation{login(username:\"victim\",password:\"password\"){token}}"},
  {"query":"mutation{login(username:\"victim\",password:\"123456\"){token}}"},
  {"query":"mutation{login(username:\"victim\",password:\"qwerty\"){token}}"},
  ...
  {"query":"mutation{login(username:\"victim\",password:\"123\"){token}}"},
]
```

## Scénario #2

Pour mettre à jour l'adresse e-mail associée au compte d'un utilisateur, les clients doivent envoyer une requête API comme celle-ci :

```
PUT /account
Authorization: Bearer <token>

{ "email": "<new_email_address>" }
```

Comme l'API ne demande pas aux utilisateurs de confirmer leur identité en fournissant leur mot de passe actuel, les attanquants qui sont capables de voler le jeton d'authentification pourraient être en mesure de prendre le contrôle du compte de la victime en demandant la réinitialisation du mot de passe après avoir mis à jour l'adresse e-mail du compte de la victime.

## Comment s'en prémunir

* Assurez-vous de connaître tous les flux possibles pour s'authentifier à l'API (mobile/web/liens profonds qui implémentent l'authentification en un clic/etc.). Demandez à vos ingénieurs quels flux vous avez manqués.
* Documentez-vous sur vos mécanismes d'authentification. Assurez-vous de comprendre ce qu'ils sont et comment ils sont utilisés. OAuth n'est pas une authentification, pas plus que les clés API.
* Ne réinventez pas la roue en matière d'authentification, de génération de jetons ou de stockage de mots de passe. Utilisez les standards.
* Les points d'accès de récupération des informations d'identification/mot de passe oublié doivent être traités comme des points d'accès de connexion. Ils doivent être protégés contre les attaques par la force brute : par le blocage de comptes ou la mise en place de "rate limiting" contraignant.
* Exigez une ré-authentification pour les opérations sensibles (par exemple, changer l'adresse e-mail du propriétaire du compte/le numéro de téléphone 2FA).
* Utilisez le [Cheat Sheet d'authentification OWASP][1].
* Là où c'est possible, mettez en œuvre l'authentification multi-facteurs.
* Mettez en œuvre des mécanismes anti-brute force pour atténuer le bourrage d'informations d'identification, les attaques par dictionnaire et les attaques par force brute sur vos points d'accès d'authentification. Ce mécanisme doit être plus strict que les mécanismes de "rate limiting" réguliers sur vos API.
* Mettez en œuvre des mécanismes de [blocage de compte][2]/captcha pour prévenir les attaques par force brute contre des utilisateurs spécifiques. Mettez en œuvre des vérifications de mots de passe faibles.
* Les clés API ne doivent pas être utilisées pour l'authentification des utilisateurs. Elles ne doivent être utilisées que pour l'[authentification des clients API][3].

## Références

### OWASP

* [Authentication Cheat Sheet][1]
* [Key Management Cheat Sheet][4]
* [Credential Stuffing][5]

### Externes

* [CWE-204: Observable Response Discrepancy][6]
* [CWE-307: Improper Restriction of Excessive Authentication Attempts][7]

[1]: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
[2]: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/04-Authentication_Testing/03-Testing_for_Weak_Lock_Out_Mechanism(OTG-AUTHN-003)
[3]: https://cloud.google.com/endpoints/docs/openapi/when-why-api-key
[4]: https://cheatsheetseries.owasp.org/cheatsheets/Key_Management_Cheat_Sheet.html
[5]: https://owasp.org/www-community/attacks/Credential_stuffing
[6]: https://cwe.mitre.org/data/definitions/204.html
[7]: https://cwe.mitre.org/data/definitions/307.html
