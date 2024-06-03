# API3:2023 Broken Object Property Level Authorization

| Facteurs de menace / Vecteurs d'attaque | Faille de sécurité | Impact |
| - | - | - |
| Spécifique à l'API : Exploitabilité **Facile** | Prévalence **Courante** : Détectabilité **Facile** | Technique **Modérée** : Spécifique à l'organisation |
| Les API ont tendance à exposer des points d'accès qui retournent toutes les propriétés d'un objet. Cela est particulièrement vrai pour les API REST. Pour d'autres protocoles tels que GraphQL, il peut être nécessaire de formuler des requêtes spécifiques pour annoncer quelles propriétés doivent être retournées. Identifier ces propriétés supplémentaires qui peuvent être manipulées demande plus d'efforts, mais il existe quelques outils automatisés disponibles pour aider dans cette tâche. | L'inspection des réponses API suffit pour identifier les informations sensibles dans les représentations des objets retournés. Le fuzzing est généralement utilisé pour identifier des propriétés supplémentaires (cachées). L'écriture d'une requête API spécifique et l'analyse de sa réponse peut permettre de savoir si ces propriétés peuvent être modifiées. Une analyse des effets secondaires peut être nécessaire si la propriété cible n'est pas retournée dans la réponse API. | Un accès non autorisé aux propriétés d'objet privées/sensibles peut entraîner une divulgation de données, une perte de données ou une corruption de données. Dans certaines circonstances, un accès non autorisé aux propriétés d'objet peut entraîner une élévation de privilèges ou une prise de contrôle partielle/totale du compte. |

## L'API est-elle vulnérable ?

Lorsqu'un utilisateur est autorisé à accéder à un objet en utilisant un point d'accès API, il est important de valider que l'utilisateur à le droit d'accéder aux propriétés spécifiques de l'objet.

Un point d'accès API est vulnérable si :

* Le point d'accès API expose des propriétés d'un objet qui sont considérées comme sensibles et qui ne devraient pas être lues par l'utilisateur. (précédemment nommé : "[Excessive Data Exposure][1]")
* Le point d'accès API permet à un utilisateur de modifier, d'ajouter ou de supprimer la valeur d'une propriété sensible de l'objet à laquelle l'utilisateur ne devrait pas avoir accès (précédemment nommé : "[Mass Assignment][2]")

## Exemple de scénarios d'attaque

### Scénario #1

Une application de rencontres permet à un utilisateur de signaler d'autres utilisateurs pour un comportement inapproprié.
Dans le cadre de ce processus, l'utilisateur clique sur un bouton "signaler", et l'appel API suivant est déclenché :

```
POST /graphql
{
  "operationName":"reportUser",
  "variables":{
    "userId": 313,
    "reason":["offensive behavior"]
  },
  "query":"mutation reportUser($userId: ID!, $reason: String!) {
    reportUser(userId: $userId, reason: $reason) {
      status
      message
      reportedUser {
        id
        fullName
        recentLocation
      }
    }
  }"
}
```

Le point d'accès API est vulnérable car il permet à l'utilisateur authentifié d'accéder à des propriétés sensibles de l'objet utilisateur, telles que "fullName" et "recentLocation", qui ne sont pas censées être accessibles par d'autres utilisateurs.

### Scénario #2

Une plateforme de location en ligne, qui propose à un type d'utilisateurs ("hôtes") de louer leur appartement à un autre type d'utilisateurs ("invités"), exige que l'hôte accepte une réservation faite par un invité, avant de facturer l'invité pour le séjour.

Dans le cadre de ce processus, un appel API est envoyé par l'hôte à `POST /api/host/approve_booking` avec la payload suivante :

```
{
  "approved": true,
  "comment": "Check-in is after 3pm"
}
```

L'hôte rejoue la requête légitime, et ajoute la payload malveillante suivante :

```
{
  "approved": true,
  "comment": "Check-in is after 3pm",
  "total_stay_price": "$1,000,000"
}
```

Le point d'accès API est vulnérable car il n'y a pas de validation des droits d'accès de l'hôte à la propriété d'objet - `total_stay_price`, et l'invité sera facturé plus qu'il ne le devrait.

### Scénario #3

Un réseau social basé sur de courtes vidéos, applique un filtrage de contenu restrictif et une censure. Même si une vidéo téléchargée est bloquée, l'utilisateur peut modifier la description de la vidéo en utilisant la requête API suivante :

```
PUT /api/video/update_video

{
  "description": "a funny video about cats"
}
```

Un utilisateur frustré peut rejouer la requête légitime, et ajouter la payload malveillante suivante :

```
{
  "description": "a funny video about cats",
  "blocked": false
}
```

Le point d'accès API est vulnérable car il n'y a pas de validation si l'utilisateur devrait avoir accès à la propriété d'objet - `blocked`, et l'utilisateur peut changer la valeur de `true` à `false` et débloquer son propre contenu bloqué.

## Comment s'en prémunir

* Lors de l'exposition d'un objet à l'aide d'un point d'accès API, assurez-vous toujours que l'utilisateur a accès aux propriétés de l'objet que vous exposez.
* Évitez d'utiliser des méthodes génériques telles que `to_json()` et `to_string()`. Au lieu de cela, choisissez spécifiquement les propriétés de l'objet que vous souhaitez retourner.
* Si possible, évitez d'utiliser des fonctions qui lient automatiquement l'entrée du client à des variables dans du code, des objets internes ou des propriétés d'objet ("Mass Assignment").
* Autorisez uniquement les modifications des propriétés de l'objet qui peuvent être mises à jour par le client.
* Mettez en œuvre un mécanisme de validation des réponses basé sur un schéma en tant que couche de sécurité supplémentaire. Dans le cadre de ce mécanisme, définissez et appliquez les données retournées par toutes les méthodes API.
* Gardez les structures de données retournées au strict minimum, conformément aux exigences commerciales/fonctionnelles pour le point d'accès.

## Références

### OWASP

* [API3:2019 Excessive Data Exposure - OWASP API Security Top 10 2019][1]
* [API6:2019 - Mass Assignment - OWASP API Security Top 10 2019][2]
* [Mass Assignment Cheat Sheet][3]

### Externes

* [CWE-213: Exposure of Sensitive Information Due to Incompatible Policies][4]
* [CWE-915: Improperly Controlled Modification of Dynamically-Determined Object Attributes][5]

[1]: https://owasp.org/API-Security/editions/2019/en/0xa3-excessive-data-exposure/
[2]: https://owasp.org/API-Security/editions/2019/en/0xa6-mass-assignment/
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Mass_Assignment_Cheat_Sheet.html
[4]: https://cwe.mitre.org/data/definitions/213.html
[5]: https://cwe.mitre.org/data/definitions/915.html
