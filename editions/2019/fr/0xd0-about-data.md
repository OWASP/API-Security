# Méthodologie et Données

## Présentation

Comme l'industrie de la sécurité applicative n'est pas spécifiquement concentrée
sur les architectures applicatives les plus récentes, dans lesquelles les API
jouent un rôle important, il aurait été difficile de compiler une liste des dix
risques de sécurité les plus critiques pour les API en s'appuyant sur un appel
public à informations. Bien qu'il n'y ait pas eu de tel appel public
à informations, la liste résultante composant le Top 10 est basée sur des
informations publiquement accessibles, des contributions d'experts en sécurité,
et des discussions ouvertes avec la communauté de la sécurité.

## Méthodologie

Dans un premier temps, des informations publiquement disponibles sur des
incidents de sécurité concernant des API ont été collectées, évaluées, et
catégorisées par un groupe d'experts en sécurité. Ces données ont été collectées
à partir de plateformes de prime aux bogues (bug bounty) et de bases de données de vulnérabilités,
sur une période d'un an, à des fins statistiques.

Dans un deuxième temps, il a été demandé à des praticiens de la sécurité
expérimentés en tests d'intrusion de compiler leur propre Top 10.

La [méthodologique d'évaluation de risque OWASP][1] a été utilisée pour
effectuer l'analyse de risques. Les scores ont été discutés et évalués par les
praticiens de la sécurité. Sur ces questions, veuillez vous référer à la section
des [risques de sécurité des API][2].

La première ébauche de l'OWASP API Security Top 10 2019 résultait d'un consensus
entre les données statistiques de la première phase et les listes des praticiens
en sécurité. Cette ébauche a ensuite été soumise pour avis et évaluation à un
autre groupe de praticiens de la sécurité disposant d'expériences en lien avec
la sécurité des API.

Le OWASP API Security Top 10 2019 a été présenté pour la première fois lors de
l'événement OWASP Global AppSec Tel Aviv (mai 2019). Depuis lors, il a été mis
à disposition sur GitHub pour permettre discussions et contributions publiques.

La liste des contributeurs est disponible dans la section des [Remerciements][3].

[1]: https://www.owasp.org/index.php/OWASP_Risk_Rating_Methodology
[2]: ./0x10-api-security-risks.md
[3]: ./0xd1-acknowledgments.md
