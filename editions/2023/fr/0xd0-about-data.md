# Méthodologie et données

## Aperçu

Pour cette mise à jour de la liste, l'équipe OWASP API Security a utilisé la même méthodologie que celle utilisée pour la liste de 2019, qui a été bien adoptée et couronnée de succès, avec l'ajout d'un [Appel à Données][1] public de 3 mois. Malheureusement, cet appel à données n'a pas donné lieu à des données qui auraient permis une analyse statistique pertinente des problèmes de sécurité des API les plus courants.

Cependant, avec une industrie de la sécurité des API plus mature capable de fournir des retours directs et des informations, le processus de mise à jour a avancé en utilisant la même méthodologie qu'auparavant.

Arrivés ici, nous pensons disposer d'un document de sensibilisation prospectif pour les trois ou quatre prochaines années, plus axé sur les problèmes spécifiques aux API modernes. L'objectif de ce projet n'est pas de remplacer d'autres listes de TOP 10, mais plutôt de couvrir les risques de sécurité des API existants et à venir sur lesquels nous pensons que l'industrie devrait être consciente et vigilante.

## Méthodologie

Dans la première phase, des données publiques sur les incidents de sécurité des API ont été collectées, examinées et catégorisées. Ces données ont été collectées à partir de plateformes de bug bounty et de rapports disponibles publiquement. Seuls les problèmes signalés entre 2019 et 2022 ont été pris en compte. Ces données ont été utilisées pour donner à l'équipe une idée de la direction dans laquelle le TOP 10 devrait évoluer, ainsi que pour aider à traiter un éventuel biais des données contribuées.

Un [Appel à Données][1] public a été lancé du 1er septembre au 30 novembre 2022. En parallèle, l'équipe du projet a commencé à discuter de ce qui a changé depuis 2019. La discussion a porté sur l'impact de la première liste, les retours reçus de la communauté et les nouvelles tendances en matière de sécurité des API.

L'équipe du projet a organisé des réunions avec des spécialistes des menaces de sécurité des API pour obtenir des informations sur la manière dont les victimes sont impactées et sur la manière dont ces menaces peuvent être atténuées.

Cet effort a abouti à une première ébauche de ce que l'équipe estime être les dix risques de sécurité des API les plus critiques. La [Méthodologie de Notation des Risques OWASP][2] a été utilisée pour effectuer l'analyse des risques. Les notations de prévalence ont été décidées à partir d'un consensus entre les membres de l'équipe du projet, sur la base de leur expérience dans le domaine. Pour des considérations sur ces questions, veuillez vous référer à la section [Risques de Sécurité des API][3].

La première ébauche a ensuite été partagée pour examen avec des professionels de la sécurité ayant une expérience dans les domaines de la sécurité des API. Leurs commentaires ont été examinés, discutés et, le cas échéant, inclus dans le document. Le document résultant a été [publié en tant que Candidat à la Publication][4] pour [discussion ouverte][5]. Plusieurs [contributions de la communauté][6] ont été incluses dans le document final.

La liste des contributeurs est disponible dans la section [Remerciements][7].

## Risques spécifiques aux API

La liste est construite pour aborder les risques de sécurité qui sont plus spécifiques aux API.

Cela n'implique pas que d'autres risques de sécurité génériques d'applications n'existent pas dans les applications basées sur des API. Par exemple, nous n'avons pas inclus des risques tels que "Composants Vulnérables et Obsolètes" ou "Injection", même si vous pourriez les trouver dans des applications basées sur des API. Ces risques sont génériques, ils ne se comportent pas différemment dans les API, leur exploitation n'est pas différente.

Notre objectif est d'augmenter la sensibilisation aux risques de sécurité qui méritent une attention particulière dans les API.

[1]: https://owasp.org/www-project-api-security/announcements/cfd/2022/
[2]: https://www.owasp.org/index.php/OWASP_Risk_Rating_Methodology
[3]: ./0x10-api-security-risks.md
[4]: https://owasp.org/www-project-api-security/announcements/2023/02/api-top10-2023rc
[5]: https://github.com/OWASP/API-Security/issues?q=is%3Aissue+label%3A2023RC
[6]: https://github.com/OWASP/API-Security/pulls?q=is%3Apr+label%3A2023RC
[7]: ./0xd1-acknowledgments.md
