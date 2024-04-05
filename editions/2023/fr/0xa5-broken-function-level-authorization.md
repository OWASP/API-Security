# API5:2023 Broken Function Level Authorization

| Facteurs de menace / Vecteurs d'attaque | Faille de sécurité | Impact |
| - | - | - |
| Spécifique à l'API : Exploitabilité **Facile** | Prévalence **Courante** : Détectabilité **Facile** | Technique **Grave** : Spécifique à l'organisation |
| L'exploitation nécessite que l'attaquant envoie des appels API légitimes à un point d'accès API auquel il ne devrait pas avoir accès en tant qu'utilisateur anonyme ou utilisateur régulier, non privilégié. Les points d'accès exposés seront facilement exploités. | Les vérifications d'autorisation pour une fonction ou une ressource sont généralement gérées via la configuration ou le code. Implémenter des vérifications appropriées peut être une tâche confuse car les applications modernes peuvent contenir de nombreux types de rôles, de groupes et de hiérarchies d'utilisateurs complexes (par exemple, des sous-utilisateurs ou des utilisateurs avec plus d'un rôle). Il est plus facile de découvrir ces failles dans les API car les API sont plus structurées et l'accès à différentes fonctions est plus prévisible. | De telles failles permettent aux attaquants d'accéder à des fonctionnalités non autorisées. Les fonctions d'administration sont des cibles clés pour ce type d'attaque et peuvent entraîner une divulgation de données, une perte de données ou une corruption de données. En fin de compte, cela peut entraîner une interruption de service. |


## L'API est-elle vulnérable ?

La meilleure façon de trouver des problèmes d'autorisation au niveau de la fonction est de réaliser une analyse approfondie du mécanisme d'autorisation tout en gardant à l'esprit la hiérarchie des utilisateurs, les différents rôles ou groupes dans l'application, et en posant les questions suivantes :

* Un utilisateur régulier peut-il accéder à des points d'accès d'administration ?
* Un utilisateur peut-il effectuer des actions sensibles (par exemple, création, modification ou suppression) auxquelles il ne devrait pas avoir accès en modifiant simplement la méthode HTTP (par exemple, de `GET` à `DELETE`) ?
* Un utilisateur du groupe X peut-il accéder à une fonction qui devrait être exposée uniquement aux utilisateurs du groupe Y, en devinant simplement l'URL de l'endpoint et les paramètres (par exemple, `/api/v1/users/export_all`) ?

Ne supposez pas qu'un point d'accès API est quelconque ou au contraire est un endpoint d'administration seulement par son URL.

Certains développeurs peuvent choisir d'exposer la plupart des points d'accès d'administration sous un chemin relatif spécifique, comme `/api/admins`, mais il est également très courant de les trouver sous d'autres chemins relatifs, partagés avec d'autres endpoints plus classiques dans les applications, comme `/api/users`.

## Exemple de scénarios d'attaque

### Scénario #1

Pendant le processus d'inscription pour une application qui n'autorise que les utilisateurs invités à rejoindre, l'application mobile déclenche un appel API à `GET /api/invites/{invite_guid}`. La réponse contient un JSON avec les détails de l'invitation, y compris le rôle de l'utilisateur et l'e-mail de l'utilisateur.

Un attaquant duplique la requête et manipule la méthode HTTP et le point d'accès pour `POST /api/invites/new`. Cet endpoint ne devrait être accessible que par les administrateurs via la console d'administration. L'endpoint ne met pas en œuvre de vérifications d'autorisation au niveau de la fonction.

L'attaquant exploite le problème et envoie une nouvelle invitation avec des privilèges administrateur :

```
POST /api/invites/new

{
  "email": "attacker@somehost.com",
  "role":"admin"
}
```

Plus tard, l'attaquant utilise l'invitation malveillante pour se créer un compte administrateur et obtenir un accès complet au système.

### Scénario #2

Une API contient un point d'accès qui ne devrait être exposé qu'aux administrateurs - `GET /api/admin/v1/users/all`. Cet endpoint renvoie les détails de tous les utilisateurs de l'application et ne met pas en œuvre de vérifications d'autorisation au niveau de la fonction. Un attaquant ayant compris la structure de l'API devine adroitement comment accéder à cet endpoint, par l'URL, et retrouve ainsi tous les détails sensibles des utilisateurs pour cette application.

## Comment s'en prémunir ?

Votre application doit disposer d'un module d'autorisation cohérent et facile à analyser qui est invoqué depuis toutes vos fonctions métier. Souvent, cette protection est fournie par un ou plusieurs composants externes au code de l'application.

* Le(s) mécanisme(s) de contrôle d'accès doivent refuser tout accès par défaut, exigeant des autorisations explicites pour des rôles spécifiques pour accéder à chaque fonction.
* Passez en revue vos endpoints contre les failles d'autorisation au niveau de la fonction, tout en gardant à l'esprit la logique métier de l'application et la hiérarchie des groupes.
* Assurez-vous que tous vos contrôleurs d'administration héritent d'un contrôleur d'administration abstrait qui implémente des vérifications d'autorisation basées sur le groupe/le rôle de l'utilisateur.
* Assurez-vous que les fonctions d'administration adjointes à un contrôleur régulier (i.e. non dédié à l'admistration de l'application, e.g. : PaymentController, InvitationController, etc.) implémentent des vérifications d'autorisation basées sur le groupe et le rôle de l'utilisateur.

## Références

### OWASP

* [Forced Browsing][1]
* "A7: Missing Function Level Access Control", [OWASP Top 10 2013][2]
* [Access Control][3]

### Externes

* [CWE-285: Improper Authorization][4]

[1]: https://owasp.org/www-community/attacks/Forced_browsing
[2]: https://github.com/OWASP/Top10/raw/master/2013/OWASP%20Top%2010%20-%202013.pdf
[3]: https://owasp.org/www-community/Access_Control
[4]: https://cwe.mitre.org/data/definitions/285.html
