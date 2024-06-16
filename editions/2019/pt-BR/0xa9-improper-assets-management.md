# API9:2019 Improper Assets Management

| Agentes/Vetores | Fraquezas de Segurança | Impactos |
| - | - | - |
| Específico da API : Explorabilidade **3** | Prevalência **3** : Detecção **2** | Técnico **2** : Específico do negócio |
| Versões desatualizadas de APIs geralmente carecem de *patches* e são um meio fácil de comprometer sistemas sem a presença de mecanismos de segurança no estado-da-arte, e que podem existir também para proteger versões atualizadas de APIs. | Documentação desatualizada torna mais difícil encontrar e/ou corrigir vulnerabilidades. Falta de um inventário de ativos e estratégias de retirada levam ao cenário de sistemas sem atualização permanecerem em execução, podendo resultar no vazamento de dados sensíveis. É bastante comum encontrar APIs expostas sem necessidade em razão de conceitos modernos como os de microsserviços, que permite que aplicativos sejam lançados independentemente (ex.: computação em nuvem, kubernetes). | Atacantes têm acesso a dados sensíveis e até tomar o controle de servidores por meio de uma velha e desatualizada API conectada ao mesmo banco de dados. |

## A API está vulnerável?

A API pode estar vulnerável se:

* O propósito do *host* da API não for claro, e se não há respostas explícitas para as seguintes questões:
    * Em qual ambiente está rodando à API? (Ex.: produção, *staging*, teste, desenvolvimento)?
    * Quem deve ter acesso via rede à API (Ex.: pública, interna, parceiros)?
    * Em qual versão está a API em execução?
    * Que tipo de informação acessa a API (Ex.: Dados pessoais sensíveis)?
    * Qual é o fluxo da informação?
* Não existe documentação, ou a documentação existente está desatualizada.
* Não há um plano de retirada para cada versão da API.
* Inventário de *hosts* não existe ou está desatualizado.
* Inventário de serviços de integração, seja interna ou de parceiros, não existe ou está desatualizado.
* Versões antigas da API continuam rodando sem *patches*.

## Cenários de exemplo de ataques

### Cenário #1

Após um redesenho de suas aplicações, um serviço de pesquisa local deixou uma versão antiga da API (`api.someservice.com/v1`) em execução, não protegida, e com acesso ao banco de dados. Enquanto buscava como alvo a última versão do aplicativo, um atacante percebeu o endereço da API (`api.someservice.com/v2`). Substituindo `v2` por  `v1` na URL, o atacante acessou a versão antiga e não protegida, a qual expõe dados pessoais sensíveis de mais de 100 milhões de usuários.

### Cenário #2

Uma rede social implementou um nível de classificação mínimo que bloqueia atacantes do uso de força bruta para conseguir acesso por meio de adivinhação de *tokens* de redefinição de senhas de acesso. Este mecanismo não foi implementado no código próprio da API, mas em um componente separado entre o cliente e a API oficial (`www.socialnetwork.com`). Um pesquisador encontrou a versão beta da API (`www.mbasic.beta.socialnetwork.com`) que executa a mesma API, incluindo o mecanismo de redefinição de senha, onde o nível de classificação mínimo não está ativado. Dessa maneira ele pode redefinir a senha de qualquer usuário com um mecanismo simples de força bruta para adivinhar o *token* de seis dígitos.

## Como prevenir

* Faça o inventário de todos os *hosts* de API e documente aspectos importantes de cada um deles, com foco no ambiente das APIs (Ex.: produção, *staging*, testes, desenvolvimento), e qual desses ambientes deve ter acesso à quais redes (Ex.: pública, interno, parceiros) e as versões da API.
* Faça o inventário de todos os serviços de integração e documente os aspectos importantes como o papel de cada um deles no sistema, qual tipo de dado é trocado e se estes dados são sensíveis.
* Documente todos os aspectos da sua API, como autenticação, erros, redirecionamentos, limite de classificação, política de *cross-origin resource sharing* (CORS) e seus *endpoints*, incluindo os parâmetros, requisições e respostas.
* Faça documentações automatizadas utilizando padrões abertos, inclua a documentação de compilação no *pipeline* de CI/CD.
* Faça a documentação disponível para aqueles autorizados à utilizá-la.
* Utilize métricas de proteção como *firewalls* de APIs para todas as versões expostas e não apenas para a versão em produção.
* Evite utilizar dados de produção em *deployments* de API em ambientes de não produção. Caso seja impossível, estes *endpoints* devem possuir o mesmo tratamento de segurança daqueles que estão em produção.
* Quando novas versões da API incluir melhorias de segurança, faça uma análise de risco para auxiliar a decisão de mitigação de ações necessárias para a versão antiga da API. Por exemplo: sempre que for possível utilizar versões antigas sem quebrar compartibilidade, você precisa trabalhar para que todos os clientes façam o movimento para a última versão.

## Referências

### Externas

* [CWE-1059: Incomplete Documentation][1]
* [OpenAPI Initiative][2]

[1]: https://cwe.mitre.org/data/definitions/1059.html
[2]: https://www.openapis.org/
