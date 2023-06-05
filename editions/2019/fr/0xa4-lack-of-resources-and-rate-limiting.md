# API4:2019 Lack of Resources & Rate Limiting

| Facteurs de menace / Vecteurs d'attaque | Faille de sécurité | Impact |
| - | - | - |
| Spécifique API : Exploitabilité **2** | Prévalence **3** : Détectabilité **3** | Technique **2** : Spécifique à l'organisation |
| L'exploitation consiste en de simples requêtes d'API. Aucune authentification n'est requise. Des requêtes multiples concurrentes peuvent être effectuées depuis un unique ordinateur local ou en utilisant des ressources d'informatique en nuage. | Il est fréquent de trouver des API qui n'implémentent pas de limitations des requêtes ou dont les limitations ne sont pas correctement paramétrées. | L'exploitation peut aboutir à un déni de service, rendant l'API incapable de répondre ou même indisponible. |

## L'API est-elle vulnérable ?

Les requêtes d'API consomment des ressources réseau, processeur, mémoire et de stockage. La quantité de ressources requises pour satisfaire à une requête dépendent grandement des données entrées par l'utilisateur et de la logique métier du point d'accès. De plus, il faut considérer le fait que les requêtes de différents clients de l'API sont en concurrence pour l'utilisation des ressources. Une API est vulnérable si au moins une des limites suivantes est manquante ou incorrectement paramétrée (c'est-à-dire trop basse / trop élevée) :

* durée maximale d'exécution
* Maximum de mémoire allouable
* Nombre de descripteurs de fichiers
* Nombre de processus
* Taille de la charge utile de la requête (ex. téléversement)
* Nombre de requêtes par client / ressource
* Nombre d'enregistrements par page à retourner pour chaque réponse individuelle

## Exemples de scénarios d'attaque

### Scénario #1

Un attaquant téléverse une grande image en émettant une requête POST vers `/api/v1/images`.
Lorsque le téléversement est terminé, l'API crée plusieurs vignettes avec différentes tailles. Du fait de la taille de l'image téléversée, la mémoire disponible est saturée par la création des vignettes et l'API ne répond plus.

### Scénario #2

Nous avons une application qui contient la liste des utilisateurs avec une limite de `200` utilisateurs par page. La liste des utilisateurs est obtenue auprès du serveur avec la requête suivante : `/api/users?page=1&size=200`. Un attaquant change la valeur de `size`
en `200 000`, entrainant des problèmes de perfomance sur la base de données. De ce fait, l'API ne répond plus et n'est plus capable de traiter d'autres requêtes de ce client ou d'autres clients (autrement dit déni de service).

Le même scénario peut être utilisé pour générer des erreurs Integer Overflow ou Buffer Overflow.

## Comment s'en prémunir

* Docker permet facilement de limiter [la mémoire][1], [le processeur][2], [le nombre de redémarrages][3],
  [les descripteurs de fichiers et les processus][4].
* Implémentez une limite du nombre d'appels à l'API qu'un client peut effectuer
  sur une période donnée.
* Notifiez le client quand la limite est dépassée en indiquant la limite et quand
  cette limite sera remise à zéro.
* Ajoutez des validations adaptées côté serveur pour les paramètres fournis en
  ou fournis en corps de requête, en particulier ceux qui contrôlent le nombre
  d'enregistrements à retourner dans la réponse.
* Définissez et appliquez une taille maximale pour les données entrées en paramètres
 et les charges utiles, comme des longueurs maximales pour les chaines de
  caractères et un nombre maximal d'éléments dans les tableaux.


## Références

### OWASP

* [Blocking Brute Force Attacks][5]
* [Docker Cheat Sheet - Limit resources (memory, CPU, file descriptors,
  processes, restarts)][6]
* [REST Assessment Cheat Sheet][7]

### Externes

* [CWE-307: Improper Restriction of Excessive Authentication Attempts][8]
* [CWE-770: Allocation of Resources Without Limits or Throttling][9]
* “_Rate Limiting (Throttling)_” - [Security Strategies for Microservices-based
  Application Systems][10], NIST

[1]: https://docs.docker.com/config/containers/resource_constraints/#memory
[2]: https://docs.docker.com/config/containers/resource_constraints/#cpu
[3]: https://docs.docker.com/engine/reference/commandline/run/#restart-policies---restart
[4]: https://docs.docker.com/engine/reference/commandline/run/#set-ulimits-in-container---ulimit
[5]: https://www.owasp.org/index.php/Blocking_Brute_Force_Attacks
[6]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/Docker_Security_Cheat_Sheet.md#rule-7---limit-resources-memory-cpu-file-descriptors-processes-restarts
[7]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/REST_Assessment_Cheat_Sheet.md
[8]: https://cwe.mitre.org/data/definitions/307.html
[9]: https://cwe.mitre.org/data/definitions/770.html
[10]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-204-draft.pdf
