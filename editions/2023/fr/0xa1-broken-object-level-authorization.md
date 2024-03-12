# API1:2023 Broken Object Level Authorization

| Facteurs de menace / Vecteurs d'attaque | Faille de sécurité | Impact |
| - | - | - |
| Spécifique à l'API : Exploitabilité **Facile** | Prévalence **Répandue** : Détection **Facile** | Technique **Modérée** : Spécifique à l'organisation |
| Les attaquants peuvent exploiter les points d'accès (endpoints) de l'API qui sont vulnérables au "Broken Object Level Authorization" en manipulant l'ID de l'objet envoyé dans la requête. Les ID d'objet peuvent être des entiers, des UUID (identifiants uniques universels) ou des chaînes de caractères. Quel que soit le type de données, ils sont faciles à identifier dans la requête (dans le chemin ou dans les paramètres), son en-tête (header) ou même dans sa payload. | Ce problème est extrêmement courant dans les applications basées sur des API car le composant serveur ne suit généralement pas pleinement l'état du client, et se repose plutôt sur des paramètres comme les ID d'objet, qui sont envoyés par le client pour décider à quels objets accéder. La réponse du serveur est généralement suffisante pour comprendre si la requête a réussi. | L'accès non autorisé aux objets d'autres utilisateurs peut entraîner la divulgation de données à des parties non autorisées, la perte de données ou la manipulation de données. Dans certaines circonstances, l'accès non autorisé aux objets peut également entraîner une prise de contrôle complète du compte. |

## L'API est-elle vulnérable ?

L'autorisation au niveau des objets est un mécanisme de contrôle d'accès qui est généralement implémenté au niveau du code pour valider qu'un utilisateur ne peut accéder qu'aux objets auxquels il devrait avoir accès.

Chaque point d'accès (endpoint) de l'API qui reçoit un ID d'un objet et effectue une action sur l'objet devrait implémenter des vérifications d'autorisation au niveau de l'objet. Les vérifications devraient valider que l'utilisateur connecté a les autorisations pour effectuer l'action demandée sur l'objet demandé.

Les échecs de ce mécanisme conduisent généralement à la divulgation non autorisée d'informations, à la modification ou à la destruction de toutes les données.

Comparer l'ID de l'utilisateur de la session actuelle (par exemple, en l'extrayant du jeton JWT) avec le paramètre ID vulnérable n'est pas une solution suffisante pour résoudre le Broken Object Level Authorization (BOLA). Cette approche ne pourrait résoudre qu'un petit sous-ensemble de cas.

Dans ce cas du BOLA, c'est par conception que l'utilisateur aura accès au point d'accès (endpoint) ou à la fonction vulnérable. La violation se produit au niveau de l'objet, en manipulant l'ID. Si un attaquant parvient à accéder à un point d'accès (endpoint) ou à une fonction API à laquelle il ne devrait pas avoir accès, il s'agit d'un cas de [Broken Function Level Authorization][5] (BFLA) plutôt que d'un BOLA.

## Exemple de scénarios d'attaque

### Scénario #1

Une plateforme de e-commerce pour des magasins en ligne fournit une page avec les graphiques des revenus que le magasin a généré. En inspectant les requêtes du navigateur, un attaquant peut identifier les points d'accès de l'API utilisés comme source de données pour ces graphiques et leur modèle : `/shops/{shopName}/revenue_data.json`. En utilisant un autre point d'accès de l'API, l'attaquant peut obtenir la liste de tous les noms de magasins hébergés. Avec un simple script pour manipuler les noms de la liste, en remplaçant `{shopName}` dans l'URL, l'attaquant obtient accès aux données de vente de milliers de magasins de e-commerce.

### Scénario #2

Un fabricant automobile a permis le contrôle à distance de ses véhicules via une API mobile pour communiquer avec le téléphone mobile du conducteur. L'API permet au conducteur de démarrer et d'arrêter le moteur et de verrouiller et déverrouiller les portes à distance. Dans ce flux, l'utilisateur envoie le numéro d'identification du véhicule (VIN) à l'API. L'API ne valide pas que le VIN représente un véhicule appartenant à l'utilisateur connecté, ce qui conduit à une vulnérabilité de BOLA. Un attaquant peut accéder à des véhicules qui ne lui appartiennent pas.

### Scénario #3

Un service de stockage de documents en ligne permet aux utilisateurs de visualiser, d'éditer, de stocker et de supprimer leurs documents. Lorsqu'un document d'un utilisateur est supprimé, une mutation GraphQL avec l'ID du document est envoyée à l'API.

```
POST /graphql
{
  "operationName":"deleteReports",
  "variables":{
    "reportKeys":["<DOCUMENT_ID>"]
  },
  "query":"mutation deleteReports($siteId: ID!, $reportKeys: [String]!) {
    {
      deleteReports(reportKeys: $reportKeys)
    }
  }"
}
```

L'API ne vérifie pas si l'utilisateur connecté a les autorisations pour supprimer le document avec l'ID fourni. Un attaquant peut supprimer les documents d'autres utilisateurs en remplaçant l'ID du document dans la requête.

## Comment s'en prémunir

* Implémentez un mécanisme d'autorisation approprié qui repose sur les politiques et la hiérarchie des utilisateurs.
* Utilisez le mécanisme d'autorisation pour vérifier si l'utilisateur connecté peut effectuer l'action demandée sur l'objet dans chaque fonction qui utilise une entrée du client pour accéder à la base de données.
* Préférez l'utilisation de valeurs GUID aléatoires et imprévisibles pour les ID.
* Écrivez des tests pour évaluer la vulnérabilité du mécanisme d'autorisation. Ne déployez pas de modifications qui feraient échouer les tests.

## Références

### OWASP

* [Authorization Cheat Sheet][1]
* [Authorization Testing Automation Cheat Sheet][2]

### Externes

* [CWE-285: Improper Authorization][3]
* [CWE-639: Authorization Bypass Through User-Controlled Key][4]

[1]: https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html
[2]: https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Testing_Automation_Cheat_Sheet.html
[3]: https://cwe.mitre.org/data/definitions/285.html
[4]: https://cwe.mitre.org/data/definitions/639.html
[5]: ./0xa5-broken-function-level-authorization.md
