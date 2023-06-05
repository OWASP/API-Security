# API6:2019 - Mass Assignment

| Agentes Ameaça/Vetores Ataque | Falha Segurança | Impactos |
| - | - | - |
| Específico da API : Abuso **2** | Prevalência **2** : Deteção **2** | Técnico **2** : Específico Negócio |
| O abuso requer na maioria das vezes um conhecimento da lógica de negócio, de relações entre objetos, e da estrutura da API. Abusar de Mass Assignment é mais fácil em APIs, visto que por design elas expõem a implementação interna da aplicação e nomes de propriedades. | As _frameworks_ modernas incentivam os programadores a usar funções que ligam automaticamente dados do cliente a variáveis no código e objetos internos. Os atacantes podem usar esta metodologia para atualizar ou mudar propriedades sensíveis de objetos que os programadores não pretendiam realmente expor. | O abuso pode levar a elevação de privilégios, manipulação de dados, contornar mecanismos de segurança, etc. |

## A API é vulnerável?

Os objetos em aplicações modernas podem conter muitas propriedades. Algumas
destas propriedades podem ser atualizadas diretamente pelo cliente (e.g.,
`user.first_name` ou `user.address`), mas outras não (e.g., a _flag_
`user.is_vip`).

Um _endpoint_ é vulnerável se converter automaticamente parâmetros do
cliente em propriedades internas de um objeto, sem considerar a sensibilidade e
o nível de exposição destas propriedades. Isto pode permitir a um atacante
atualizar propriedades de objetos, às quais ele não deveria ter acesso.

Exemplos de propriedades sensíveis:

* **Propriedades relacionadas com permissões**: `user.is_admin`, `user.is_vip`
  devem ser modificadas apenas por administradores.
* **Propriedades dependentes de processos**: `user.cash` deve ser modificada
  apenas internamente depois da verificação de pagamento.
* **Propriedades internas**: `article.created_time` deve ser modificada apenas
  internamente pela aplicação.

## Exemplos de Cenários de Ataque

### Cenário #1

Uma aplicação de partilha de transporte tem ao dispor do utilizador uma opção
para editar informações básicas para o seu perfil. Durante este processo, um
pedido à API é enviado para `PUT /api/v1/users/me` com o seguinte objeto JSON
legítimo:

```json
{"user_name":"inons","age":24}
```

O pedido `GET /api/v1/users/me` incluí uma propriedade `credit_balance`
adicional:

```json
{"user_name":"inons","age":24,"credit_balance":10}
```

O atacante envia novamente o primeiro pedido com o seguinte conteúdo:

```json
{"user_name":"attacker","age":60,"credit_balance":99999}
```

Dado que o _endpoint_ é vulnerável a mass assignment, o atacante recebe crédito
sem ter efetuado qualquer pagamento.

### Cenário #2

Um portal de partilha de vídeo permite carregar e descarregar conteúdo em
diferentes formatos. Um atacante que investigou a API descobriu que o _endpoint_
`GET /api/v1/videos/{video_id}/meta_data` devolve um objeto JSON com as
propriedades do vídeo. Uma das propriedades é
`"mp4_conversion_params":"-v codec h264"`, que revela que a aplicação utiliza um
comando _shell_ para converter o vídeo.

O atacante também descobriu o _endpoint_ `POST /api/v1/videos/new` que é
vulnerável a Mass Assignment, permitindo ao cliente modificar qualquer
propriedade do objeto. O atacante atribui um valor malicioso como o seguinte:
`"mp4_conversion_params":"-v codec h264 && format C:/"`. Este valor vai causar
uma injeção de um comando _shell_ assim que o atacante descarregar o vídeo no
formato MP4.

## Como Prevenir

* Se possível, evitar usar funções que convertem automaticamente parâmetros do
  cliente em variáveis de código ou objetos internos.
* Ter uma lista onde constam apenas os nomes das propriedades que o cliente pode
  atualizar.
* Usar funcionalidades já existentes para ter uma lista de propriedades que não
  devem ser acedidas por clientes.
* Se possível, definir explicitamente e forçar a utilização de _schemas_ para o
  conteúdo dos pedidos.

## Referências

### Externas

* [CWE-915: Improperly Controlled Modification of Dynamically-Determined Object
  Attributes][1]

[1]: https://cwe.mitre.org/data/definitions/915.html
