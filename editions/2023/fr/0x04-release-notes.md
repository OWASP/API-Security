# Notes de publication

Ce document est la seconde édition du OWASP API Security Top 10, disponible exactement quatre ans
après sa première publication. Beaucoup de choses ont changé dans le domaine (de
la sécurité) des API. Le trafic des API a augmenté à un rythme soutenu, certains
protocoles API ont gagné en popularité, de nouvelles solutions de sécurité ont vu le jour, et, bien sûr, les attaquants ont développé de nouvelles compétences et techniques pour compromettre les API. Il était grand temps de mettre à jour la liste des dix risques de sécurité API les plus critiques.

Avec une industrie de la sécurité des API plus mature, pour la première fois, il y a eu [un appel public à la collecte de données][1]. Malheureusement, aucune donnée n'a été envoyée, mais sur la base de l'expérience de l'équipe du projet, de l'examen attentif de la part des spécialistes de la sécurité des API et des retours de la communauté sur la version candidate, nous avons construit cette nouvelle liste. Dans la [section Méthodologie et Données][2], vous trouverez plus de détails sur la façon dont cette version a été construite. Pour plus de détails sur les risques de sécurité, veuillez vous référer à la [section Risques de sécurité des API][3].

Le OWASP API Security Top 10 2023 est un document de sensibilisation tourné vers l'avenir pour une industrie en constante évolution. Il ne remplace pas les autres TOP 10. Dans cette édition :

* Nous avons combiné l' "Excessive Data Exposure" et le "Mass Assignment" en mettant l'accent sur la cause commune : "Broken Object Property Level Authorization".
* Nous avons mis davantage l'accent sur la consommation de ressources, plutôt que sur le rythme auquel elles sont épuisées.
* Nous avons créé une nouvelle catégorie "Unrestricted Access to Sensitive Business Flows" pour aborder de nouvelles menaces, comprenant la plupart de celles qui peuvent être atténuées par le biais du rate limiting.
* Nous avons ajouté "Unsafe Consumption of APIs" pour aborder quelque chose que nous avons commencé à voir : les attaquants ont commencé à chercher à compromettre les services intégrés de la cible, au lieu de viser directement les API. C'est le bon moment pour commencer à sensibiliser à ce risque croissant.

Les API jouent un rôle de plus en plus important dans l'architecture moderne des microservices, les applications monopages (SPA), les applications mobiles, l'IoT, etc. Le OWASP API Security Top 10 est un effort nécessaire pour sensibiliser aux problèmes de sécurité des API modernes.

Cette mise à jour n'a été possible que grâce à l'énorme effort de plusieurs bénévoles, listés dans la [section Remerciements][4].

Merci!

[1]: https://owasp.org/www-project-api-security/announcements/cfd/2022/
[2]: ./0xd0-about-data.md
[3]: ./0x10-api-security-risks.md
[4]: ./0xd1-acknowledgments.md
