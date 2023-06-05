# API3:2019 Excessive Data Exposure

| Facteurs de menace / Vecteurs d'attaque | Faille de sécurité | Impact |
| - | - | - |
| Spécifique API : Exploitabilité **3** | Prévalence **2** : Détectabilité **2** | Technique **2** : Spécifique à l'organisation |
| L'exploitation d'exposition excessive de données est simple, et est généralement effectuée en écoutant le trafic pour analyser les réponses de l'API, à la recherche de données sensibles qui ne devraient pas être retournées à l'utilisateur. | Les API comptent sur les clients pour effectuer le filtrage des données. Comme les API sont utilisées comme sources de données, les développeurs les implémentent parfois de manière générique sans penser au caractère sensible des données diffusées. En général les outils automatiques ne permettent pas de détecter ce type de vulnérabilité car il est difficile de faire la différence entre les données légitimement retournées par l'API, et des données sensibles qui ne devraient pas être retournées sans une compréhension en profondeur de l'application. | L'exposition excessive de données conduit généralement à la diffusion de données sensibles. |

## L'API est-elle vulnérable ?

Par conception, l'API retourne des données sensibles au client. De plus, ces données sont généralement filtrées côté client avant d'être présentées à l'utilisateur. Un attaquant peut facilement écouter le trafic et voir les données sensibles.

## Exemples de scénarios d'attaque

### Scénario #1

L'équipe mobile utilise le point d'accès `/api/articles/{articleId}/comments/{commentId}`
dans la vue des articles pour le rendu des métadonnées des commentaires. Ecoutant le trafic de l'application mobile, un attaquant découvre que d'autres données sensibles relatives à l'auteur du commentaire sont également retournées. L'implémentation du point d'accès utilise une méthode générique `toJSON()` sur le modèle `User`, qui contient des données personnelles, pour sérialiser l'objet.

### Scénario #2

Un système de surveillance à base d'IoT permet aux administrateurs de créer des utilisateurs avec différentes permissions. Un administrateur a créé un compte utilisateur pour un nouvel agent de sécurité qui ne devrait avoir accès qu'à certains bâtiments spécifiques sur le site. Quand l'agent de sécurité utilise son appli mobile, un appel d'API est effectué vers `/api/sites/111/cameras` pour recevoir des données à propos des caméras disponibles et les montrer sur un tableau de bord. La réponse contient une liste avec des informations sur les caméras au format suivant : `{"id":"xxx","live_access_token":"xxxx-bbbbb","building_id":"yyy"}`.
Si l'interface graphique du client montre uniquement les caméras auxquelles l'agent de sécurité doit avoir accès, la réponse de l'API contient en réalité la liste complète de toutes les caméras présentes sur le site.

## Comment s'en prémunir

* Ne comptez jamais sur le client d'API pour filtrer des données sensibles.
* Passez en revue les réponses de l'API pour vous assurer qu'elles contiennent
  uniquement des données nécessaires.
* Les ingénieurs backend devraient toujours se poser la question "qui est le
  consommateur des données ?" avant d'exposer un nouveau point d'accès d'API.
* Évitez les méthodes génériques telles que `to_json()` ou `to_string()`.
  Au lieu de cela, choisissez les éléments précis que vous voulez vraiment retourner.
* Classifiez les données sensibles et personnelles que votre application stocke et
  manipule, et passez en revue tous les appels d'API qui retournent de telles
  données pour voir si les réponses posent des problèmes de sécurité.
* Implémentez un mécanisme de réponse basé sur un schéma de validation afin d'ajouter un niveau de sécurité
  supplémentaire. Au sein de ce mécanisme définissez et validez les données retournées
  par toutes les méthodes d'API, erreurs comprises.


## Références

### Externes

* [CWE-213: Intentional Information Exposure][1]

[1]: https://cwe.mitre.org/data/definitions/213.html
