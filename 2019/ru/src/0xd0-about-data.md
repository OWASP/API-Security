Методология и данные
====================

## Обзор

Since the AppSec industry has not been specifically focused on the most recent
architecture of applications, in which APIs play an important role, compiling a
list of the ten most critical API security risks, based on a public call for
data, would have been a hard task. Despite there being no public data call, the
resulting Top 10 list is still based on publicly available data, security
experts' contributions, and open discussion with the security community.

Поскольку индустрия AppSec не сфокусирована главным образом на новейшей архитектуре приложений, в которой API играют важную роль, составление списка из десяти наиболее критичных рисков безопасности API на базе публичного сбора данных - сложная задача. Несмотря на отсутствие публичного сбора данных, получившийся список все равно основан на общедоступной информации, вкладе экспертов по безопасности и открытых дискуссиях сообщества по безопасности.

## Методология

In the first phase, publicly available data about APIs security incidents were
collected, reviewed, and categorized by a group of security experts. Such
data was collected from bug bounty platforms and vulnerability databases,
within a one-year-old time frame. It was used for statistical purposes.

На первом этапе группа экспертов по безопасности собрала, проанализировала и категоризировала публичные данные об инцидентах безопасности в API. Эти данные были собраны с площадок bug bounty площадок и баз данных уязвимостей за последний год. Этот временной промежуток выбран для удобства расчета статистики.

In the next phase, security practitioners with penetration testing experience
were asked to compile their own Top 10 list.

Затем эксперты по безопасности с опытом тестирования на проникновение составили свой список 10-ти наиболее критичных рисков.

The [OWASP Risk Rating Methodology][1] was used to perform he Risk Analysis. The
scores were discussed and reviewed between the security practitioners. For
considerations on these matters, please refer to the [API Security Risks][2]
section.

[Методология ранжирования рисков OWASP][1] была использована в ходе анализа рисков. Эксперты по безопасности проанализировали результаты. Чтобы узнать о рассуждениях на эту тему обратитесь к секции [Риски безопасности API][2].

The first draft of the OWASP API Security Top 10 2019 resulted from a consensus
between statistical results from phase one, and the security practitioners'
lists. This draft was then submitted for appreciation and review by another
group of security practitioners, with relevant experience in the API security
fields.

Первый черновик OWASP API Security Top 10 2019 был составлен на базе статистических результатов первого этапа и списков, созданных экспертами по безопасности. Этот черновик был отправлен для проверки и анализа другой группе экспертов по безопасности с достаточным опытом в сфере безопасности API.

The OWASP API Security Top 10 2019 was first presented in the OWASP Global
AppSec Tel Aviv event (May 2019). Since then, it has been available on GitHub
for public discussion and contributions.

OWASP API Security Top 10 2019 впервые был представлен на конференции OWASP Global AppSec Tel Aviv в мае 2019 года. С тех пор он доступен на GitHub для публичного обсуждения и содействия.

The list of contributors is available in the [Acknowledgments][3] section.

Список участников, внесших свой вклад, доступен в секции [Благодарность][3].

[1]: https://www.owasp.org/index.php/OWASP_Risk_Rating_Methodology
[2]: ./0x10-api-security-risks.md
[3]: ./0xd1-acknowledgments.md
