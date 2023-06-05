# API7:2019 Security Misconfiguration

| Facteurs de menace / Vecteurs d'attaque | Faille de sécurité | Impact |
| - | - | - |
| Spécifique API : Exploitabilité **3** | Prévalence **3** : Détectabilité **3** | Technique **2** : Spécifique à l'organisation |
| Les attaquants essaieront souvent de trouver des failles non corrigées, des points d'accès courants, ou des fichiers et des répertoires non protégés pour obtenir un accès non autorisé ou des informations sur le système. | Des erreurs de configuration de sécurité peuvent se produire à toutes les couches de l'API, depuis la couche réseau jusqu'à la couche applicative. Il existe des outils automatisés pour détecter et exploiter des erreurs de configuration telles que des services non nécessaires ou d'anciennes options. | Les erreurs de configuration de sécurité peuvent non seulement exposer des données utilisateur confidentielles, mais aussi des informations système qui peuvent aboutir à une compromission complète du serveur. |

## L'API est-elle vulnérable ?

L'API peut être vulnérable si :

* Un durcissement approprié de la sécurité est manquant sur n'importe quelle
  partie de la pile applicative, ou si elle possède des permissions mal
  configurées au niveau de services cloud.
* Les dernières mises à jour de sécurité ne sont pas appliquées, ou les
  systèmes sont obsolètes.
* Des fonctionnalités non nécessaires sont déployées (ex : verbes HTTP).
* La sécurité de la couche de transport (TLS) est manquante.
* Les instructions d'en-têtes sécurisées ne sont pas envoyées au client 
  (e.g., [Security Headers][1]).
* La politique de partage de ressources entre origines multiples (CORS) est
  manquante ou mal définie.
* Les messages d'erreurs incluent des traces de pile d'exécution, ou exposent
  d'autres informations sensibles.

## Exemples de scénarios d'attaque

### Scénario #1

Un attaquant trouve le fichier `.bash_history` dans le répertoire racine du
serveur, qui contient les commandes utilisées par l'équipe DevOps pour accéder
à l'API :

```
$ curl -X GET 'https://api.server/endpoint/' -H 'authorization: Basic Zm9vOmJhcg=='
```

Un attaquant pourrait aussi découvrir de nouveaux points d'accès de l'API qui
sont uniquement utilisés par l'équipe DevOps et qui ne sont pas documentés.

### Scénario #2

Pour cibler un service spécifique, un attaquant utilise un moteur de recherche
populaire pour chercher les ordinateurs directement accessibles depuis
l'internet. L'attaquant trouve un hôte faisant tourner un système populaire de
gestion de bases de données, qui écoute sur le port par défaut. L'hôte
utilisait la configuration par défaut, dans laquelle l'authentification est
désactivée par défaut, et l'attaquant a obtenu accès à des millions
d'enregistrements contenant des données personnelles, des préférences
personnelles, et des données d'authentification.

### Scénario #3

En inspectant le trafic d'une application mobile un attaquant découvre que tout
le trafic n'est pas effectué avec un protocole sécurisé (ex : TLS). L'attaquant
le constate en particulier pour le téléchargement des images de profil. Comme
l'interaction est binaire, malgré le fait que le trafic API est effectué sur un
protocole sécurisé, l'attaquant remarque un schéma au niveau de la taille des
réponses de l'API, qu'il utilise pour pister les préférences utilisateur à
partir du contenu rendu (ex : images de profil).

## Comment s'en prémunir

Le cycle de vie de l'API devrait inclure :

* Un processus de durcissement permettant le déploiement rapide et facile d'un
  environnement correctement verrouillé.
* Une tâche pour évaluer et actualiser les configurations sur l'ensemble des
  couches de l'API. L'évaluation devrait couvrir : les fichiers
  d'orchestration, les composants d'API, et les services cloud
  (ex : permissions des compartiments de stockage S3).
* Un canal de communication sécurisé pour tous les accès API d'interaction
  avec les éléments statiques (ex : images).
* Un processus automatisé pour évaluer en continu l'efficacité de la
  configuration et des réglages dans tous les environnements.

De plus :

* Pour éviter que des traces d'appels lors d'exceptions et d'autres informations importantes
  ne soient renvoyées aux attaquants, si applicable, définissez et implémentez
  des schémas pour toutes les réponses y compris les erreurs.
* Assurez-vous que l'API ne soit accessible qu'avec des verbes HTTP
  spécifiques. Tous les autres verbes HTTP doivent être désactivés (ex :`HEAD`).
* Les API devant être accessibles via des clients basés sur des navigateurs
  (ex : WebApp en front-end) doivent implémenter une politique appropriée de 
  partage de ressources entre origines multiples (CORS).

## Références

### OWASP

* [OWASP Secure Headers Project][1]
* [OWASP Testing Guide: Configuration Management][2]
* [OWASP Testing Guide: Testing for Error Codes][3]
* [OWASP Testing Guide: Test Cross Origin Resource Sharing][9]

### Externes

* [CWE-2: Environmental Security Flaws][4]
* [CWE-16: Configuration][5]
* [CWE-388: Error Handling][6]
* [Guide to General Server Security][7], NIST
* [Let’s Encrypt: a free, automated, and open Certificate Authority][8]

[1]: https://www.owasp.org/index.php/OWASP_Secure_Headers_Project
[2]: https://www.owasp.org/index.php/Testing_for_configuration_management
[3]: https://www.owasp.org/index.php/Testing_for_Error_Code_(OTG-ERR-001)
[4]: https://cwe.mitre.org/data/definitions/2.html
[5]: https://cwe.mitre.org/data/definitions/16.html
[6]: https://cwe.mitre.org/data/definitions/388.html
[7]: https://csrc.nist.gov/publications/detail/sp/800-123/final
[8]: https://letsencrypt.org/
[9]: https://www.owasp.org/index.php/Test_Cross_Origin_Resource_Sharing_(OTG-CLIENT-007)
