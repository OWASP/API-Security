# API6:2019 - Mass Assignment

| Facteurs de menace / Vecteurs d'attaque | Faille de sécurité | Impact |
| - | - | - |
| Spécifique API : Exploitabilité **2** | Prévalence **2** : Détectabilité **2** | Technique **2** : Spécifique à l'organisation |
| L'exploitation requiert généralement une compréhension de la logique métier, des relations entre objets, et de la structure de l'API. L'exploitation de l'assignation massive est plus facile dans les API, car par conception elles exposent l'implémentation sous-jacente de l'application ainsi que les noms des attributs. | Les frameworks modernes encouragent les développeurs à utiliser des fonctions qui lient automatiquement les entrées du client aux variables du code et aux objets internes. Des attaquants peuvent utiliser cette méthodologie pour modifier ou écraser des attributs d'objets sensibles que les développeurs n'avaient jamais eu l'intention d'exposer. | L'exploitation peut conduire à l'élévation des privilèges, la falsification des données, au contournement de mécanismes de sécurité, et plus encore. |

## L'API est-elle vulnérable ?

Les objets des applications modernes peuvent posséder de nombreux attributs.
Certains de ces attributs doivent pouvoir être actualisés par le client (ex :
`user.first_name` ou `user.address`) et d'autres ne doivent pas pouvoir l'être
(ex : drapeau `user.is_vip`).

Un point d'accès d'API est vulnérable s'il convertit automatiquement des
paramètres client en attributs objet internes, sans prendre en compte la
sensibilité et le niveau d'exposition de ces attributs. Ceci pourrait
permettre à un attaquant d'actualiser des attributs d'objets auxquels il ne
devrait pas avoir accès.

Exemples d'informations sensibles :

* **Attributs liés à des permissions** : `user.is_admin`, `user.is_vip` doivent
  être définis uniquement par des administrateurs.
* **Attributs dépendant de processus** : `user.cash` ne doit être défini au  
  niveau interne qu'après vérification du paiement.
* **Attributs internes** : `article.created_time` doit être
  défini uniquement par l'application.

## Exemples de scénarios d'attaque

### Scénario #1

Une application de covoiturage permet à l'utilisateur de modifier les
informations de base de son profil. Au cours de ce processus, un appel d'API
est envoyé à `PUT /api/v1/users/me` avec l'objet JSON légitime suivant :

```json
{"user_name":"inons","age":24}
```

La requête `GET /api/v1/users/me` comporte un attribut supplémentaire sur le
solde du compte :

```json
{"user_name":"inons","age":24,"credit_balance":10}
```

L'attaquant rejoue la première requête avec la charge utile suivante :

```json
{"user_name":"attacker","age":60,"credit_balance":99999}
```

Le point d'accès étant vulnérable à l'assignation massive, l'attaquant dispose
du crédit sans avoir payé.

### Scénario #2

Un portail de partage de vidéos permet aux utilisateurs de téléverser et de
télécharger du contenu dans différents formats. Un attaquant qui explore l'API
découvre que le point d'accès `GET /api/v1/videos/{video_id}/meta_data`
retourne un objet JSON avec les attributs de la vidéo. L'un des attributs est `"mp4_conversion_params":"-v codec h264"`, qui indique que l'application
utilise une commande shell pour convertir la vidéo.

L'attaquant a également découvert que le point d'accès
`POST /api/v1/videos/new` est vulnérable à l'assignation massive et permet au
client de définir n'importe quel attribut de l'objet vidéo. L'attaquant définit
une valeur malveillante de la manière suivante :
`"mp4_conversion_params":"-v codec h264 && format C:/"`. Cette valeur va
entrainer une injection de commande shell quand l'attaquant chargera la vidéo
au format MP4.

## Comment s'en prémunir

* Si possible, évitez d'utiliser des fonctions qui lient automatiquement une
  saisie client à des variables du code ou des objets internes.
* Autorisez uniquement les attributs qui doivent pouvoir être actualisés par le
  client.
* Utilisez les fonctionnalités natives pour interdire les attributs qui ne
  doivent pas être accessibles aux clients.
* Si applicable, définissez et imposez des schémas pour la validation des
  données d'entrée de la charge utile .

## Références

### Externes

* [CWE-915: Improperly Controlled Modification of Dynamically-Determined Object Attributes][1]

[1]: https://cwe.mitre.org/data/definitions/915.html
