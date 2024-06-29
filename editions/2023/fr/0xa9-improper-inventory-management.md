# API9:2023 Improper Inventory Management

| Facteurs de menace/Vecteurs d'attaque | Faiblesse de sécurité | Impacts |
| - | - | - |
| Spécifique à l'API : Exploitabilité **Facile** | Prévalence **Répandue** : Détection **Moyenne** | Technique **Modérée** : Spécifique à l'organisation |
| Les attaquants cherchent généralement à accéder de manière non autorisée à travers d'anciennes versions d'API ou des points d'accès laissés non corrigés et utilisant des exigences de sécurité plus faibles. Dans certains cas, des exploits sont disponibles. Alternativement, ils peuvent accéder à des données sensibles via un tiers avec lequel il n'y a aucune raison de partager des données. | Une documentation obsolète rend plus difficile la recherche et/ou la correction des vulnérabilités. L'absence d'inventaire des actifs et de stratégies de retraite conduit à l'exécution de systèmes non corrigés, entraînant une fuite de données sensibles. Il est courant de trouver des hôtes API inutilement exposés en raison de concepts modernes tels que les microservices, qui facilitent le déploiement et l'indépendance des applications (par exemple, le cloud computing, K8S). Une simple recherche Google Dorking, une énumération DNS ou l'utilisation de moteurs de recherche spécialisés pour divers types de serveurs (webcams, routeurs, serveurs, etc.) connectés à Internet suffiront pour découvrir des cibles. | Les attaquants peuvent accéder à des données sensibles, voire prendre le contrôle du serveur. Parfois, différentes versions/déploiements d'API sont connectés à la même base de données avec des données réelles. Les agents de menace peuvent exploiter des points d'accès obsolètes disponibles dans d'anciennes versions d'API pour accéder à des fonctions d'administration ou exploiter des vulnérabilités connues. |

## L'API est-elle vulnérable ?

Les API modernes sont souvent exposées à des risques de sécurité en raison de la complexité des applications et de la nature connectée des systèmes. Les API sont souvent mal documentées, ce qui rend difficile la recherche et la correction des vulnérabilités. Les API obsolètes ou non corrigées sont des cibles faciles pour les attaquants.

Faire fonctionner plusieurs versions d'une API nécessite des ressources de gestion supplémentaires de la part du fournisseur de l'API et augmente la surface d'attaque.

Une API a un "<ins>angle mort de la documentation</ins>" si :

* Le but de l'hôte de l'API n'est pas clair, et il n'y a pas de réponses explicites aux questions suivantes
    * Dans quel environnement l'API fonctionne-t-elle (par exemple, production, staging, test, développement) ?
    * Qui devrait avoir accès au réseau de l'API (par exemple, public, interne, partenaires) ?
    * Quelle version de l'API est en cours d'exécution ?
* Il n'y a pas de documentation ou la documentation existante n'est pas mise à jour.
* Il n'y a pas de plan de retraite pour chaque version de l'API.
* L'inventaire de l'hôte est manquant ou obsolète.

La visibilité et l'inventaire des flux de données sensibles jouent un rôle important dans le cadre d'un plan de réponse aux incidents, au cas où une violation se produirait du côté du tiers.

Une API a un "<ins>angle mort du flux de données</ins>" si :

* Il y a un "flux de données sensible" où l'API partage des données sensibles avec un tiers et
    * Il n'y a pas de justification commerciale ou d'approbation du flux
    * Il n'y a pas d'inventaire ou de visibilité du flux
    * Il n'y a pas de visibilité approfondie sur le type de données sensibles partagées


## Exemple de scénarios d'attaque

### Scénario #1

Un réseau social a mis en place un mécanisme de limitation du taux qui bloque les attaquants qui utilisent la force brute pour deviner les jetons de réinitialisation de mot de passe. Ce mécanisme n'a pas été mis en place dans le code de l'API lui-même, mais dans un composant séparé entre le client et l'API officielle (`api.socialnetwork.owasp.org`). Un chercheur a trouvé un hôte API bêta (`beta.api.socialnetwork.owasp.org`) qui exécute la même API, y compris le mécanisme de réinitialisation du mot de passe, mais le mécanisme de limitation du taux n'était pas en place. Le chercheur a pu réinitialiser le mot de passe de n'importe quel utilisateur en utilisant une simple force brute pour deviner le jeton à 6 chiffres.

### Scénario #2

Un réseau social permet aux développeurs d'applications indépendantes d'intégrer leurs applications avec lui. Dans le cadre de ce processus, un consentement est demandé à l'utilisateur final, afin que le réseau social puisse partager les informations personnelles de l'utilisateur avec l'application indépendante.

Le flux de données entre le réseau social et les applications indépendantes n'est pas suffisamment restrictif ou surveillé, permettant aux applications indépendantes d'accéder non seulement aux informations de l'utilisateur, mais aussi aux informations privées de tous leurs amis.

Une société de conseil crée une application malveillante et parvient à obtenir le consentement de 270 000 utilisateurs. En raison de la faille, la société de conseil parvient à accéder aux informations privées de 50 000 000 d'utilisateurs. Plus tard, la société de conseil vend les informations à des fins malveillantes.

## Comment s'en prémunir ?

* Inventoriez tous les <ins>hôtes API</ins> et documentez les aspects importants de chacun d'eux, en mettant l'accent sur l'environnement de l'API (par exemple, production, staging, test, développement), qui devrait avoir accès, en réseau, à l'hôte (par exemple, public, interne, partenaires) et la version d'API.
* Inventoriez les <ins>services intégrés</ins> et documentez les aspects importants tels que leur rôle dans le système, les données échangées (flux de données) et leur sensibilité.
* Documentez tous les aspects de votre API tels que l'authentification, les erreurs, les redirections, la limitation du taux, la politique de partage des ressources entre origines (CORS) et les points d'accès, y compris leurs paramètres, requêtes et réponses.
* Générez automatiquement la documentation en adoptant des normes ouvertes. Incluez la génération de documentation dans votre pipeline CI/CD.
* Rendez la documentation de l'API disponible uniquement aux personnes autorisées à utiliser l'API.
* Utilisez des mesures de protection externes telles que des solutions de sécurité spécifiques aux APIs pour toutes les versions exposées de vos API, pas seulement pour la version de production.
* Évitez d'utiliser des données de production avec des déploiements d'API hors production. Si cela est inévitable, ces points d'accès doivent bénéficier du même traitement de sécurité que les points d'accès de production.
* Lorsque les nouvelles versions des API incluent des améliorations de sécurité, effectuez une analyse des risques pour informer des actions de mitigation requises pour les anciennes versions. Par exemple, s'il est possible de rétroporter les améliorations sans casser la compatibilité de l'API plus ancienne ou si vous devez retirer rapidement l'ancienne version et forcer tous les clients à passer à la dernière version.


## Références

### Externes

* [CWE-1059: Incomplete Documentation][1]

[1]: https://cwe.mitre.org/data/definitions/1059.html
