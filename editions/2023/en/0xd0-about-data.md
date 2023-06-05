# Methodology and Data

## Overview

For this list update, the OWASP API Security team used the same methodology used
for the successful and well adopted 2019 list, with the addition of a 3 month
[public Call for Data][1]. Unfortunately, this call for data did not result in
data that would have enabled a relevant statistical analysis of the most common
API security issues.

However, with a more mature API security industry capable of providing direct
feedback and insights, the update process moved forward using the same
methodology as before.

Arrived here, we believe to have a good forward-looking awareness document for
the next three or four years, more focused on modern APIs-specific issues. The
goal of this project isn't to replace other top 10 lists, but instead to cover
the existing and upcoming top API security risks that we believe the industry
should be aware and diligent about.

## Methodology

In the first phase, publicly available data about API security incidents were
collected, reviewed, and categorized. Such data were collected from bug bounty
platforms and publicly available reports. Only issues reported between 2019 and
2022 were considered. This data was used to give the team a sense of in which
direction the previous top 10 list should evolve as well as to help deal with
possible contributed data bias.

A public [Call for Data][1] ran from September 1st and November 30th, 2022. In
parallel the project team started the discussion about what has changed since
2019. The discussion included the impact of the first list, feedback received
from the community, and new trends of API security.

The project team promoted meetings with specialists on relevant API security
threats to get insights into how victims are impacted and how those threats can
be mitigated.

This effort resulted in an initial draft of what the team believes were the ten
most critical API security risks. The [OWASP Risk Rating Methodology][2] was
used to perform the risk analysis. Prevalence ratings were decided from a
consensus among the project team members, based on their experience in the
field. For considerations on these matters, please refer to the [API Security
Risks][3] section.

The initial draft was then shared for review with security practitioners with
relevant experience in the API security fields. Their comments were reviewed,
discussed, and when applicable included in the document. The resulting document
was [published as a Release Candidate][4] for [open discussion][5]. Several
[community contributions][6] were included into the final document.

The list of contributors is available in the [Acknowledgments][7] section.

## API Specific Risks

The list is built to address security risks that are more specific to APIs.

It does not imply that other generic application security risks don't exist in
API based applications. For example, we didn't include risks such as "Vulnerable
and Outdated Components" or "Injection", even though you might find them in API
based applications. These risks are generic, they don't behave differently in
APIs, nor their exploitation is different.

Our goal is to increase the awareness of security risks that deserve special
attention in APIs.

[1]: https://owasp.org/www-project-api-security/announcements/cfd/2022/
[2]: https://www.owasp.org/index.php/OWASP_Risk_Rating_Methodology
[3]: ./0x10-api-security-risks.md
[4]: https://owasp.org/www-project-api-security/announcements/2023/02/api-top10-2023rc
[5]: https://github.com/OWASP/API-Security/issues?q=is%3Aissue+label%3A2023RC
[6]: https://github.com/OWASP/API-Security/pulls?q=is%3Apr+label%3A2023RC
[7]: ./0xd1-acknowledgments.md
