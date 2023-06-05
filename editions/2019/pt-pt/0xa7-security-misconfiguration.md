# API7:2019 Security Misconfiguration

| Agentes Ameaça/Vetores Ataque | Falha Segurança | Impactos |
| - | - | - |
| Específico da API : Abuso **3** | Prevalência **3** : Deteção **3** | Técnico **2** : Específico Negócio |
| Os atacantes vão regra geral tentar encontrar falhas, _endpoints_ comuns ou ficheiros e diretórios desprotegidos para ganhar acesso não autorizado ou conhecimento do sistema. | Falhas nas configurações de segurança podem acontecer em qualquer camada da API, desde o nível de rede ao aplicacional. Existem ferramentas automáticas para detetar e abusar destas falhas, tais como serviços desnecessários que se encontram em execução ou configurações antigas. | Estas falhas podem não só expor dados sensíveis dos utilizadores, mas também detalhes do sistema que permitam comprometer o servidor. |

## A API é vulnerável?

A API é vulnerável se:

* As configurações para proteger o sistema estão em falta em qualquer das partes
  constituintes da API, ou se existem serviços na nuvem indevidamente
  configurados.
* As últimas atualizações de segurança não foram aplicadas ou os sistemas estão
  desatualizados.
* Existem funcionalidades ativas que não estão em uso (e.g., verbos HTTP).
* A segurança do canal de comunicação não está assegurada: _Transport Layer
  Security_ (TLS) em falta ou indevidamente configurado.
* Diretivas de segurança não são enviadas aos clientes (e.g.,
  [cabeçalhos HTTP de segurança][1]).
* Não existe um política de Partilha de Recursos entre Origens (CORS) ou esta
  está indevidamente configurada.
* As mensagens de erro incluem _stack traces_ ou outra informação sensível.

## Exemplos de Cenários de Ataque

### Cenário #1

Um atacante encontra o ficheiro `.bash_history` na diretoria raiz do servidor, o
qual contém os comandos usados pela equipa de DevOps para aceder à API:

```
$ curl -X GET 'https://api.server/endpoint/' -H 'authorization: Basic Zm9vOmJhcg=='
```

O atacante pôde assim identificar novos _endpoints_ da API, destinados
exclusivamente ao uso pela equipa de DevOps e que não estavam documentados.

### Cenário #2

Tendo em vista um serviço específico, um atacante usa um conhecido motor de
busca de dispositivos diretamente acessíveis através da internet. O atacante
encontrou um _host_ a correr um conhecido sistema de gestão de base de dados, à
escuta na porta padrão. Como o _host_ estava a utilizar a configuração padrão, a
qual tem o mecanismo de autenticação desativado por omissão, o atacante teve
acesso a milhões de registo com informação pessoal (PII), preferências e dados
de autenticação dos utilizadores.

### Cenário #3

Inspecionando o tráfego de rede duma aplicação móvel, um atacante percebe que
nem todo o tráfego usa um protocolo seguro (e.g., TLS), em particular aquele
associado às imagens de perfil de utilizador. Como as interações do utilizador
na aplicação são binárias, apesar do tráfego da API ser enviado de forma segura,
o atacante identifica um padrão no tamanho das respostas da API, o qual usa para
mapear as preferências do utilizador em relação ao conteúdo visualizado (e.g.,
imagens de perfil).

## Como Prevenir

O ciclo de vida da API deve incluir:

* Um processo de proteção reprodutível que possa ser implantado de forma fácil
  e rápida com vista a um ambiente de execução devidamente protegido.
* Um processo de revisão e atualização de todas as camadas da API. A revisão
  deve incluir: ficheiros de orquestração, componentes da API e serviços na
  nuvem (e.g., permissões dos _buckets_ S3).
* Um canal de comunicação seguro para todas as interações da API no acesso a
  recursos estáticos (e.g., imagens).
* Um processo automatizado para verificar de forma continua as configurações e
  definições em todos os ambientes (produção, _staging_, testes,
  desenvolvimento).

E ainda:

* Para prevenir que _stack traces_ sejam incluídas nas mensagens de erro ou
  outra informação sensível seja fornecida aos atacantes, quando aplicável,
  defina _schemas_ e verifique que todas as respostas da API estão em
  conformidade.
* Assegure que a API só é acessível através do verbos HTTP especificados. Todos
  os demais verbos HTTP que não são utilizados deverão estar desativados (e.g.,
  `HEAD`).
* As APIs destinadas a acessos por clientes a correr em navegadores (e.g.,
  WebApps) devem implementar uma política de Partilha de Recursos Entre Origens
  (CORS) adequada.

## Referências

### OWASP

* [OWASP Secure Headers Project][1]
* [OWASP Testing Guide: Configuration and Deployment Management][2]
* [OWASP Testing Guide: Testing for Error Handling][3]
* [OWASP Testing Guide: Test Cross Origin Resource Sharing][9]

### Externas

* [CWE-2: Environmental Security Flaws][4]
* [CWE-16: Configuration][5]
* [CWE-388: Error Handling][6]
* [Guide to General Server Security][7], NIST
* [Let’s Encrypt: a free, automated, and open Certificate Authority][8]

[1]: https://owasp.org/www-project-secure-headers/
[2]: https://github.com/OWASP/wstg/tree/master/document/4-Web_Application_Security_Testing/02-Configuration_and_Deployment_Management_Testing
[3]: https://github.com/OWASP/wstg/tree/master/document/4-Web_Application_Security_Testing/08-Testing_for_Error_Handling
[4]: https://cwe.mitre.org/data/definitions/2.html
[5]: https://cwe.mitre.org/data/definitions/16.html
[6]: https://cwe.mitre.org/data/definitions/388.html
[7]: https://csrc.nist.gov/publications/detail/sp/800-123/final
[8]: https://letsencrypt.org/
[9]: https://github.com/OWASP/wstg/blob/master/document/4-Web_Application_Security_Testing/11-Client_Side_Testing/07-Testing_Cross_Origin_Resource_Sharing.md
