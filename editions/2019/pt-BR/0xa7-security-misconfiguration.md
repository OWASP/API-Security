# API7:2019 Security Misconfiguration

| Agentes/Vetores | Fraquezas de Segurança | Impactos |
| - | - | - |
| Específico da API : Explorabilidade **3** | Prevalência **3** : Detecção **3** | Técnico **2** : Específico do negócio |
| Atacantes eventualmente procuram falhas não corrigidas, *endpoints* comuns, ou diretórios não protegidos para ganhar acesso não-autorizado ou realizar um reconhecimento do sistema. | Configurações inadequadas de segurança podem ocorrer a qualquer nível do *stack* da API, desde o nível da rede até o nível da aplicação. Ferramentas de automação estão disponíveis para detectar e explorar erros de configuração, como serviços desnecessários e opções de suporte ao legado. | Configurações inadequadas podem não apenas expor dados sensíveis de usuários, como também podem revelar detalhes do sistema e comprometer servidores como um todo. |

## A API está vulnerável?

Sua API pode estar vulnerável se:

* Configurações apropriadas de *hardening* faltam a qualquer parte da aplicação, ou quando há permissões mal configuradas em provedores de nuvem.
* Os últimos *patches* de segurança não estão aplicados ou os sistemas estão desatualizados.
* Recursos não necessários estão habilitados (ex.: certos verbos HTTP).
* Transporte criptografado (TLS) não configurado.
* Diretivas de segurança não enviadas aos clientes (ex.: [Cabeçalhos de Segurança][1]).
* Configurações de política CORS (*Cross-Origin Resource Sharing*) não configuradas ou configuradas inadequadamente.
* Mensagens de erro incluindo *stack trace* ou informações sensíveis.

## Cenários de exemplo de ataques

### Cenário #1

Um atacante encontra o arquivo `.bash_history` no diretório root do servidor, o qual contém comandos utilizados pelo time de DevOps para acesso à API:

```
$ curl -X GET 'https://api.server/endpoint/' -H 'authorization: Basic Zm9vOmJhcg=='
```
Um atacante pode também encontrar novos *endpoints* da API que são utilizados apenas pelo time de DevOps os quais não constam na documentação.

### Cenário #2

Para mirar um serviço em específico, um atacante utiliza uma popular ferramenta de pesquisa na web para encontrar servidores que estão diretamente acessíveis na internet. Este atacante encontra um *host* executando um popular serviço de gerenciamento de banco de dados, o qual está ouvindo na porta padrão. Este mesmo *host* utiliza configurações padrão do sistema de gerenciamento de banco de dados, o qual a autenticação de acesso é desabilitada por padrão, então o atacante consegue acesso à milhares de registros com dados pessoais sensíveis e dados de autenticação.

### Cenário #3

Inspecionando o tráfego de um aplicativo móvel, um atacante encontra que nem todo o tráfego HTTP está sendo executado em protocolo seguro (ex.: TLS). O atacante confirma esta condição ao realizar o *download* de imagens de perfis. Como a interação do usuário nesse caso é binária, apesar do fato de o tráfego da API ser realizado com protocolo seguro, o atacante encontra um padrão no tamanho das respostas da API e utiliza isso para monitorar preferências de usuário sobre o conteúdo renderizado (Ex. Imagens de perfil).

## Como prevenir

O ciclo de vida da API deve incluir:

* Um processo de *hardening* contínuo levando a um rápido e fácil modelo de entrega a um ambiente apropriadamente protegido.
* Uma tarefa de revisão e atualização de configurações em todo o *stack* da API, essa revisão deve incluir: Arquivos de orquestração, componentes de API, serviços de nuvem (ex.: permissões de *buckets*).
* Um canal de comunicação segura para todos os pontos de interação da API, inclusive objetos estáticos (Ex.: Imagens).
* Processo automatizado para continuamente avaliar a efetividade das configurações e preferências em todos os ambientes.

Além disso:

* Para prevenir que detalhes de erros e outras informações sejam enviados de volta aos atacantes, se aplicável, defina e aplique *schemas* aos *responses* da API.
* Certifique-se que a API só pode ser acessada por verbos HTTP específicos. Todos os demais verbos devem estar desabilitados (ex: `HEAD`).
* APIs que devem ser acessadas por navegadores (ex.: *front-end* de aplicação web) devem implementar uma política CORS apropriada.

## Referências

### OWASP

* [OWASP Secure Headers Project][1]
* [OWASP Testing Guide: Configuration Management][2]
* [OWASP Testing Guide: Testing for Error Codes][3]
* [OWASP Testing Guide: Test Cross Origin Resource Sharing][9]

### Externas

* [CWE-2: Environmental Security Flaws][4]
* [CWE-16: Configuration][5]
* [CWE-388: Error Handling][6]
* [Guide to General Server Security][7], NIST
* [Let’s Encrypt: a free, automated, and open Certificate Authority][8]

[1]: https://owasp.org/www-project-secure-headers/
[2]: https://www.owasp.org/index.php/Testing_for_configuration_management
[3]: https://www.owasp.org/index.php/Testing_for_Error_Code_(OTG-ERR-001)
[4]: https://cwe.mitre.org/data/definitions/2.html
[5]: https://cwe.mitre.org/data/definitions/16.html
[6]: https://cwe.mitre.org/data/definitions/388.html
[7]: https://csrc.nist.gov/publications/detail/sp/800-123/final
[8]: https://letsencrypt.org/
[9]: https://www.owasp.org/index.php/Test_Cross_Origin_Resource_Sharing_(OTG-CLIENT-007)
