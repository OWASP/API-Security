# API5:2019 Broken Function Level Authorization

| Facteurs de menace / Vecteurs d'attaque | Faille de sécurité | Impact |
| - | - | - |
| Spécifique API : Exploitabilité **3** | Prévalence **2** : Détectabilité **1** | Technique **2** : Spécifique à l'organisation |
| L'exploitation requiert que l'attaquant envoie des appels d'API légitimes vers un point d'accès d'API auquel il ne devrait pas avoir accès. Ces points d'accès peuvent être exposés à des utilisateurs anonymes ou à des utilisateurs normaux dépourvus de privilèges. Il est plus facile de découvrir ces failles dans les API car les API sont plus structurées, et le mode d'accès à certaines fonctions est plus prévisible (ex : remplacer la méthode HTTP GET par PUT, ou changer la chaine "users" de la requête en "admins". | Les contrôles d'autorisation pour une fonction ou une ressource sont généralement gérés via la configuration, et parfois au niveau du code. L'implémentation de contrôles appropriés peut être source de confusion, car les applications modernes peuvent contenir de nombreux types de rôles ou de groupes et une hiérarchie des utilisateurs complexe (ex : sous-utilisateurs, utilisateurs avec plusieurs rôles). | Ces failles permettent aux attaquants d'accéder à des fonctionnalités non autorisées. Les tâches administratives constituent des cibles principales pour ce type d'attaque. |

## L'API est-elle vulnérable ?

La meilleure manière de trouver des problèmes de niveaux d'accès aux fonctionnalités consiste à effectuer une analyse approfondie du mécanisme d'autorisation, tout en gardant à l'esprit la hiérarchie des utilisateurs, les différents rôles ou groupes dans l'application, et à poser les questions suivantes :

* Un utilisateur normal peut-il accéder à des points d'accès d'administration ?
* Un utilisateur peut-il effectuer des actions sensibles (ex : création,
  modification ou suppression) auxquelles il ne devrait pas avoir accès en
  changeant simplement la méthode HTTP (ex : de `GET` à `DELETE`) ?
* Un utilisateur du groupe X peut-il accéder à une fonction qui ne devrait être
  accessible qu'aux utilisateurs du groupe Y, simplement en devinant l'URL du
  point d'accès et les paramètres (ex : `/api/v1/users/export_all`) ?

Ne supposez pas qu'un point d'accès d'API est normal ou administrateur
uniquement sur la base du chemin de l'URL.

Si les développeurs peuvent choisir d'exposer la plupart des points d'accès
d'administration sous un chemin relatif spécifique, comme `api/admins`, on
trouve très fréquemment ces points d'accès administrateur sous d'autres chemins
relatifs mélés aux points d'accès normaux, comme `api/users`.

## Exemples de scénarios d'attaque

### Scénario #1

Au cours du processus d'enregistrement à une application qui permet uniquement
aux utilisateurs invités de s'inscrire, l'application mobile effectue un appel
d'API à `GET /api/invites/{invite_guid}`. La réponse contient un JSON avec des
informations sur l'invitation, parmi lesquelles le rôle de l'utilisateur et son
e-mail.

Un attaquant a dupliqué la requête et manipulé la méthode HTTP et le point
d'accès vers `POST /api/invites/new`. Ce point d'accès devrait être accessible
uniquement aux administrateurs via la console d'administration, qui
n'implémente pas de contrôles de niveaux d'accès aux fonctionnalités.

L'attaquant exploite cette faille et s'envoie à lui-même une invitation pour se
créer un compte administrateur :

```
POST /api/invites/new

{“email”:”hugo@malicious.com”,”role”:”admin”}
```

### Scénario #2

Une API comporte un point d'accès qui devrait uniquement être accessible aux
administrateurs : `GET /api/admin/v1/users/all`. Ce point d'accès renvoie les
informations sur tous les utilisateurs de l'application et n'implémente pas de
contrôles d'autorisations d'accès. Un attaquant ayant appris la
structure de l'API effectue une déduction logique et réussit à accéder à ce
point d'accès, qui expose des données sensibles sur les utilisateurs de
l'application..

## Comment s'en prémunir

Votre application devrait disposer d'un module d'autorisations constant et
facile à analyser qui est invoqué par toutes vos fonctions métiers.
Fréquemment, cette protection est fournie par un ou plusieurs composants
externes au code de l'application.

* Le(s) mécanisme(s) de contrôle devraient interdire tous les accès par défaut,
  et requérir des privilèges explicites à des rôles spécifiques pour l'accès à
  toutes les fonctions.
* Passez en revue vos points d'accès d'API à la recherche des défauts d'autorisations
  niveau des fonctions, en gardant à l'esprit la logique applicative et la
  hiérarchie des groupes.
* Assurez-vous que tous vos contrôleurs d'administration héritent d'un
  contrôleur d'administration abstrait qui implémente des contrôles
  d'autorisation basés sur le groupe / rôle de l'utilisateur.
* Assurez-vous que les fonctions d'administration à l'intérieur d'un contrôleur
  normal implémentent des contrôles d'autorisation basés sur le groupe / rôle
  de l'utilisateur.

## Références

### OWASP

* [OWASP Article on Forced Browsing][1]
* [OWASP Top 10 2013-A7-Missing Function Level Access Control][2]
* [OWASP Development Guide: Chapter on Authorization][3]

### Externes

* [CWE-285: Improper Authorization][4]

[1]: https://www.owasp.org/index.php/Forced_browsing
[2]: https://www.owasp.org/index.php/Top_10_2013-A7-Missing_Function_Level_Access_Control
[3]: https://www.owasp.org/index.php/Category:Access_Control
[4]: https://cwe.mitre.org/data/definitions/285.html
