# API9:2019 Improper Assets Management

| Facteurs de menace / Vecteurs d'attaque | Faille de sécurité | Impact |
| - | - | - |
| Spécifique API : Exploitabilité **3** | Prévalence **3** : Détectabilité **2** | Technique **2** : Spécifique à l'organisation |
| Les anciennes versions des API n'ont souvent pas bénéficié des correctifs de sécurité et sont un moyen facile pour compromettre des systèmes sans avoir à affronter des mécanismes de sécurité de pointe, qui peuvent avoir été mis en place pour protéger les versions les plus récentes de l'API. | Une documentation obsolète rend plus difficile la recherche et / ou la correction de vulnérabilités. L'absence d'inventaire des points actifs et de stratégies de retrait pour ceux ne devant plus être utilisés, conduit à faire tourner des systèmes dépourvus de correctifs de sécurité, entrainant la divulgation de données sensibles. Des hôtes d'API inutilement exposés sont fréquemment trouvés du fait des concepts modernes comme les micro-services, qui rendent les applications faciles à déployer et indépendantes (ex : cloud, aussi appelé informatique en nuage, Kubernetes). | Les attaquants peuvent obtenir accès à des données sensibles, et même prendre le contrôle du serveur via d'anciennes versions non corrigées de l'API connectées à la même base de données. |

## L'API est-elle vulnérable ?

L'API peut être vulnérable si :

* L'objectif de l'hôte de l'API n'est pas clair, et il n'y a pas de réponses
  explicites aux questions suivantes :
    * Dans quel environment tourne l'API (ex : production, staging, test,
      développement) ?
    * Qui doit avoir un accès réseau à l'API (ex : public, interne,
      partenaires) ?
    * Quelle version de l'API tourne ?
    * Quelles données sont collectées et traitées par l'API (ex : données
      personnelles) ?
    * Quel est le flux des données ?
* Il n'y a pas de documentation, ou la documentation existante n'est pas mise
  à jour.
* Il n'y a pas de plan pour le retrait / la désactivation (des points d'accès
  devenus obsolètes) par version d'API.
* L'inventaire des hôtes est manquant ou obsolète.
* L'inventaire des services intégrés, en propre ou par des tiers, est manquant
  ou obsolète.
* Des versions anciennes ou antérieures de l'API tournent sans correctifs.

## Exemples de scénarios d'attaque

### Scénario #1

Après avoir repensé ses applications, un service local de recherche avait
laissé une ancienne version de l'API (`api.someservice.com/v1`) tourner sans
protection, avec un accès à la base de données clients. En ciblant l'une des
applications dernièrement publiées, un attaquant a trouvé l'adresse de l'API (`api.someservice.com/v2`). En remplaçant `v2` par `v1` dans l'URL l'attaquant
a obtenu accès à l'ancienne API non protégée, exposant les données personnelles
de plus de 100 millions d'utilisateurs.

### Scénario #2

Un réseau social avait mis en place un mécanisme de limitation du nombre de
requêtes pour empêcher des attaquants d'employer la force brute pour deviner
les jetons (Token) de réinitialisation des mots de passe. Ce mécanisme n'était pas
implémenté au niveau du code de l'API elle-même, mais dans un composant séparé
situé entre le client et l'API officielle (`www.socialnetwork.com`).
Un chercheur découvrit un hôte d'API en beta
(`www.mbasic.beta.socialnetwork.com`) faisant tourner la même API, y
compris le mécanisme de réinitialisation du mot de passe, mais était dépourvu
du mécanisme de limitation du nombre de requêtes. Le chercheur fut alors en mesure
de réinitialiser le mot de passe de n'importe quel utilisateur simplement en
utilisant la force brute pour deviner le token à 6 chiffres.

## Comment s'en prémunir

* Inventoriez tous les hôtes d'API et documentez les aspects importants de
  chacun d'entre eux, en vous concentrant sur l'environnement de l'API (ex :
  production, staging, test, développement), sur qui devrait avoir un accès
  réseau à l'hôte (ex : public, interne, partenaires) et les versions de l'API.
* Inventoriez les systèmes intégrés et documentez les aspects importants tels
  que leur rôle dans le système, quelles données sont échangées (flux des
  données) et leur sensibilité.
* Documentez tous les aspects de votre API et notamment l'authentification, les
  erreurs, les redirections, la limitation du nombre de requêtes, la politique
  de partage de ressources entre origines multiples (CORS) et les points
  d'accès, incluant leurs paramètres, les requêtes et les réponses.
* Générez la documentation automatiquement en adoptant des standards ouverts.
  Intégrez cette génération automatique de la documentation dans votre processus de déploiement continu CI/CD.
* Donnez accès à la documentation de l'API aux personnes autorisées à utiliser
  l'API.
* Utilisez des mesures de protection externes telles les pare-feux de
  sécurité pour API, et ce, pour toutes les versions exposées de vos API, pas
  seulement pour la version courante en production.
* Évitez d'utiliser des données de production avec des déploiements d'API
  autres que ceux de production. Si vous ne pouvez l'évitez, ces points d'accès
  doivent bénéficier du même niveau de sécurité que ceux de production.
* Lorsque de nouvelles versions d'API intègrent des améliorations de
  sécurité, effectuez une analyse de risque pour décider les actions
  d'atténuation requises pour l'ancienne version : par exemple, s'il est ou non
  possible de rétro-porter les améliorations sans rompre la compatibilité ou si
  vous devez retirer rapidement l'ancienne version et forcer tous les clients à
  passer à la dernière version.

## Références

### Externes

* [CWE-1059: Incomplete Documentation][1]
* [OpenAPI Initiative][2]

[1]: https://cwe.mitre.org/data/definitions/1059.html
[2]: https://www.openapis.org/
