# API6:2023 Unrestricted Access to Sensitive Business Flows

| Facteurs de menace/Vecteurs d'attaque | Faille de sécurité | Impacts |
| - | - | - |
| Spécifique à l'API : Exploitabilité **Facile** | Prévalence **Répandue** : Détectabilité **Moyenne** | Technique **Modérée** : Spécifique à l'organisation |
| L'exploitation implique généralement de comprendre le modèle commercial soutenu par l'API, de trouver des flux commerciaux sensibles et d'automatiser l'accès à ces flux, causant des dommages à l'entreprise. | Le manque de vue holistique de l'API pour soutenir pleinement les exigences commerciales tend à contribuer à la prévalence de ce problème. Les attaquants identifient manuellement les ressources (par exemple, les points d'accès) impliquées dans le flux cible et comment elles fonctionnent ensemble. Si des mécanismes d'atténuation sont déjà en place, les attaquants doivent trouver un moyen de les contourner. | En général, l'impact technique n'est pas attendu. L'exploitation pourrait nuire à l'entreprise de différentes manières, par exemple : empêcher les utilisateurs légitimes d'acheter un produit, ou entraîner une inflation dans l'économie. |

## L'API est-elle vulnérable ?

Lors de la création d'un point d'accès (endpoint) API, il est important de comprendre le flux commercial qu'il expose. Certains flux commerciaux sont plus sensibles que d'autres, dans le sens où un accès excessif à ces flux peut nuire à l'entreprise.

Des exemples courants de flux commerciaux sensibles et des risques d'accès excessif associés :

* Achat d'un produit - un attaquant peut acheter tout le stock d'un article très demandé en une fois et de tous les revendre à un prix plus élevé
* Création d'un flux de commentaires/publications - un attaquant peut spammer le système
* Réservation - un attaquant peut réserver tous les créneaux horaires disponibles
  et empêcher d'autres utilisateurs d'utiliser le système

Le risque d'accès excessif peut varier entre les secteurs et les entreprises. Par exemple, la création de publications par un script peut être considérée comme un risque de spam par un réseau social, mais encouragée par un autre réseau social.

Une API est vulnérable si elle expose un flux commercial sensible sans restreindre de manière appropriée l'accès à celui-ci.

## Exemple de scénarios d'attaque

### Scénario #1

Une entreprise de tech annonce qu'elle va sortir une nouvelle console de jeu le jour de Thanksgiving. Le produit est très demandé et le stock est limité. Un attaquant écrit un code pour acheter automatiquement le nouveau produit et finaliser la transaction.

Le jour de la sortie, l'attaquant exécute le code distribué sur différentes adresses IP et emplacements. L'API ne met pas en place les protections appropriées et permet à l'attaquant d'acheter la majorité du stock avant les autres utilisateurs légitimes.

Plus tard, l'attaquant revend le produit sur une autre plateforme pour un prix beaucoup plus élevé.

### Scénario #2

Une compagnie aérienne propose l'achat de billets en ligne sans frais d'annulation. Un utilisateur malveillant réserve 90% des sièges d'un vol désiré.

Quelques jours avant le vol, l'utilisateur malveillant annule tous les billets en une seule fois, forçant la compagnie aérienne à réduire les prix des billets pour remplir le vol.

À ce stade, l'utilisateur achète un seul billet qui est beaucoup moins cher que le billet original.

### Scénario #3

Une application de covoiturage propose un programme de parrainage - les utilisateurs peuvent inviter leurs amis et gagner des crédits pour chaque ami qui a rejoint l'application. Ces crédits peuvent être utilisés plus tard comme de l'argent pour réserver des trajets.

Un attaquant exploite ce flux en écrivant un script pour automatiser le processus d'inscription, chaque nouvel utilisateur ajoutant des crédits au portefeuille de l'attaquant.

L'attaquant peut ensuite profiter de trajets gratuits ou vendre les comptes avec des crédits excessifs contre de l'argent.

## Comment s'en prémunir ?

La planification de mitigation doit être effectuée en deux couches :

* Business - identifier les flux commerciaux qui pourraient nuire à l'entreprise s'ils "taient utilisés de manière excessive.
* Ingénierie - choisir les bons mécanismes de protection pour atténuer le risque commercial.

    Certains mécanismes de protection sont plus simples tandis que d'autres sont plus difficiles à mettre en œuvre. Les méthodes suivantes sont utilisées pour ralentir les menaces automatisées :

    * Empreinte de l'appareil : refuser le service aux appareils clients inattendus (par exemple, les navigateurs sans interface graphique) tend à inciter les acteurs malveillants à utiliser des solutions plus sophistiquées, donc plus coûteuses pour eux
    * Détection humaine : utiliser soit un captcha, soit des solutions biométriques plus avancées (par exemple : biométrie par modèles de frappe)
    * Modèles non humains : analyser le flux de l'utilisateur pour détecter les modèles non humains (par exemple, l'utilisateur a accédé aux fonctions "ajouter au panier" et "compléter l'achat" en moins d'une seconde)
    * Considérer le blocage des adresses IP des nœuds de sortie Tor et des proxies bien connus

    Sécurisez et limitez l'accès aux API qui sont consommées directement par des machines (comme les API de développeur et B2B). Elles sont souvent une cible facile pour les attaquants car elles n'implémentent souvent pas tous les mécanismes de protection nécessaires.

## Références 

### OWASP

* [OWASP Automated Threats to Web Applications][1]
* [API10:2019 Insufficient Logging & Monitoring][2]

[1]: https://owasp.org/www-project-automated-threats-to-web-applications/
[2]: https://owasp.org/API-Security/editions/2019/en/0xaa-insufficient-logging-monitoring/

