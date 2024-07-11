# API4:2023 Unrestricted Resource Consumption

| Agentes Ameaça/Vetores Ataque | Falha Segurança | Impactos |
| - | - | - |
| Específico da API : Abuso **Moderado** | Prevalência **Predominante** : Deteção **Fácil** | Técnico **Grave** : Específico Negócio |
| A exploração requer pedidos simples de API. Múltiplos pedidos concorrentes podem ser feitos a partir de um único computador local ou utilizando recursos de computação em nuvem. A maioria das ferramentas automatizadas disponíveis são projetadas para causar DoS (Negação de Serviço) através de altas cargas de tráfego, afetando a taxa de serviço das APIs. | É comum encontrar APIs que não limitam as interações do cliente ou o consumo de recursos. Pedidos de API elaborados, como aqueles que incluem parâmetros que controlam o número de recursos a serem retornados e realizam análises de estado/tempo/comprimento de resposta, devem permitir a identificação do problema. O mesmo vale para operações em quantidade. Embora os agentes maliciosos não tenham visibilidade sobre o impacto nos custos, isso pode ser inferido com base no modelo de negócios/preços dos fornecedores de serviços (e.g. fornecedor de nuvem). | A exploração pode levar a uma Negação de Serviço (DoS) devido à escassez de recursos, mas também pode resultar num aumento dos custos operacionais, como os relacionados à infraestrutura devido à maior exigência de CPU, aumento das necessidades de armazenamento em nuvem, etc. |

## A API é vulnerável?

Para atender aos pedidos feitos à API, são necessários recursos como largura de 
banda de rede, CPU, memória e armazenamento. Às vezes, os recursos necessários 
são disponibilizados por provedores de serviços por meio de integrações de API 
e são pagos por pedido, como o envio de emails/SMS/chamadas telefónicas, 
validação biométrica, etc.

Uma API é vulnerável se pelo menos um dos seguintes limites estiver ausente ou 
definido inadequadamente (e.g. muito baixo/alto):

* Tempos limite de execução
* Memória máxima alocável
* Número máximo de descritores de ficheiro
* Número máximo de processos
* Tamanho máximo de upload de ficheiro
* Número de operações a serem realizadas num único pedido do cliente da API
  (e.g. agrupamento GraphQL)
* Número de registros por página a serem retornados num único pedido-resposta
* Limite de gastos de provedores de serviços terceiros

## Exemplos de Cenários de Ataque

### Cenário #1

Uma rede social implementou um mecanismo de "recuperar senha" através da 
verificação por SMS, permitindo que o utilizador receba um _token_ de uso único 
via SMS para redefinir a sua senha.

Uma vez que o utilizador clica em "recuperar senha", é feita uma chamada API a 
partir do navegador do utilizador para a API de _back-end_:

```
POST /initiate_forgot_password

{
  "step": 1,
  "user_number": "6501113434"
}
```

Em seguida, nos bastidores, é feita uma chamada API do _back-end_ para uma API 
de terceiros que se encarrega da entrega do SMS:

```
POST /sms/send_reset_pass_code

Host: willyo.net

{
  "phone_number": "6501113434"
}
```

O fornecedor de terceiros, Willyo, cobra $0.05 por este tipo de chamada.

Um atacante escreve código que envia a primeira chamada API dezenas de milhares 
de vezes. O _back-end_ prossegue e solicita à Willyo que envie dezenas de 
milhares de mensagens de texto, levando a empresa a perder milhares de dólares 
em questão de minutos.

### Cenário #2

Um _endpoint_ de API GraphQL permite que o utilizador carregue uma foto de 
perfil.

```
POST /graphql

{
  "query": "mutation {
    uploadPic(name: \"pic1\", base64_pic: \"R0FOIEFOR0xJVA…\") {
      url
    }
  }"
}
```

Uma vez concluído o carregamento, a API gera múltiplas miniaturas com diferentes 
tamanhos com base na imagem carregada. Esta operação gráfica consome muita 
memória do servidor.

A API implementa uma proteção tradicional de limitação de quantidade de pedidos 
- um utilizador não pode aceder ao _endpoint_ GraphQL demasiadas vezes num curto
período de tempo. A API também verifica o tamanho da imagem carregada antes de
gerar as miniaturas para evitar o processamento de imagens demasiado grandes.

Um atacante pode facilmente contornar esses mecanismos, aproveitando a natureza 
flexível do GraphQL:

