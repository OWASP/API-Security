# Perspectives pour les DevSecOps

Du fait de leur importance dans les architectures des applications modernes, il
est crucial de construire des API sécurisées. La sécurité ne peut pas être
négligée, et elle doit faire partie de l'ensemble du processus de
développement. Effectuer un scan et un test d'intrusion annuel n'est plus
suffisant.

Les DevSecOps doivent participer à l'effort de développement et faciliter les
tests continus de sécurité sur l'ensemble du cycle de vie du développement
logiciel. Leur but est d'améliorer le processus de développement avec une
automatisation de la sécurité, sans impacter la vitesse de développement.

En cas de doute, tenez-vous informé et consultez souvent le [DevSecOps Manifesto][1].

| | |
|-|-|
| **Compréhension du modèle de menaces** | Les priorités de tests sont déterminées par le modèle de menaces. Si vous n'en avez pas, envisagez d'utiliser notre [OWASP Application Security Verification Standard (ASVS)][2], et notre [OWASP Testing Guide][3] comme bases. Impliquer l'équipe de développement peut contribuer à les rendre plus conscients de la sécurité. |
| **Comprendre le SDLC** | Joignez-vous à l'équipe de développement pour mieux comprendre le cycle de développement logiciel (SDLC - Software Development Life Cycle). Votre contribution aux tests de sécurité continus doit être compatible avec les personnes, les procédés et les outils. Tout le monde doit adhérer à la démarche, afin d'éviter des frictions ou de la résistance inutiles. |
| **Stratégies de tests** | Comme votre travail ne doit pas impacter la vitesse de développement, vous devez choisir judicieusement la meilleure technique (simple, la plus rapide, la plus juste) pour vérifier les exigences de sécurité. Les projets [OWASP Security Knowledge Framework][4] et [OWASP Application Security Verification Standard][5] peuvent constituer d'excellentes sources d'exigences de sécurité fonctionnelles et non-fonctionnelles. Il existe également d'autres ressources et contenus de qualité tels les [projets][6] et [outils][7] proposés par la [communauté DevSecOps][8]. |
| **Obtention de couverture et précision** | Vous êtes le lien entre les développeurs (Dev) et les équipes opérationnelles (Ops). Pour réaliser la couverture, vous devez vous concentrer non seulement sur la fonctionnalité, mais aussi sur l'orchestration. Travaillez en étroite relation à la fois avec les équipes de développement et des opérations (infra) dès le début pour pouvoir optimiser votre temps et vos efforts. Vous devez viser un état où la sécurité essentielle est vérifiée continuellement. |
| **Communication claire des résultats** | Apportez de la valeur avec pas ou peu de friction. Alertez promptement sur vos découvertes, en utilisant les moyens et outils mis en oeuvres par vos équipes (pas dans des fichiers PDF). Joignez-vous à l'équipe de développement pour résoudre ces problèmes. Profitez de l'occasion pour les instruire, en décrivant clairement la vulnérabilité et la manière dont elle peut être exploitée, avec un scénario d'attaque pour la rendre réelle. |

[1]: https://www.devsecops.org/
[2]: https://www.owasp.org/index.php/Category:OWASP_Application_Security_Verification_Standard_Project
[3]: https://www.owasp.org/index.php/OWASP_Testing_Project
[4]: https://www.owasp.org/index.php/OWASP_Security_Knowledge_Framework
[5]: https://www.owasp.org/index.php/Category:OWASP_Application_Security_Verification_Standard_Project
[6]: http://devsecops.github.io/
[7]: https://github.com/devsecops/awesome-devsecops
[8]: http://devsecops.org
