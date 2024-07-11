# API7:2023 Server Side Request Forgery

| Agentes Ameaça/Vetores Ataque | Falha Segurança | Impactos |
| - | - | - |
| Específico da API : Abuso **Fácil** | Prevalência **Comum** : Detectability **Fácil** | Técnico **Moderado** : Específico do Negócio |
| A exploração requer que o atacante encontre um _endpoint_ da API que aceda a um URI fornecido pelo cliente. Em geral, SSRF básico (quando a resposta é retornada ao atacante) é mais fácil de explorar do que _Blind_ SSRF, em que o atacante não tem feedback sobre se o ataque foi bem sucedido ou não. | Os conceitos modernos no desenvolvimento de aplicações incentivam os desenvolvedores a aceder a URIs fornecidos pelo cliente. A falta de validação ou a validação inadequada desses URIs são problemas comuns. Será necessária a análise regular de solicitações e respostas da API para detetar o problema. Quando a resposta não é retornada (_Blind_ SSRF), a deteção da vulnerabilidade exige mais esforço e criatividade. | A exploração bem sucedida pode levar à enumeração de serviços internos (e.g. scan de portas), divulgação de informações, bypass de firewalls ou outros mecanismos de segurança. Em alguns casos, pode levar a DoS ou ao uso do servidor como um proxy para ocultar atividades maliciosas. |

## A API é vulnerável?

Falhas de Server-Side Request Forgery (SSRF) ocorrem quando uma API pede um 
recurso remoto sem validar o URL fornecido pelo utilizador. Isso permite que um 
atacante force a aplicação a enviar um pedido manipulado para um destino 
inesperado, mesmo quando protegido por uma firewall ou uma VPN.

Os conceitos modernos no desenvolvimento de aplicações tornam o SSRF mais comum 
e mais perigoso.

Mais comum - os seguintes conceitos incentivam os desenvolvedores a aceder a 
recursos externos com base em entradas de utilizadores: Webhooks, download de 
ficheiros a partir de URLs, SSO personalizado e pré-visualização de URLs.

Mais perigoso - Tecnologias modernas como provedores de nuvem, Kubernetes e 
Docker expõem canais de gestão e controle via HTTP em caminhos previsíveis e 
bem conhecidos. Esses canais são um alvo fácil para um ataque SSRF.

Também é mais desafiador limitar o tráfego de saída da sua aplicação, devido à 
natureza conectada das aplicações modernas.

O risco de SSRF nem sempre pode ser completamente eliminado. Ao escolher um 
mecanismo de proteção, é importante considerar os riscos e necessidades do 
negócio.

## Exemplos de Cenários de Ataque

### Cenário #1

Uma rede social permite que os utilizadores façam o upload de fotos de perfil. 
O utilizador pode escolher entre carregar o ficheiro de imagem do seu 
dispositivo ou fornecer o URL da imagem. Escolher a segunda opção irá acionar a 
seguinte chamada API:

```
POST /api/profile/upload_picture

{
  "picture_url": "http://example.com/profile_pic.jpg"
}
```

An attacker can send a malicious URL and initiate port scanning within the
internal network using the API Endpoint.

```
{
  "picture_url": "localhost:8080"
}
```

Based on the response time, the attacker can figure out whether the port is
open or not.

### Cenário #2

A security product generates events when it detects anomalies in the network.
Some teams prefer to review the events in a broader, more generic monitoring
system, such as a SIEM (Security Information and Event Management). For this
purpose, the product provides integration with other systems using webhooks.

As part of a creation of a new webhook, a GraphQL mutation is sent with the URL
of the SIEM API.

```
POST /graphql

[
  {
    "variables": {},
    "query": "mutation {
      createNotificationChannel(input: {
        channelName: \"ch_piney\",
        notificationChannelConfig: {
          customWebhookChannelConfigs: [
            {
              url: \"http://www.siem-system.com/create_new_event\",
              send_test_req: true
            }
          ]
    	  }
  	  }){
    	channelId
  	}
	}"
  }
]

```

During the creation process, the API back-end sends a test request to the
provided webhook URL, and presents to the user the response.

An attacker can leverage this flow, and make the API request a sensitive
resource, such as an internal cloud metadata service that exposes credentials:

```
POST /graphql

[
  {
    "variables": {},
    "query": "mutation {
      createNotificationChannel(input: {
        channelName: \"ch_piney\",
        notificationChannelConfig: {
          customWebhookChannelConfigs: [
            {
              url: \"http://169.254.169.254/latest/meta-data/iam/security-credentials/ec2-default-ssm\",
              send_test_req: true
            }
          ]
        }
      }) {
        channelId
      }
    }
  }
]
```

Since the application shows the response from the test request, the attacker
can view the credentials of the cloud environment.

## Como Prevenir

* Isolate the resource fetching mechanism in your network: usually these
  features are aimed to retrieve remote resources and not internal ones.
* Whenever possible, use allow lists of:
  * Remote origins users are expected to download resources from (e.g. Google
    Drive, Gravatar, etc.)
  * URL schemes and ports
  * Accepted media types for a given functionality
* Disable HTTP redirections.
* Use a well-tested and maintained URL parser to avoid issues caused by URL
  parsing inconsistencies.
* Validate and sanitize all client-supplied input data.
* Do not send raw responses to clients.

## Referências

### OWASP

* [Server Side Request Forgery][1]
* [Server-Side Request Forgery Prevention Cheat Sheet][2]

### Externas

* [CWE-918: Server-Side Request Forgery (SSRF)][3]
* [URL confusion vulnerabilities in the wild: Exploring parser inconsistencies,
   Snyk][4]

[1]: https://owasp.org/www-community/attacks/Server_Side_Request_Forgery
[2]: https://cheatsheetseries.owasp.org/cheatsheets/Server_Side_Request_Forgery_Prevention_Cheat_Sheet.html
[3]: https://cwe.mitre.org/data/definitions/918.html
[4]: https://snyk.io/blog/url-confusion-vulnerabilities/
