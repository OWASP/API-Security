# API1:2019 Broken Object Level Authorization

| Facteurs de menace / Vecteurs d'attaque | Faille de sécurité | Impact |
| - | - | - |
| Spécifique API : Exploitabilité **3** | Prévalence **3** : Détectabilité **2** | Technique **3** : Spécifique à l'organisation |
| Des attaquants peuvent exploiter des points d'accès d'API qui sont vulnérables à la faille de niveau d'autorisation en manipulant l'ID d'un objet qui est envoyé avec la requête. Ceci peut entrainer à un accès non autorisé à des données sensibles. Ce problème est extrêmement commun dans les applications basées sur des API parce que le composant serveur ne suit pas complètement l'état du client, et au lieu de cela, s'appuie davantage sur des paramètres comme les ID objets, qui sont envoyés par le client, pour déterminer à quel objet accéder. | Cette attaque est la plus courante et la plus impactante sur les APIs. Les mécanismes d'autorisation et de contrôle d'accès des applications modernes sont complexes et étendus. Même si l'application implémente une infrastructure adaptée pour les contrôles d'autorisations, les développeurs peuvent oublier d'utiliser ces contrôles avant d'autoriser l'accès à un objet sensible. La détection de contrôles d'accès ne se prête typiquement pas à des tests statiques ou dynamiques automatisés. | Un accès non autorisé peut aboutir à la diffusion de données à des tiers non autorisés, des pertes de données, ou des manipulations de données. Un accès non autorisé aux objets peut aussi aboutir à une prise de contrôle complète d'un compte. |

## L'API est-elle vulnérable ?

L'autorisation au niveau de l'objet est un mécanisme de contrôle d'accès qui est généralement implémenté au niveau du code pour valider qu'un utilisateur puisse uniquement accéder aux objets auxquels il doit avoir accès.

Chaque point d'accès d'API qui reçoit l'ID d'un objet, et effectue une action quelconque sur l' objet, doit implémenter des contrôles d'accès au niveau de l'objet. Les contrôles doivent valider que l'utilisateur connecté dispose de l'accès pour effectuer l'action requise sur l'objet requis.

Des vulnérabilités de ce mécanisme entraînent typiquement des diffusions non autorisées d'information, la modification ou la destruction de toutes les données.

## Exemples de scénarios d'attaque

### Scénario #1

Une plateforme de commerce électronique pour des magasins en ligne (boutiques) comporte une page listant les diagrammes de vente pour les boutiques hébergées. Examinant les requêtes du navigateur, un attaquant peut identifier les points d'accès de l'API utilisés comme sources de données pour ces diagrammes et leur schéma `/shops/{shopName}/revenue_data.json`. Utilisant un autre point d'accès de l'API, l'attaquant peut obtenir la liste de tous les noms des boutiques hébergées. Avec un simple script pour manipuler les noms de la liste, remplaçant `{shopName}` dans l'URL, l'attaquant obtient l'accès aux données de vente de milliers de boutiques de commerce électronique.

### Scénario #2

Observant le trafic réseau d'un appareil de poche, la requête HTTP `PATCH` suivante attire l'attention d'un attaquant du fait de la présence d'un en-tête HTTP personnalisé `X-User-Id: 54796`. Remplaçant  la valeur `X-User-Id` par `54795`, l'attaquant obtient une réponse HTTP valide, et est en mesure de modifier les données des autres comptes utilisateurs.

## Comment s'en prémunir

* Implémentez un véritable mécanisme d'autorisation qui s'appuie sur des droits
  utilisateurs et sur une hiérarchie.
* Utilisez un mécanisme d'autorisation pour vérifier si l'utilisateur connecté est
  autorisé à effectuer l'action requise sur l'enregistrement pour toute fonction
  qui utilise une entrée du client pour accéder à un enregistrement dans la base
  de données.
* Préférez l'utilisation de valeurs aléatoires et non prévisibles comme GUIDs pour
  les ID des enregistrements.
* Écrivez des tests pour évaluer les mécanismes d'autorisation. Ne déployez pas des
  modifications vulnérables qui ne passent pas les tests.

## Références

### Externes

* [CWE-284: Improper Access Control][1]
* [CWE-285: Improper Authorization][2]
* [CWE-639: Authorization Bypass Through User-Controlled Key][3]

[1]: https://cwe.mitre.org/data/definitions/284.html
[2]: https://cwe.mitre.org/data/definitions/285.html
[3]: https://cwe.mitre.org/data/definitions/639.html
