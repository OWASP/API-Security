# Metodologia e Dados

## Preâmbulo

Para esta atualização da lista, a equipa de Segurança de API da OWASP utilizou a
mesma metodologia adotada com sucesso para a lista de 2019, com a adição de um 
[Pedido Público por Dados][1] de 3 meses. Infelizmente, este pedido não resultou
em dados que permitissem uma análise estatística relevante sobre os problemas de
segurança de API mais comuns.

Contudo, com uma indústria de segurança de API mais madura e capaz de fornecer 
feedback e informações diretamente, o processo de atualização avançou usando a 
mesma metodologia de antes.

Chegados a este ponto, acreditamos ter um bom documento de consciencialização 
para os próximos três ou quatro anos, mais focado nas questões específicas das 
APIs modernas. O objetivo deste projeto não é substituir outras listas de top 
10, mas sim cobrir os principais riscos de segurança de API atuais e emergentes,
sobre os quais acreditamos que a indústria deve estar atenta e ser diligente.

## Metodologia

Na primeira fase, dados publicamente disponíveis sobre incidentes de segurança 
em APIs foram recolhidos, revistos e categorizados. Esses dados foram obtidos de
plataformas de _bug bounty_ e relatórios públicos. Apenas problemas reportados 
entre 2019 e 2022 foram considerados. Esses dados ajudaram a equipa a entender 
em que direção a lista de top 10 anterior deveria evoluir, assim como a lidar 
com possíveis vieses dos dados contribuídos.

Um [Pedido Público por Dados][1] foi realizado de 1 de Setembro a 30 de Novembro
de 2022. Em paralelo, a equipa do projeto iniciou a discussão sobre o que mudou 
desde 2019. A discussão incluiu o impacto da primeira lista, o feedback recebido
da comunidade e novas tendências na segurança de APIs.

A equipa do projeto promoveu reuniões com especialistas sobre ameaças relevantes
à segurança de APIs para obter informações sobre como as vítimas são impactadas 
e como essas ameaças podem ser mitigadas.

Este esforço resultou num rascunho inicial do que a equipa acredita serem os dez
riscos mais críticos de segurança para APIs. A [Metodologia de Classificação de 
Risco da OWASP][2] foi utilizada para realizar a análise de riscos. As 
classificações de prevalência foram decididas por consenso entre os membros da 
equipa do projeto, com base na sua experiência na área. Para considerações sobre
esses temas, consulte a secção [Riscos de Segurança em APIs][3].

O rascunho inicial foi então compartilhado para revisão com profissionais de 
segurança com experiência relevante na área de segurança de APIs. Os seus 
comentários foram analisados, discutidos e, quando aplicável, incluídos no 
documento. O documento resultante foi [publicado como uma Versão Candidata][4] 
para [discussão aberta][5]. Várias [contribuições da comunidade][6] foram 
incorporadas no documento final.

A lista de contribuidores está disponível na secção de [Agradecimentos][7].

## Riscos Específicos de APIs

A lista foi elaborada para abordar riscos de segurança que são mais específicos 
para APIs.

Não implica que outros riscos genéricos de segurança de aplicações não existam 
em aplicações baseadas em APIs. Por exemplo, não incluímos riscos como 
"Componentes Vulneráveis e Desatualizados" ou "Injeção", embora você possa 
encontrá-los em aplicações baseadas em APIs. Esses riscos são genéricos, não se 
comportam de forma diferente em APIs, nem a sua exploração é diferente.

O nosso objetivo é aumentar a conscientização sobre os riscos de segurança que 
merecem atenção especial em APIs.

[1]: https://owasp.org/www-project-api-security/announcements/cfd/2022/
[2]: https://www.owasp.org/index.php/OWASP_Risk_Rating_Methodology
[3]: ./0x10-api-security-risks.md
[4]: https://owasp.org/www-project-api-security/announcements/2023/02/api-top10-2023rc
[5]: https://github.com/OWASP/API-Security/issues?q=is%3Aissue+label%3A2023RC
[6]: https://github.com/OWASP/API-Security/pulls?q=is%3Apr+label%3A2023RC
[7]: ./0xd1-acknowledgments.md
