# API1:2019 Broken Object Level Authorization

| Agentes/Vetores | Fraquezas de Segurança | Impactos |
| - | - | - |
| Específico da API : Explorabilidade **3** | Prevalência **3** : Detecção **2** | Técnico **3** : Específico do negócio|
| Atacantes podem explorar *endpoints* de API que estejam vulneráveis a quebrar níveis de autorização com a manipulação de ID de objeto enviado na requisição. Isto pode levar a acesso à informações não autorizadas a dados sensíveis. Este problema é extremamente comum em aplicações baseadas em APIs uma vez que os componentes de servidores usualmente não verificam o estado do cliente, ao invés disso, confia em parâmetros como IDs de objeto que são enviados pelo cliente que decide qual objeto acessar. | Este é o mais comum e impactante ataque contra APIs. Autorização e mecanismos de controle de acesso em aplicações modernas são complexos e amplos. Mesmo se a aplicação implementa uma apropriada infraestrutura de verificação de autorização, desenvolvedores podem esquecer de usar tais verificações antes de acessar objetos com informações sensíveis. Controle de acesso não é tipicamente favorável a testes automatizados, estáticos ou dinâmicos. | Acesso não autorizado pode resultar no vazamento de dados à partes não autorizadas, perda ou manipulação de dados. Acesso não autorizado à objetos também podem levar a tomada de contas. |

## A API está vulnerável?

O nível de autorização de objeto é um mecanismo de controle de acesso que usualmente é implementado ao nível de código para validar que um usuário pode apenas acessar objetos aos quais realmente tem permissão.

Todo *endpoint* de API que recebe um ID de objeto, e executa qualquer tipo de ação sobre este objeto, deve implementar verificações de autorização de acesso ao nível deste objeto. A verificação deve validar que o usuário tem acesso para executar aquela ação no objeto requisitado.

Falhas nesse mecanismo geralmente levam ao acesso não autorizado de informações, vazamento de dados, modificação ou destruição de dados.

## Cenários de exemplo de ataques

### Cenário #1

Uma plataforma de *e-commerce* para lojas de compras online entrega uma listagem com os gráficos de receita de suas lojas hospedadas. Inspecionando as requisições do navegador, o atacante pode identificar que os *endpoints* utilizados como fonte de dados para os gráficos utiliza um padrão como `/shops/{shopName}/revenue_data.json`. Utilizando outro *endpoint* da API, o atacante consegue uma lista de todos os nomes das lojas hospedadas na plataforma. Com um simples *script* o atacante pode agora, manipulando o nome substituindo o parâmetro `{shopName}` na URL, ganhar acesso aos dados das vendas de milhares de lojas que utilizam a plataforma de *e-commerce*.

### Cenário #2

Enquanto monitora o tráfego de rede um *wearable device*, o atacante tem sua atenção despertada ao perceber o verbo HTTP `PATCH` possui o cabeçalho customizado `X-User-Id: 54796`. Substituindo o valor do cabeçalho o atacante recebe uma resposta HTTP válida, sendo possível portanto modificar os dados de outros usuários.

## Como prevenir

* Implementar mecanismo apropriado de autorização de acesso baseado em políticas e hierarquias.
* Utilizar uma autorização para verificar se o usuário pode acessar e executar ações nos registros em todas as funções que utiliza *input* do usuário para acessar dados.
* Prefira utilizar valores randômicos como GUIs para ids de registros.
* Escreva testes para avaliar seu mecanismo de autorização, não autorize *deployment* de mudanças de código que quebrem estes testes.

## Referências

### Externas

* [CWE-284: Improper Access Control][1]
* [CWE-285: Improper Authorization][2]
* [CWE-639: Authorization Bypass Through User-Controlled Key][3]

[1]: https://cwe.mitre.org/data/definitions/284.html
[2]: https://cwe.mitre.org/data/definitions/285.html
[3]: https://cwe.mitre.org/data/definitions/639.html
