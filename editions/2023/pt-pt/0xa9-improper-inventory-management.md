# API9:2023 Improper Inventory Management

| Agentes Ameaça/Vetores Ataque | Falha Segurança | Impactos |
| - | - | - |
| Específico da API : Abuso **Fácil** | Prevalência **Predominante** : Deteção **Moderado** | Técnico **Moderado** : Específico Negócio |
| Os agentes ameaça geralmente obtêm acesso não autorizado através de versões antigas de APIs ou _endpoints_ que permanecem em execução sem atualizações e que utilizam requisitos de segurança mais fracos. Em alguns casos, os _exploits_ estão disponíveis online. Alternativamente, podem obter acesso a dados sensíveis através de um terceiro com quem não há razão para compartilhar dados. | Documentação desatualizada torna mais difícil encontrar e/ou corrigir vulnerabilidades. A falta de inventário de recursos e estratégias de desativação leva à execução de sistemas sem atualizações, resultando em vazamentos de dados sensíveis. É comum encontrar hosts de API desnecessariamente expostos devido a conceitos modernos como microserviços, que tornam as aplicações fáceis de implantar e independentes (por exemplo, computação em nuvem, K8S). Um simples Google Dorking, enumeração de DNS ou o uso de motores de busca especializados para vários tipos de servidores (webcams, routers, servidores, etc.) conectados à internet será suficiente para descobrir alvos. | Os atacantes podem obter acesso a dados sensíveis ou até mesmo tomar o controlo do servidor. Às vezes, diferentes versões/implementações da API estão conectadas à mesma base de dados com dados reais. Agentes ameaça podem explorar _endpoints_ obsoletos disponíveis em versões antigas da API para obter acesso a funções administrativas ou explorar vulnerabilidades conhecidas. |

## A API é vulnerável?

A natureza dispersa e conectada das APIs e das aplicações modernas traz novos 
desafios. É importante que as organizações não só tenham uma boa compreensão e 
visibilidade das suas próprias APIs e _endpoints_, mas também de como as APIs 
estão a armazenar ou a partilhar dados com terceiros.

Executar múltiplas versões de uma API requer recursos de gestão adicionais do 
fornecedor da API e expande a superfície de ataque.

Uma API tem um "<ins>ponto cego de documentação</ins>" se:

* O propósito de um _host_ da API é pouco claro e não há respostas explícitas
  para as seguintes perguntas:
    * Em que ambiente está a API a ser executada (por exemplo, produção,
      _staging_, teste, desenvolvimento)?
    * Quem deve ter acesso à rede da API (por exemplo, público, interno,
      parceiros)?
    * Qual versão da API está em execução?
* Não existe documentação ou a documentação existente não está atualizada.
* Não existe um plano de desativação para cada versão da API.
* O inventário do _host_ está em falta ou desatualizado.

A visibilidade e o inventário dos fluxos de dados sensíveis desempenham um papel
importante como parte de um plano de resposta a incidentes, caso ocorra uma
violação do lado de terceiros.

Uma API tem um "<ins>ponto cego de fluxo de dados</ins>" se:

* Existe um "fluxo de dados sensíveis" onde a API compartilha dados sensíveis
  com um terceiro e
    * Não existe uma justificação de negócio ou aprovação do fluxo
    * Não existe inventário ou visibilidade do fluxo
    * Não há visibilidade detalhada sobre o tipo de dados sensíveis partilhados


## Exemplos de Cenários de Ataque

### Cenário #1

Uma rede social implementou um mecanismo de limitação de frequência de pedidos 
que previne que atacantes possam usar força bruta para adivinhar _tokens_ de 
redefinição de _password_. Este mecanismo não foi implementado como parte do 
código da própria API, mas num componente separado entre o cliente e a API 
oficial (`api.socialnetwork.owasp.org`). Um investigador encontrou um _host_ da 
API beta (`beta.api.socialnetwork.owasp.org`) que executa a mesma API, incluindo
o mecanismo de redefinição de _password_, mas sem o mecanismo de limitação de 
frequência de pedidos. O investigador conseguiu redefinir a _password_ de 
qualquer utilizador usando força bruta simples para adivinhar o _token_ de 6 
dígitos.

### Cenário #2

Uma rede social permite que desenvolvedores de aplicações independentes se 
integrem com ela. Como parte desse processo, é solicitado o consentimento do 
utilizador final para que a rede social possa partilhar as informações pessoais 
do utilizador com a aplicação independente.

O fluxo de dados entre a rede social e as aplicações independentes não é 
suficientemente restritivo ou monitorizado, permitindo que as aplicações acedam 
não apenas às informações do utilizador, mas também às informações privadas de 
todos os seus amigos.

Uma empresa de consultoria cria uma aplicação maliciosa e consegue obter o 
consentimento de 270 mil utilizadores. Devido a essa falha, a empresa de 
consultoria consegue aceder às informações privadas de 50 milhões de 
utilizadores. Mais tarde, a empresa de consultoria vende as informações para 
fins maliciosos.

## Como Prevenir

* Inventarie todos os <ins>_hosts_ da API</ins> e documentar os aspectos
  importantes de cada um deles, focando no ambiente da API (por exemplo,
  produção, _staging_, teste, desenvolvimento), quem deve ter acesso à rede do
  _host_ (por exemplo, público, interno, parceiros) e a versão da API.
* Inventarie os <ins>serviços integrados</ins> e documentar aspectos
  importantes, como o seu papel no sistema, quais dados são trocados (fluxo de
  dados) e a sua sensibilidade.
* Documente todos os aspectos da sua API, como autenticação, erros,
  redirecionamentos, limitação de frequência de pedidos, política de partilha de
  recursos entre origens (CORS) e _endpoints_, incluindo os seus parâmetros,
  pedidos e respostas.
* Crie documentação automaticamente adotando padrões abertos. Inclua a
  construção da documentação no seu _pipeline_ de CI/CD.
* Disponibilize a documentação da API apenas para aqueles autorizados a utilizar
  a API.
* Utilize medidas de proteção externas, como soluções específicas de segurança
  de API, para todas as versões expostas das suas APIs, não apenas para a versão
  de produção atual.
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
* Evite utilizar dados de produção em implementações de API que não são
  produção. Se isso for inevitável, esses _endpoints_ devem receber o mesmo
  tratamento de segurança que os de produção.
* Quando versões mais recentes das APIs incluem melhorias de segurança, realize
  uma análise de risco para informar as ações de mitigação necessárias para as
  versões mais antigas. Por exemplo, se é possível aplicar as melhorias nessas
  versões mais antigas sem quebrar a compatibilidade da API ou se é necessário
  remover rapidamente a versão mais antiga e forçar todos os clientes a migrar
  para a versão mais recente.

## Referências

### Externas

* [CWE-1059: Incomplete Documentation][1]

[1]: https://cwe.mitre.org/data/definitions/1059.html
