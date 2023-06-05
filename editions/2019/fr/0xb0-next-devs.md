# Perspectives pour les Développeurs

Créer ou maintenir la sécurité d'un logiciel, ou corriger un logiciel existant, peut s'avérer difficile. Il en va de même pour les API.

Nous pensons que l'éducation et la connaissance sont des facteurs clés pour écrire des logiciels sécurisés. L'atteinte de cet objectif repose ensuite sur **la mise en place et l'utilisation de processus de sécurité reproductibles et de contrôles de sécurité standards**.

L'OWASP propose de nombreuses ressources gratuites et libres pour aborder la sécurité dès le début d'un projet. Veuillez visiter la [page des projets OWASP][1] pour connaitre la liste complète des projets disponibles.

| | |
|-|-|
| **Éducation** | Vous pouvez commencer par lire les [projets de la catégorie OWASP Education][2] en fonction de votre profession de votre intérêt. Pour une approche plus pratique, nous avons ajouté le projet **crAPI** - **C**ompletely **R**idiculous **API** à  [notre roadmap][3]. En attendant, vous pouvez vous entrainer à la sécurité des applis web avec le [module OWASP DevSlop Pixi][4], une WebApp et un service d'API volontairement vulnérables destinés à apprendre aux utilisateurs comment tester la sécurité des applications web modernes et des services d'API, et comment développer des API plus sécurisées à l'avenir. Vous pouvez également participer à des sessions de formation de [conférence OWASP AppSec][5], ou [rejoindre une section OWASP locale][6]. |
| **Besoins de Sécurité** | La sécurité doit faire partie de chaque projet dès le début. Lors de la formulation des besoins, il est important de définir ce que "sécurisé" signifie pour ce projet. L'OWASP vous recommande d'utiliser le [OWASP Application Security Verification Standard (ASVS)][7] comme guide pour définir vos besoins de sécurité. Si vous sous-traitez, envisagez le projet [OWASP Secure Software Contract Annex][8], qui devra être adapté aux lois et réglementations locales. |
| **Architecture de Sécurité** | La sécurité doit rester une préoccupation durant toutes les étapes du projet. Les [OWASP Prevention Cheat Sheets][9] sont un bon point de départ pour guider la conception de la sécurité durant la phase d'architecture. Parmi beaucoup d'autres, vous trouverez la [REST Security Cheat Sheet][10] et la [REST Assessment Cheat Sheet][11]. |
| **Contrôles de Sécurité Standards** | L'adoption de contrôles de sécurité standards réduit le risque d'introduire des vulnérabilités de sécurité lorsque vous implémentez votre logique métier. Bien que de nombreux frameworks modernes incluent désormais des contrôles standards efficaces, [OWASP Proactive Controls][12] vous fournit un bon résumé des contrôles de sécurité que vous devriez inclure dans votre projet. L'OWASP fournit aussi quelques bibliothèques et outils que vous pourrez trouver utiles, tels que des contrôles de validation. |
| **Cycle de Développement Logiciel Sécurisé** | Vous pouvez utiliser le [OWASP Software Assurance Maturity Model (SAMM)][13] pour améliorer le processus de développement d'API. Plusieurs autres projets OWASP sont disponibles pour vous aider durant les différentes phases de développement d'API, par ex. le [OWASP Code Review Project][14]. |

[1]: https://www.owasp.org/index.php/Category:OWASP_Project
[2]: https://www.owasp.org/index.php/OWASP_Education_Material_Categorized
[3]: https://www.owasp.org/index.php/OWASP_API_Security_Project#tab=Road_Map
[4]: https://devslop.co/Home/Pixi
[5]: https://www.owasp.org/index.php/Category:OWASP_AppSec_Conference
[6]: https://www.owasp.org/index.php/OWASP_Chapter
[7]: https://www.owasp.org/index.php/Category:OWASP_Application_Security_Verification_Standard_Project
[8]: https://www.owasp.org/index.php/OWASP_Secure_Software_Contract_Annex
[9]: https://www.owasp.org/index.php/OWASP_Cheat_Sheet_Series
[10]: https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/REST_Security_Cheat_Sheet.md
[11]: https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/REST_Assessment_Cheat_Sheet.md
[12]: https://www.owasp.org/index.php/OWASP_Proactive_Controls#tab=OWASP_Proactive_Controls_2018
[13]: https://www.owasp.org/index.php/OWASP_SAMM_Project
[14]: https://www.owasp.org/index.php/Category:OWASP_Code_Review_Project
