# What's Next For Developers

The task to create and maintain secure applications, or fixing existing
applications, can be difficult. It is no different for APIs.

We believe that education and awareness are key factors to writing secure
software. Everything else required to accomplish the goal depends on
**establishing and using repeatable security processes and standard security
controls**.

OWASP provides numerous free and open resources to help you address security.
Please visit the [OWASP Projects page][1] for a comprehensive list of available
projects.

| | |
|-|-|
| **Education** | The [Application Security Wayfinder][2] should give you a good idea about what projects are available for each stage/phase of the Software Development LifeCycle (SDLC). <br><br>For hands-on learning/training you can start with [OWASP **crAPI** - **C**ompletely **R**idiculous **API**][3] or [OWASP Juice Shop][4]: both have intentionally vulnerable APIs. The [OWASP Vulnerable Web Applications Directory Project][5] also provides a curated list of intentionally vulnerable applications: you'll find there several other vulnerable APIs. <br><br>You can also attend [OWASP AppSec Conference][6] training sessions, or [join your local chapter][7]. |
| **Security Requirements** | Security should be part of every project from the beginning. When defining requirements, it is important to define what "secure" means for that project. OWASP recommends you use the [OWASP Application Security Verification Standard (ASVS)][8] as a guide for setting the security requirements. <br><br>If you're outsourcing, consider the [OWASP Secure Software Contract Annex][9], which should be adapted according to local law and regulations. |
| **Security Architecture** | Security should remain a concern during all the project stages. The [OWASP Cheat Sheet Series][10] is a good starting point for guidance on how to design security in during the architecture phase. Among many others, you'll find the [REST Security Cheat Sheet][11] and the [REST Assessment Cheat Sheet][12] as well the [GraphQL Cheat Sheet][13]. <br><br>When considering security in the architecture of a new API project, it is important to perform threat modelling against the current state of the design and architecture of the system. The [OWASP Threat Modelling Process][14] provides a structured approach to application threat modeling. |
| **Standard Security Controls** | Adopting standard security controls reduces the risk of introducing security weaknesses while writing your own logic. Although many modern frameworks now come with effective built-in standard controls, [OWASP Proactive Controls][15] gives you a good overview of what security controls you should look to include in your project. <br><br>OWASP also provides some libraries and tools you may find valuable, such as validation controls. |
| **Secure Code Review** | It is important that developers continuously review code for potential security issues. The [OWASP Code Review Guide][16] has been written to assist technical staff in manual code review via an initial section on “why and how of code reviews” and a secondary section focusing on the “types of vulnerabilities and how to identify throughout the review”. |
| **Secure Software Development Life Cycle** | You can use the [OWASP Software Assurance Maturity Model (SAMM)][17] to improve your processes of building APIs. |


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
[14]: https://owasp.org/www-community/Threat_Modeling_Process
[15]: https://owasp.org/www-project-proactive-controls/
[16]: https://owasp.org/www-project-code-review-guide/
[17]: https://owasp.org/www-project-samm/ 
