# API3:2023 Broken Object Property Level Authorization

| Agentes Ameaça/Vetores Ataque | Falha Segurança | Impactos |
| - | - | - |
| Específico da API : Abuso **Fácil** | Prevalência **Comum** : Deteção **Fácil** | Técnico **Moderado** : Específico Negócio |
| As APIs tendem a expor _endpoints_ que devolvem todas as propriedades do objeto. Isto é especialmente válido para APIs REST. Para outros protocolos como o GraphQL, pode ser necessário enviar pedidos elaborados para especificar que propriedades devem ser devolvidas. Identificar estas propriedades adicionais que podem ser manipuladas requer mais esforço, mas existem algumas ferramentas automatizadas disponíveis para ajudar nesta tarefa. | Inspecionar as respostas da API é suficiente para identificar informações sensíveis nas representações dos objetos devolvidos. _Fuzzing_ é geralmente usado para identificar propriedades adicionais (ocultas). Determinar se podem ser alteradas depende da elaboração de um pedido à API e da análise da resposta. Pode ser necessária uma análise de efeitos secundários se a propriedade alvo não for devolvida na resposta da API. | O acesso não autorizado a propriedades privadas/sensíveis de objetos pode resultar na divulgação de dados, perda de dados ou corrupção de dados. Em certas circunstâncias, o acesso não autorizado a propriedades de objetos pode levar a elevação de privilégios ou a apropriação parcial/completa de conta. |

## A API é vulnerável?

Ao permitir que um utilizador aceda a um objeto através de um _endpoint_ da API, 
é importante validar que o utilizador tem acesso às propriedades específicas do 
objeto que está a tentar aceder.

Um _endpoint_ de uma API é vulnerável se:

* O _endpoint_ da API expõe propriedades de um objeto que são consideradas
  sensíveis e não devem ser lidas pelo utilizador. (anteriormente denominado:
  "[Excessive Data Exposure][1]")
* O _endpoint_ da API permite que um utilizador altere, adicione ou elimine o
  valor de uma propriedade sensível de um objeto ao qual o utilizador não deve
  ter acesso. (anteriormente denominado: "[Mass Assignment][2]")

## Exemplos de Cenários de Ataque

### Cenário #1

Uma aplicação de encontros permite a um utilizador denunciar outros utilizadores
por comportamento inadequado. Como parte deste processo, o utilizador clica num 
botão de 'denúncia', e é desencadeada a seguinte chamada de API:

```
POST /graphql
{
  "operationName":"reportUser",
  "variables":{
    "userId": 313,
    "reason":["offensive behavior"]
  },
  "query":"mutation reportUser($userId: ID!, $reason: String!) {
    reportUser(userId: $userId, reason: $reason) {
      status
      message
      reportedUser {
        id
        fullName
        recentLocation
      }
    }
  }"
}
```

O endpoint da API é vulnerável porque permite que o utilizador autenticado tenha 
acesso a propriedades sensíveis do utilizador denunciado, como "fullName" (nome 
completo) e "recentLocation" (localização recente), que não deveriam estar 
acessíveis a outros utilizadores.

### Cenário #2

Uma plataforma de mercado online, que permite a um tipo de utilizadores 
('anfitriões') alugar o seu apartamento a outro tipo de utilizadores 
('hóspedes'), requer que o anfitrião aceite uma reserva feita por um hóspede 
antes de cobrar ao hóspede pela estadia.

Como parte deste processo, é feito um pedido de API pelo anfitrião para
`POST /api/host/approve_booking` com o seguinte conteúdo legítimo:

```
{
  "approved": true,
  "comment": "Check-in is after 3pm"
}
```

O anfitrião reenvia o pedido legítimo e adiciona o seguinte conteúdo malicioso:

```
{
  "approved": true,
  "comment": "Check-in is after 3pm",
  "total_stay_price": "$1,000,000"
}
```

O _endpoint_ da API é vulnerável porque não há validação de que o anfitrião 
deve ter acesso à propriedade interna do objeto - `total_stay_price`, e o 
hóspede vai ser cobrado mais do que deveria.

### Cenário #3

Uma rede social baseada em vídeos curtos, impõe filtros restritivos de conteúdo 
e censura. Mesmo que um vídeo carregado seja bloqueado, o utilizador pode 
alterar a descrição do vídeo utilizando o seguinte pedido à API:

```
PUT /api/video/update_video

{
  "description": "a funny video about cats"
}
```

Um utilizador frustrado pode reenviar o pedido legítimo e adicionar o seguinte 
conteúdo malicioso:

```
{
  "description": "a funny video about cats",
  "blocked": false
}
```

O _endpoint_ da API é vulnerável porque não há validação se o utilizador deve 
ter acesso à propriedade interna do objeto - `blocked`, e o utilizador pode 
alterar o valor de `true` para `false` e desbloquear o seu próprio conteúdo 
bloqueado.

## Como Prevenir

* Ao expor um objeto através de um _endpoint_ da API, certifique-se sempre de 
  que o utilizador deve ter acesso às propriedades do objeto que expõe.
* Evite usar métodos genéricos como `to_json()` e `to_string()`. Em vez disso,
  selecione especificamente as propriedades do objeto que deseja retornar.
* Se possível, evite usar funções que automaticamente vinculem os dados
  provenientes do cliente em variáveis de código, objetos internos ou
  propriedades de objetos ("Mass Assignment").
* Permita alterações apenas nas propriedades do objeto que devam ser
  atualizadas pelo cliente.
* Implemente um mecanismo de validação de resposta baseado num esquema como uma 
  camada extra de segurança. Como parte deste mecanismo, defina e imponha que 
  dados são retornados por todos os métodos da API.
* Mantenha as estruturas de dados retornadas ao mínimo essencial, de acordo com 
  os requisitos comerciais/funcionais para o _endpoint_.

## Referências

### OWASP

* [API3:2019 Excessive Data Exposure - OWASP API Security Top 10 2019][1]
* [API6:2019 - Mass Assignment - OWASP API Security Top 10 2019][2]
* [Mass Assignment Cheat Sheet][3]

### Externas

* [CWE-213: Exposure of Sensitive Information Due to Incompatible Policies][4]
* [CWE-915: Improperly Controlled Modification of Dynamically-Determined Object Attributes][5]

[1]: https://owasp.org/API-Security/editions/2019/en/0xa3-excessive-data-exposure/
[2]: https://owasp.org/API-Security/editions/2019/en/0xa6-mass-assignment/
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Mass_Assignment_Cheat_Sheet.html
[4]: https://cwe.mitre.org/data/definitions/213.html
[5]: https://cwe.mitre.org/data/definitions/915.html
