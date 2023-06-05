# API2:2019 Broken User Authentication

| Facteurs de menace / Vecteurs d'attaque | Faille de sécurité | Impact |
| - | - | - |
| Spécifique API : Exploitabilité **3** | Prévalence **2** : Détectabilité **2** | Technique **3** : Spécifique à l'organisation |
| L'authentification dans les API est un mécanisme complexe et source de confusions. Les ingénieurs logiciel et en sécurité peuvent avoir une vision faussée sur les limites que peut avoir un shéma d'authentification et la manière de l'implanter correctement. De plus, le mécanisme d'authentification est une cible facile pour les attaquants, dans la mesure où elle est accessible à tous. Ces deux points rendent le composant d'authentification potentiellement vulnérable à de nombreuses exploitations. | On distingue deux sous-problèmes : 1. Manque de mécanismes de protection : les points d'accès d'API responsables de l'authentification doivent être traités différemment des autres points d'accès et doivent implémenter des niveaux de protection supplémentaires 2. Mauvaise implémentation du mécanisme : Le mécanisme est utilisé / implémenté sans prendre en considération les vecteurs d'attaque, ou n'est pas utilisé à bon escient (ex. un mécanisme d'authentification conçu pour des clients IoT n'est probablement pas le bon choix pour des applications web). | Des attaquants peuvent prendre le contrôle des comptes d'autres utilisateurs dans le système, lire leurs données personnelles, et effectuer des actions sensibles à leur place, comme des transactions financières ou l'envoi de messages personnels. |

## L'API est-elle vulnérable ?

Les points d'accès et les flux d'authentification sont des ressources qui doivent être protégées. “Mot de passe oublié / changement de mot de passe” doivent être traités de la même manière que les mécanismes d'authentification.

Une API est vulnérable si elle :
* Permet le [bourrage d'identifiants][1] quand l'attaquant dispose d'une liste de noms
  d'utilisateurs et de mots de passe.
* Permet à des attaquants d'effectuer une attaque par force brute sur le même compte
  utilisateur, sans présenter de captcha ou de mécanisme de blocage.
* Permet des mots de passe faibles.
* Envoie des éléments d'authentification sensibles, tels que des tokens
  d'authentification ou des mots de passe dans l'URL.
* Ne valide pas l'authenticité des tokens.
* Accepte des tokens JWT non signés / faiblement signés (`"alg":"none"`) / ne
  valide pas leur date d'expiration.
* Utilise des mots de passe en clair, non chiffrés ou faiblement hashés.
* Utilise des clés de chiffrement faibles.

## Exemples de scénarios d'attaque

## Scenario #1

Le [bourrage d'identifiants][1] (utilisant des [listes de noms d'utilisateurs / mots de passe connus][2]), est une attaque courante. Si une application n'implémente pas de protections automatisées contre les menaces ou le bourrage d'identifiants, l'application peut être utilisée comme oracle à mots de passe (testeur) pour déterminer si les identifiants sont valides.

## Scenario #2

Un attaquant commence le processus de récupération de mot de passe en émettant une requête POST vers `/api/system/verification-codes` comportant le nom d'utilisateur dans le corps de la requête. Ensuite un token à 6 chiffres est envoyé par SMS sur le téléphone de la victime. Comme l'API n'implémente pas de mécanisme limitant les requêtes, l'attaquant peut tester toutes les combinaisons possibles en utilisant un script multi-threadé contre le point d'accès `/api/system/verification-codes/{smsToken}` pour découvrir le bon token en l'espace de quelques minutes.

## Comment s'en prémunir

* Assurez-vous de connaitre tous les flux possibles pour s'identifier auprès de
  l'API (mobile / web / liens profonds qui implémentent l'authentification en un
  clic / etc.)
* Demandez à vos ingénieurs quels flux vous avez oubliés.
* Documentez-vous sur vos mécanismes d'authentification. Assurez-vous de comprendre
  ce qui est utilisé et comment. OAuth n'est pas une authentification, les clés
  d'API non plus.
* Ne réinventez pas la roue en matière d'authentification, de génération de tokens,
  de stockage de mots de passe. Utilisez les standards.
* Les points d'accès de récupération / d'oubli de mot de passe doivent être traités
  comme des points d'accès de login en termes de force brute, limitation de requêtes
  et de protection par blocage.
* Utilisez la [cheatsheet OWASP Authentication ][3].
* Quand c'est possible, implémentez l'authentification multi-facteurs.
* Implémentez des mécanismes anti force brute pour empêcher le bourrage
  d'identifiants, les attaques par dictionnaire, et les attaques par force brute
  contre vos points d'accès d'authentification. Ce mécanisme devrait être plus strict
  que le mécanisme de limitation de requêtes normal de votre API.
* Implémentez [le blocage de compte][4] / un mécanisme de captcha pour empêcher
  l'emploi de force brute contre des utilisateurs spécifiques. Implementez des
  mesures pour une meilleure robustesse des mots de passe.
* Les clés d'API ne doivent pas être utilisées pour authentifier un utilisateur,
  mais pour les [applications clientes / authentification de projets][5].

## Références

### OWASP

* [OWASP Key Management Cheat Sheet][6]
* [OWASP Authentication Cheatsheet][3]
* [Credential Stuffing][1]

### Externes

* [CWE-798: Use of Hard-coded Credentials][7]

[1]: https://www.owasp.org/index.php/Credential_stuffing
[2]: https://github.com/danielmiessler/SecLists
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
[4]: https://www.owasp.org/index.php/Testing_for_Weak_lock_out_mechanism_(OTG-AUTHN-003)
[5]: https://cloud.google.com/endpoints/docs/openapi/when-why-api-key
[6]: https://www.owasp.org/index.php/Key_Management_Cheat_Sheet
[7]: https://cwe.mitre.org/data/definitions/798.html
