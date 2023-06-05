# API4:2019 Lack of Resources & Rate Limiting

| Agentes/Vetores | Fraquezas de Segurança | Impactos |
| - | - | - |
| Específico da API : Explorabilidade **2** | Prevalência **3** : Detecção **3** | Técnico **2** : Específico do negócio |
| A exploração requer simples requisições na API. Não é necessária autenticação. Requisições múltiplas e concorrentes podem ser executadas de um único ponto utilizando um único computador ou ainda utilizando recursos em nuvem. | É comum encontrar APIs que não implementam limites ou estes limites não estão implementados corretamente. | A exploração pode levar ao DoS, levando a API à lentidão ou à completa indisponbilidade. |

## A API está vulnerável?

Requisições de API consome recursos como rede, processador, memória e armazenamento. A quantidade de recursos necessária para um desempenho satisfatório depende da entrada do usuário e da lógica de negócio da API. Considere também que o fato de múltiplas chamadas na API a partir de diversos clientes irão competir pelos recursos. Um API é vulnerável se algum dos seguintes parâmetros estiverem ausentes ou mal configurados (em excesso ou muito baixos):

* Tempo limite de execução (*timeout*)
* Limite máximo de alocação de memória
* Número de *file descriptors*
* Número de processadores
* Tamanho de *payload* (ex. uploads)
* Número de requisições por cliente/recurso
* Número de registros por página a retornar em uma única requisição

## Cenários de exemplo de ataques

### Cenário #1

Um atacante faz *uploads* de imagens grandes enviando request POST em `/api/v1/images`, quando o upload é finalizado, a API cria múltiplos *thumbnails* com diferentes tamanhos. Devido ao grande tamanho da imagem enviada por upload, a memória disponível é exaurida durante a criação dos *thumbnails* e a API fica indisponível.

### Cenário #2

Uma aplicação contém uma lista de usuários em uma interface com o limite de `200` usuários por página. A lista é solicitada ao servidor utilizando a seguinte *query* `/api/users?page=1&size=200`. Um atacante modifica o parâmetro `size` de `200` para `200000`, provocando problemas de desempenho no banco de dados. Enquanto isso, a API torna-se indisponível e portanto incapaz de responder outras requisições deste e de todos os demais clientes (também conhecido como DoS).

Este mesmo cenário pode ser utilizado para provocar erros de *Integer Overflow* ou *Buffer Overflow*.

## Como prevenir

* Docker torna mais fácil limitar [memória][1], [CPU][2], [quantidade de *restart*][3], [*file descriptors*, e processos][4].
* Implemente um limite de frequência para um cliente chamar a API em um determinado espaço de tempo.
* Notifique o cliente quando o limite for excedido, informando o limite e quando o limite alcançado será reiniciado.
* Adicione validações do lado do servidor para validação de parâmetros, principalmente controles de quantidade de registros a serem retornados.
* Defina e implemente tamanhos máximos de dados recebidos por parâmetro e *payloads*.

## Referências

### OWASP

* [Blocking Brute Force Attacks][5]
* [Docker Cheat Sheet - Limit resources (memory, CPU, file descriptors,
  processes, restarts)][6]
* [REST Assessment Cheat Sheet][7]

### Externas

* [CWE-307: Improper Restriction of Excessive Authentication Attempts][8]
* [CWE-770: Allocation of Resources Without Limits or Throttling][9]
* “_Rate Limiting (Throttling)_” - [Security Strategies for Microservices-based
  Application Systems][10], NIST

[1]: https://docs.docker.com/config/containers/resource_constraints/#memory
[2]: https://docs.docker.com/config/containers/resource_constraints/#cpu
[3]: https://docs.docker.com/engine/reference/commandline/run/#restart-policies---restart
[4]: https://docs.docker.com/engine/reference/commandline/run/#set-ulimits-in-container---ulimit
[5]: https://owasp.org/www-community/controls/Blocking_Brute_Force_Attacks
[6]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/Docker_Security_Cheat_Sheet.md#rule-7---limit-resources-memory-cpu-file-descriptors-processes-restarts
[7]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/REST_Assessment_Cheat_Sheet.md
[8]: https://cwe.mitre.org/data/definitions/307.html
[9]: https://cwe.mitre.org/data/definitions/770.html
[10]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-204-draft.pdf
