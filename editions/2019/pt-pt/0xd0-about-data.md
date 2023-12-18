# Metodologia e Dados

## Preâmbulo

Uma vez que a indústria de segurança aplicacional não tem estado focada
especificamente nas arquiteturas aplicacionais mais recentes, nas quais as APIs
têm um papel importante, compilar a lista dos riscos de segurança mais críticos
para APIs com base numa consulta pública de dados teria sido uma tarefa árdua.
Apesar desta consulta pública de dados não ter sido feita, a lista atual é ainda
resultado de informação que se encontra disponível publicamente, assim como de
contribuições de especialista em segurança e da discussão aberta à comunidade de
segurança.

## Metodologia e Dados

Numa primeira fase um grupo de especialistas em segurança recolheu, reviu e
categorizou informação relativa a incidentes relacionados com APIs que se
encontrava disponível publicamente. Esta informação foi recolhida de plataformas
de _bug bounty_ e bases de dados de falhas de segurança, restringida a
incidentes ocorridos no último ano. Esta informação foi usada para fins
estatísticos.

Na fase seguinte, foi pedido a um grupo de profissionais de segurança com
experiência em testes de penetração que criassem a seu próprio Top 10.

A [Metodologia de Classificação de Risco da OWASP][1] foi usada para realizar a
análise de risco e as classificações foram discutidas e revistas entre os
profissionais de segurança. Para mais informação sobre este assunto consulte a
secção [Riscos de Segurança em APIs][2].

O primeiro rascunho do OWASP API Security Top 10 2019 resultou do consenso entre
os dados estatísticos da primeira fase e as listas compiladas pelos
profissionais de segurança. Este rascunho foi depois submetido à apreciação e
revisão por outro grupo de profissionais de segurança com experiência relevante
em segurança de APIs.

O OWASP API Security Top 10 2019 foi apresentado publicamente pela primeira vez
na conferência OWASP Global AppSec Tel Aviv (Maio 2019). Desde então ele tem
estado disponível no GitHub para discussão e contribuições.

A lista de todos os que contribuíram para esta versão encontra-se na secção
[Agradecimentos][3].

[1]: https://owasp.org/www-project-risk-assessment-framework/
[2]: ./0x10-api-security-risks.md
[3]: ./0xd1-acknowledgments.md
