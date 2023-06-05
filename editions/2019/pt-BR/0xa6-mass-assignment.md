# API6:2019 - Mass Assignment

| Agentes/Vetores | Fraquezas de Segurança | Impactos |
| - | - | - |
| Específico da API : Explorabilidade **2** | Prevalência **2** : Detecção **2** | Técnico **2** : Específico do negócio |
| A exploração usualmente requer compreensão da lógica de negócio, relação entre objetivos e estrutura da API. Este tipo de exploração é mais fácil em APIs, uma vez que por *design* elas expõem implementações internas do aplicativo junto de suas propriedades. | *Frameworks* modernos encorajam desenvolvedores a utilizar funções que automaticamente conectam a entrada do cliente em variáveis de código e objetos internos. Atacantes podem utilizar esta metodologia para atualizar ou sobrescrever propriedades em objetos sensíveis que os desenvolvedores nunca tiveram intenção de expor. | A exploração pode levar a escalação de privilégios, adulteração de dados, desvio de mecanismos de segurança, entre outros. |

## A API está vulnerável?

Objetos em aplicativos modernos podem conter muitas propriedades. Algumas dessas propriedades podem ser diretamente atualizadas pelo cliente (ex.: `user.first_name` ou `user.address`), outras propriedades por sua vez podem não ser (ex.: o *flag* `user.is_vip`).

Um *endpoint* de API está vulnerável se ele automaticamente converte parâmetros recebidos do cliente em propriedades de objeto internos, sem considerar o quão sensível são estas mesmas propriedades. Isto pode permitir a um atacante atualizar propriedades de um objeto ao qual ele não deveria ter acesso.

Exemplos de propriedades sensíveis:

* **Propriedades relacionadas à permissões**: `user.is_admin`, `user.is_vip` devem ser escritas somente por admins.
* **Propriedades que depende de processamento**: `user.cash` deve ser escrita somente após a efetivação/verificação do pagamento.
* **Propriedades internas**: `article.created_time` deve ser escrita apenas internamente pela aplicação.

## Cenários de exemplo de ataques

### Cenário #1

Um aplicativo de compartilhamento de corridas permite ao usuário a opção de editar informações e dados básicos do seu perfil. Durante este processo, uma chamada à API é enviada para `PUT /api/v1/users/me` com o seguinte, e legítimo, objeto JSON:

```json
{"user_name":"inons","age":24}
```
A requisição `GET /api/v1/users/me` inclui uma propriedade adicional chamada "credit_balance property":

```json
{"user_name":"inons","age":24,"credit_balance":10}
```
O atacante repete a primeira requisição com o *payload* abaixo:

```json
{"user_name":"attacker","age":60,"credit_balance":99999}
```

Uma vez que o *endpoint* está vulnerável, o atacante recebe créditos sem pagar.

### Cenário #2

Um portal de compartilhamento de vídeos permite aos usuários o envio de conteúdo e *download* de conteúdo em diferentes formatos. Um atacante explora a API no *endpoint* `GET /api/v1/videos/{video_id}/meta_data` que retorna um objeto com propriedades do vídeo. Uma das propriedades é `"mp4_conversion_params":"-v codec h264"`, que indica que a aplicação usa um comando *shell* para converter o vídeo.
 
Este mesmo atacante encontrou o *endpoint* `POST /api/v1/videos/new` que está vulnerável e permite ao cliente atribuir qualquer propriedade ao objeto vídeo, então o atacante atribui um valor malicioso como o exemplo a seguir: `"mp4_conversion_params":"-v codec h264 && format C:/"`. Este valor poderá causar a execução de um comando *shell* quando o atacante pedir o *download* do vídeo no formato mp4.

## Como prevenir

* Se possível evite usar funções que automaticamente conectam entradas de usuário em variáveis no código ou em objetos internos.
* Desenvolva controles para permitir que apenas determinadas propriedades possam ser atualizadas pelo cliente.
* Use recursos *built-in* para criar listas de proibição do que não deve ser acessado pelo cliente.
* Se aplicável, aplique de maneira explícita *schemas* nas entradas de *payload* dos usuários.

## Referências

### Externas

* [CWE-915: Improperly Controlled Modification of Dynamically-Determined Object Attributes][1]

[1]: https://cwe.mitre.org/data/definitions/915.html