```
POST /graphql

[
  {"query": "mutation {uploadPic(name: \"pic1\", base64_pic: \"R0FOIEFOR0xJVA…\") {url}}"},
  {"query": "mutation {uploadPic(name: \"pic2\", base64_pic: \"R0FOIEFOR0xJVA…\") {url}}"},
  ...
  {"query": "mutation {uploadPic(name: \"pic999\", base64_pic: \"R0FOIEFOR0xJVA…\") {url}}"},
}
```

Como a API não limita o número de vezes que a operação `uploadPic` pode ser 
tentada, a chamada levará ao esgotamento da memória do servidor e à negação de 
serviço (_Denial of Service_).

### Cenário #3

Um prestador de serviços permite que os clientes descarreguem ficheiros 
arbitrariamente grandes através da sua API. Estes ficheiros são mantidos em 
armazenamento de objetos na nuvem e não mudam com frequência. O prestador de 
serviços depende de um serviço de _cache_ para melhorar a velocidade do serviço 
e manter o consumo de largura de banda baixo. O serviço de _cache_ apenas 
armazena ficheiros até 15GB.

Quando um dos ficheiros é atualizado, o seu tamanho aumenta para 18GB. Todos os 
clientes do serviço começam imediatamente a descarregar a nova versão. Como não 
havia alertas de custo de consumo, nem um limite máximo de custo para o serviço 
de nuvem, a fatura mensal seguinte aumenta de 13 dólares, em média, para 8 mil 
dólares.

## Como Prevenir

* Utilize uma solução que facilite a limitação de [memória][1], [CPU][2],
  [número de reinícios][3], [descritores de ficheiros e processos][4], como
  Containers / Código Serverless (e.g. Lambdas).
* Defina e force um tamanho máximo de dados em todos os parâmetros e conteúdos
  de entrada, como comprimento máximo para _strings_,  número máximo de 
  elementos em arrays e tamanho máximo de ficheiro para _upload_ 
  (independentemente de ser armazenado localmente ou na nuvem).
* Implemente um limite de frequência com que um cliente pode interagir com a API
  dentro de um período temporal definido (_rate limiting_).
* A limitação de pedidos deve ser ajustada com base nas necessidades do negócio.
  Alguns endpoints da API podem exigir políticas mais rigorosas.
* Limite/controle quantas vezes ou com que frequência um único 
  cliente/utilizador da API pode executar uma única operação (e.g. validar um 
  OTP ou solicitar a recuperação de senha sem visitar o URL de uso único).
* Adicione validação adequada no lado do servidor para parâmetros da 
  _query string_ e do corpo do pedido, especificamente aqueles que controlam o 
  número de resultados a serem retornados na resposta.
* Configure limites de gastos para todos os fornecedores de serviços/integrações 
  de API. Quando não for possível definir limites de gastos, devem ser 
  configurados alertas de faturamento.

## Referências

### OWASP

* ["Availability" - Web Service Security Cheat Sheet][5]
* ["DoS Prevention" - GraphQL Cheat Sheet][6]
* ["Mitigating Batching Attacks" - GraphQL Cheat Sheet][7]

### Externas

* [CWE-770: Allocation of Resources Without Limits or Throttling][8]
* [CWE-400: Uncontrolled Resource Consumption][9]
* [CWE-799: Improper Control of Interaction Frequency][10]
* "Rate Limiting (Throttling)" - [Security Strategies for Microservices-based
  Application Systems][11], NIST

[1]: https://docs.docker.com/config/containers/resource_constraints/#memory
[2]: https://docs.docker.com/config/containers/resource_constraints/#cpu
[3]: https://docs.docker.com/engine/reference/commandline/run/#restart
[4]: https://docs.docker.com/engine/reference/commandline/run/#ulimit
[5]: https://cheatsheetseries.owasp.org/cheatsheets/Web_Service_Security_Cheat_Sheet.html#availability
[6]: https://cheatsheetseries.owasp.org/cheatsheets/GraphQL_Cheat_Sheet.html#dos-prevention
[7]: https://cheatsheetseries.owasp.org/cheatsheets/GraphQL_Cheat_Sheet.html#mitigating-batching-attacks
[8]: https://cwe.mitre.org/data/definitions/770.html
[9]: https://cwe.mitre.org/data/definitions/400.html
[10]: https://cwe.mitre.org/data/definitions/799.html
[11]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-204.pdf
