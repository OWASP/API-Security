# Perspectives pour les DevSecOps

En raison de leur importance dans les architectures d'applications modernes, la construction d'API sécurisées est cruciale. La sécurité ne peut être négligée et doit faire partie de tout le cycle de développement. Scanner et réaliser des tests de pénétration une fois par an ne suffit plus.

Les DevSecOps devraient rejoindre l'effort de développement, facilitant les tests de sécurité continus tout au long du cycle de vie du logiciel. Votre objectif devrait être d'améliorer le pipeline de développement avec l'automatisation de la sécurité, sans impacter la vitesse de développement.

En cas de doute, restez informé et référez-vous au [Manifeste DevSecOps][1].

| | |
|-|-|
| **Comprendre le Modèle de Menace** | Les priorités de test proviennent d'un modèle de menace. Si vous n'en avez pas, envisagez d'utiliser le [Standard de Vérification de Sécurité des Applications OWASP (ASVS)][2], et le [Guide de Test de Sécurité OWASP][3] comme entrée. Impliquer l'équipe de développement les rendra plus conscients de la sécurité. |
| **Comprendre le SDLC** | Rejoignez l'équipe de développement pour mieux comprendre le Cycle de Vie du Développement Logiciel. Votre contribution aux tests de sécurité continus doit être compatible avec les personnes, les processus et les outils. Tout le monde devrait être d'accord avec le processus, pour qu'il n'y ait pas de friction ou de résistance inutile. |
| **Stratégies de Test** | Puisque votre travail ne doit pas impacter la vitesse de développement, vous devriez choisir judicieusement la meilleure technique (simple, rapide, précise) pour vérifier les exigences de sécurité. Le [Cadre de Connaissance de Sécurité OWASP][4] et le [Standard de Vérification de Sécurité des Applications OWASP][2] peuvent être de grandes sources d'exigences de sécurité fonctionnelles et non fonctionnelles. Il existe d'autres excellentes sources pour des [projets][5] et [outils][6] similaires à ceux proposés par la [communauté DevSecOps][7]. |
| **Atteindre la Couverture et la Précision** | Vous êtes le pont entre les équipes de développement et d'exploitation. Pour atteindre une couverture, vous devriez non seulement vous concentrer sur la fonctionnalité, mais aussi sur l'orchestration. Travaillez étroitement avec les équipes de développement et d'exploitation dès le début pour optimiser votre temps et vos efforts. Vous devriez viser un état où la sécurité essentielle est vérifiée en continu. |
| **Communiquer Clairement les Résultats** | Apportez de la valeur avec moins ou pas de friction. Livrez les résultats en temps voulu, dans les outils que les équipes de développement utilisent (pas de fichiers PDF). Rejoignez l'équipe de développement pour traiter les résultats. Profitez de l'occasion pour les former, en décrivant clairement la faiblesse et comment elle peut être exploitée, y compris un scénario d'attaque pour le rendre réel. |

[1]: https://www.devsecops.org/
[2]: https://owasp.org/www-project-application-security-verification-standard/
[3]: https://owasp.org/www-project-web-security-testing-guide/
[4]: https://owasp.org/www-project-security-knowledge-framework/
[5]: http://devsecops.github.io/
[6]: https://github.com/devsecops/awesome-devsecops
[7]: http://devsecops.org
