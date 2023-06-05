# API2:2019 Broken User Authentication

| Agentes/Vetores | Fraquezas de Segurança | Impactos |
| - | - | - |
| Específico da API : Explorabilidade **3** | Prevalência **2** : Detecção **2** | Técnico **3** : Específico do negócio |
| Autenticação em APIs é um mecanismo complexo e confuso. Engenheiros e arquitetos de software e segurança podem ter conceitos equivocados a respeito de quais são os limites da autenticação e na forma como devem ser implementados corretamente. Adicionalmente, mecanismos de autenticação são alvo de atacantes pois estão expostos a todos. Estes dois pontos fazem da autenticação um componente vulnerável a muitos tipos de *exploits*. | Existem dois tipos de sub-problemas: 1. Falta de mecanismo de proteção: Os *endpoints* da API que geralmente são responsáveis pela autenticação devem ser tratados diferentemente dos *endpoints* regulares e implementam camadas extras de proteção. 2. Má implementação do mecanismo: O mecanismo é usado ou implementado sem considerar vetores de ataque ou com casos de uso inadequados (ex.: um mecanismo de autenticação desenvolvido para dispositivos IoT pode não ser a melhor opção para aplicativos web). | Atacantes podem tomar controle de outras contas de usuários no sistema, acessar seus dados pessoais e executar ações sensíveis em seu nome, como transações financeiras e enviar mensagens pessoais. |

## A API está vulnerável?

Os *endpoints* e fluxos de autorização são ativos que devem ser protegidos. "Esqueci minha senha/Redefinição de senha" devem ser tratados da mesma forma que outros mecanismos de autenticação.

Uma API está vulnerável se:
* Permite a prática de *[credential stuffing][1]* o qual o atacante tem uma lista de nomes de usuário e senhas.
* Permite que atacantes executem força bruta contra uma mesma conta de usuário sem exibir CAPTCHA ou mecanismo de bloqueio da conta.
* Permite o uso de senhas fracas.
* Envia detalhes sensíveis da autenticação como *tokens* e senhas na URL.
* Não executa a validação de autenticidade de *tokens*.
* Aceita *tokens* JWT não assinados/fracos (`"alg":"none"`)/não valida data de expiração.
* Utiliza senhas em texto plano, não criptografadas ou com hash fraco de criptografia.
* Usa chaves de criptografias fracas.

## Cenários de exemplo de ataques

### Cenário #1

*[Credential stuffing][1]* (utilizando [listas de usuário e senha conhecidas][2]), é um ataque comum. Se uma aplicação não implementar em sua arquitetura proteções automatizadas ou proteções contra *credential stuffing*, a aplicação pode ser utilizada como base de teste para determinar se credenciais são válidas.

### Cenário #2

Um atacante inicia um processo de recuperação de senha enviando uma requisição POST para o *endpoint* `/api/system/verification-codes` e enviando um usuário no corpo da requisição. Um *token* SMS com 6 dígitos é enviado para o telefone móvel da vítima. Uma vez que a API não implementa um mecanismo de limite, o atacante pode testar todas as combinações possíveis utilizando um script *multi-thread* contra o endpoint `/api/system/verification-codes/{smsToken}` e assim descobrir o token correto em alguns minutos.

## Como prevenir

* Certifique-se que conhece todos os fluxos possíveis para autenticar-se na API.
* Pergunte aos engenheiros/arquitetos quais fluxos você esqueceu.
* Leia sobre seus mecanismos de autenticação. Tenha certeza que você compreende quando e como foram utilizados. OAuth não é mecanismo de autenticação, e não é chave de API.
* Não reinvente a roda em autenticação, geração de *token*, armazenamento de senhas. Utilize o que é padrão.
* *Endpoints* para recuperação de senhas devem ser tratados assim como aqueles voltados para os processos de login para questões como ataques de força bruta, limitação de confiança e bloqueio de contas.
* Use as informações do projeto [OWASP Authentication Cheatsheet][3].
* Sempre que possível, implemente autenticação multi-fator.
* Implemente mecanismos anti força bruta para mitigar *credential stuffing*, ataque por dicionário em seus *endpoints* de autenticação. A taxa de confiança da proteção desse mecanismo deve ser mais restrito que os demais mecanismos na sua API.
* Implemente [bloqueio de conta][4] / mecanismos de CAPTCHA a fim de prevenir o uso de força bruta contra usuários específicos. Implemente verificação de senhas fracas.
* Chaves de API não devem ser utilizadas para autenticação de usuários, mas para [aplicativos clientes e autenticação de projetos][5].

## Referências

### OWASP

* [OWASP Key Management Cheat Sheet][6]
* [OWASP Authentication Cheatsheet][3]
* [Credential Stuffing][1]

### Externas

* [CWE-798: Use of Hard-coded Credentials][7]

[1]: https://owasp.org/www-community/attacks/Credential_stuffing
[2]: https://github.com/danielmiessler/SecLists
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
[4]: https://www.owasp.org/index.php/Testing_for_Weak_lock_out_mechanism_(OTG-AUTHN-003)
[5]: https://cloud.google.com/endpoints/docs/openapi/when-why-api-key
[6]: https://cheatsheetseries.owasp.org/cheatsheets/Key_Management_Cheat_Sheet.html
[7]: https://cwe.mitre.org/data/definitions/798.html
