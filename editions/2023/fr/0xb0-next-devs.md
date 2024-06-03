# Perspectives pour les Développeurs
La tâche de créer et de maintenir des applications sécurisées, ou de corriger des applications existantes, peut être difficile. Il en va de même pour les API.

Nous croyons que l'éducation et la sensibilisation sont des facteurs clés pour écrire des logiciels sécurisés. Tout le reste nécessaire pour atteindre l'objectif dépend de **l'établissement et de l'utilisation de processus de sécurité répétables et de contrôles de sécurité standard**.

OWASP fournit de nombreuses ressources gratuites et ouvertes pour vous aider à aborder la sécurité. Veuillez visiter la [page des Projets OWASP][1] pour une liste complète des projets disponibles.

| | |
|-|-|
| **Éducation** | Le [Guide de Sécurité des Applications OWASP][2] devrait vous donner une bonne idée des projets disponibles pour chaque étape/phase du Cycle de Vie du Développement Logiciel (SDLC). Pour une formation pratique, vous pouvez commencer avec [OWASP **crAPI** - **C**ompletely **R**idiculous **API**][3] ou [OWASP Juice Shop][4] : tous deux ont des APIs intentionnellement vulnérables. Le [Projet de Répertoire d'Applications Web Vulnérables OWASP][5] fournit une liste de projets d'applications intentionnellement vulnérables : vous y trouverez plusieurs autres APIs vulnérables. Vous pouvez également assister à des sessions de formation de la [Conférence OWASP AppSec][6], ou [rejoindre votre chapitre local][7]. |
| **Exigences de Sécurité** | La sécurité devrait faire partie de chaque projet dès le début. Lors de la définition des exigences, il est important de définir ce que "sécurisé" signifie pour ce projet. OWASP vous recommande d'utiliser le [Standard de Vérification de Sécurité des Applications OWASP (ASVS)][8] comme guide pour définir les exigences de sécurité. Si vous externalisez, considérez l'[Annexe de Contrat de Logiciel Sécurisé OWASP][9], qui devrait être adaptée en fonction des lois et réglementations locales. |
| **Architecture de Sécurité** | La sécurité devrait rester une préoccupation pendant toutes les étapes du projet. La [Série de Cheet Sheat OWASP][10] est un bon point de départ pour obtenir des conseils sur la façon de concevoir la sécurité pendant la phase d'architecture. Parmi beaucoup d'autres, vous trouverez la [Fiche de Triche sur la Sécurité REST][11] et la [Fiche de Triche sur l'Évaluation REST][12] ainsi que la [Fiche de Triche GraphQL][13]. |
| **Contrôles de Sécurité Standard** | L'adoption de contrôles de sécurité standard réduit le risque d'introduire des faiblesses de sécurité tout en écrivant votre propre logique. Bien que de nombreux frameworks modernes viennent maintenant avec des contrôles standard efficaces intégrés, [OWASP Proactive Controls][14] vous donne un bon aperçu des contrôles de sécurité que vous devriez chercher à inclure dans votre projet. OWASP fournit également certaines bibliothèques et outils que vous pourriez trouver précieux, tels que des contrôles de validation. |
| **Cycle de Vie de Développement Logiciel Sécurisé** | Vous pouvez utiliser le [Modèle de Maturité de l'Assurance Logicielle OWASP (SAMM)][15] pour améliorer vos processus de construction d'API. Plusieurs autres projets OWASP sont disponibles pour vous aider pendant les différentes phases de développement d'API, par exemple, le [Guide de Révision de Code OWASP][16]. |

[1]: https://owasp.org/projects/
[2]: https://owasp.org/projects/#owasp-projects-the-sdlc-and-the-security-wayfinder
[3]: https://owasp.org/www-project-crapi/
[4]: https://owasp.org/www-project-juice-shop/
[5]: https://owasp.org/www-project-vulnerable-web-applications-directory/
[6]: https://owasp.org/events/
[7]: https://owasp.org/chapters/
[8]: https://owasp.org/www-project-application-security-verification-standard/
[9]: https://owasp.org/www-community/OWASP_Secure_Software_Contract_Annex
[10]: https://cheatsheetseries.owasp.org/
[11]: https://cheatsheetseries.owasp.org/cheatsheets/REST_Security_Cheat_Sheet.html
[12]: https://cheatsheetseries.owasp.org/cheatsheets/REST_Assessment_Cheat_Sheet.html
[13]: https://cheatsheetseries.owasp.org/cheatsheets/GraphQL_Cheat_Sheet.html
[14]: https://owasp.org/www-project-proactive-controls/
[15]: https://owasp.org/www-project-samm/
[16]: https://owasp.org/www-project-code-review-guide/
