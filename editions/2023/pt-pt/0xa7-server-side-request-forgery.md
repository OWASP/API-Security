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

Um atacante pode enviar um URL malicioso e iniciar um _scan_ de portas 
dentro da rede interna usando o _endpoint_ da API.

```
{
  "picture_url": "localhost:8080"
}
```

Com base no tempo de resposta, o atacante pode descobrir se a porta está 
aberta ou não.

### Cenário #2

Um produto de segurança gera eventos quando detecta anomalias na rede. 
Algumas equipas preferem rever os eventos num sistema de monitorização mais 
amplo e genérico, como um SIEM (Gestão de Informações e Eventos de Segurança). 
Para este fim, o produto fornece integração com outros sistemas usando 
_webhooks_.

Como parte da criação de um novo _webhook_, uma mutação GraphQL é enviada com o
URL da API do SIEM.

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

Durante o processo de criação, o _back-end_ da API envia um pedido de teste para o
URL do webhook fornecido e apresenta a resposta ao utilizador. 

Um atacante pode explorar este fluxo e fazer com que a API solicite um recurso 
sensível, como um serviço de metadados de nuvem interna que expõe credenciais:

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

Uma vez que a aplicação mostra a resposta do pedido de teste, o atacante pode 
visualizar as credenciais do ambiente de nuvem.

## Como Prevenir

* Isole o mecanismo de obtenção de recursos na sua rede: geralmente, essas
  funcionalidades são destinadas a recuperar recursos remotos e não internos.
* Sempre que possível, utilize listas de permissões de:
    * Origens remotas das quais se espera que os utilizadores façam download de
      recursos (por exemplo, Google Drive, Gravatar, etc.)
    * Esquemas de URL e portas
    * Tipos de media aceites para uma determinada funcionalidade
* Desative redirecionamentos HTTP.
* Utilize um URL _parser_ bem testado e mantido para evitar problemas causados
por inconsistências no processamento de URLs.
* Valide e sanitize todos os dados de entrada fornecidos pelo cliente.
* Não envie respostas não tratadas aos clientes.

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
