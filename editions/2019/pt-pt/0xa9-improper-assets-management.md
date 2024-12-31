# API9:2019 Improper Assets Management

| Agentes Ameaça/Vetores Ataque | Falha Segurança | Impactos |
| - | - | - |
| Específico da API : Abuso **3** | Prevalência **3** : Deteção **2** | Técnico **2** : Específico Negócio |
| Versões antigas da API tipicamente não são alvo de atualizações e podem ser usadas para comprometer sistemas sem ter que lidar com mecanismos de segurança mais avançados, os quais poderão estar ativos nas versões mais recentes. | A documentação desatualizada dificulta a identificação e/ou correção de falhas de segurança. A inexistência dum inventário e duma estratégica de descontinuação estão na génese dos sistemas sem atualizações de segurança que acabam por divulgar informação sensível. É comum encontrar-se APIs expostas desnecessariamente: o conceito de micro-serviços tornou o _deploy_ das aplicações mais fácil e independente (e.g., _cloud_, kubernetes), podendo estar na origem deste fenómeno. | Os atacantes podem conseguir acesso a informação sensível ou até obter o controlo do servidor através de versões antigas e sem atualizações de segurança que estejam ligadas à mesma base de dados. |

## A API é vulnerável?

A API pode ser vulnerável se:

* O propósito dum host da API não é claro, não havendo respostas explicitas para
  as seguintes perguntas:
    * Em que ambientes está a API a correr (e.g., produção, _staging_, testes,
      desenvolvimento)?
    * Quem deve ter acesso à API através da rede (e.g., público, interno,
      parceiros)?
    * Que versões da API estão a correr?
    * Que informação é recolhida e processada pela API (e.g., PII)?
    * Qual é o fluxo dos dados?
* Não existe documentação, ou a que existe não está atualizada.
* Não existe um plano para descontinuar cada uma das versões da API.
* Não existe um inventário de hosts ou o que existe está desatualizado.
* O inventário de integração de serviços, próprios ou de terceiros, não existe
  ou está desatualizado.
* Versões antigas ou anteriores estão a correr sem atualizações de segurança.

## Exemplos de Cenários de Ataque

### Cenário #1

Depois de redesenhar as suas aplicações, um serviço de pesquisa local deixou
uma versão antiga da API a correr (`api.someservice.com/v1`), desprotegida e com
acesso à base de dados de utilizadores. Enquanto estava a analisar uma das
últimas versões das aplicações, um atacante encontrou o endereço da API
(`api.someservice.com/v2`). Substituindo `v2` por `v1` no URL, o atacante
conseguiu acesso à versão antiga da API a qual expunha informação pessoal (PII)
de mais de 100 milhões de utilizadores.

### Cenário #2

Uma rede social implementou um mecanismo de limitação do número de pedidos para
impedir os atacantes de usar ataques de força bruta para adivinhar os _tokens_
de redefinição de password. Este mecanismo não foi implementado ao nível do
código da API, mas sim como um componente entre o cliente e a API em uso. Um
investigador encontrou um _host_ relativo à versão beta da API mas que corria
agora a última versão desta, incluindo o mecanismo de redefinição da password,
mas aqui sem o mecanismo de limitação do número de pedidos. O investigador seria
capaz de redefinir a password de qualquer utilizador, recorrendo a força bruta
para adivinhar o _token_ de 6 dígitos.

## Como Prevenir

* Inventarie todos os _hosts_ da API e documente os aspetos importantes de cada
  um deles, com especial enfoque no ambiente da API (e.g., produção, _staging_,
  testes, desenvolvimento), quem deve ter acesso pela rede ao _host_ (e.g.,
  público, interno, parceiros) e a versão da API.
* Inventarie as integrações de serviços e documente os aspetos mais importantes
  tais como o papel destes no sistema, que dados são trocados (fluxo de dados) e
  a sua suscetibilidade.
* Documente todos os aspetos da API, tais como autenticação, erros,
  redirecionamentos, política de limitação do número de pedidos, polícia de
  Partilha de Recursos Entre Origens (CORS) e _endpoints_, incluindo os seus
  parâmetros, pedidos e respostas.
* Gere a documentação de forma automática através da adoção de standards. Inclua
  a geração da documentação no seu processo de CI/CD.
* Torne a documentação da API disponível para aqueles autorizados a consultá-la.
* Utilize mecanismos de proteção externa, tais como _API Security Firewalls_, em
  todas as versões da API expostas e não exclusivamente a versão mais recente em
  produção.
* Evite a utilização de dados de produção em outros ambientes da API que não de
  produção. Se não puder evitá-lo, esses ambientes/versões/_endpoints_ deverão
  ter o mesmo nível de segurança do que os de produção.
* Quando as novas versões da API incluem melhorias de segurança, realize a
  análise de risco para uma melhor tomada de decisão quanto às ações necessárias
  para a migração das versões antigas: por exemplo, se é possível aplicar as
  mesmas melhorias às versões anteriores sem quebrar compatibilidade ou se as
  deve retirar o quanto antes, forçando os clientes a migrar para a última
  versão.

## Referências

### Externas

* [CWE-1059: Incomplete Documentation][1]
* [OpenAPI Initiative][2]

[1]: https://cwe.mitre.org/data/definitions/1059.html
[2]: https://www.openapis.org/
