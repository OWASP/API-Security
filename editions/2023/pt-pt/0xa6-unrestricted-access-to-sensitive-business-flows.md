# API6:2023 Unrestricted Access to Sensitive Business Flows

| Agentes Ameaça/Vetores Ataque | Falha Segurança | Impactos |
| - | - | - |
| Específico da API : Abuso **Fácil** | Prevalência **Predominante** : Deteção **Moderado** | Técnico **Moderado** : Específico Negócio |
| A exploração geralmente envolve entender o modelo de negócio suportado pela API, encontrar fluxos de negócio sensíveis e automatizar o acesso a esses fluxos, causando danos ao negócio. | A falta de uma visão holística da API para suportar plenamente os requisitos de negócio tende a contribuir para a prevalência deste problema. Os atacantes identificam manualmente quais recursos (e.g. _endpoints_) estão envolvidos no fluxo de trabalho alvo e como funcionam em conjunto. Se já existirem mecanismos de mitigação, os atacantes precisam encontrar uma maneira de os contornar. | Em geral, não se espera um impacto técnico significativo. A exploração pode prejudicar o negócio de diferentes maneiras, por exemplo: impedir que utilizadores legítimos comprem um produto ou levar a uma inflação na economia interna de um jogo. |

## A API é vulnerável?

Ao criar um _endpoint_ de API, é importante entender qual fluxo de negócio ele 
expõe. Alguns fluxos de negócio são mais sensíveis do que outros, no sentido de 
que o acesso excessivo a eles pode prejudicar o negócio.

Exemplos comuns de fluxos de negócios sensíveis e o risco de acesso excessivo 
associado a eles:

* Fluxo de compra de um produto - um atacante pode comprar todo o stock de um
  item de alta procura de uma só vez e revendê-lo por um preço mais alto 
  (scalping).
* Fluxo de criação de comentário/publicação - um atacante pode inundar o sistema 
  com spam.
* Realização de uma reserva - um atacante pode reservar todos os horários 
* disponíveis e impedir que outros utilizadores utilizem o sistema.

O risco de acesso excessivo pode variar entre indústrias e empresas. Por 
exemplo, a criação de publicações através de um script pode ser considerada um 
risco de spam por uma rede social, mas incentivada por outra rede social.

Um endpoint de API está vulnerável se expõe um fluxo de negócio sensível sem 
restringir adequadamente o acesso a ele.

## Exemplos de Cenários de Ataque

### Cenário #1

Uma empresa de tecnologia anuncia que vai lançar uma nova consola de jogos no 
Dia de Ação de Graças. O produto tem uma procura muito alta e o stock é 
limitado. Um atacante escreve código para comprar automaticamente o novo produto 
e concluir a transação.

No dia do lançamento, o atacante executa o código distribuído por diferentes 
endereços IP e localizações. A API não implementa a proteção adequada e permite 
que o atacante compre a maior parte do stock antes de outros utilizadores 
legítimos.

Mais tarde, o atacante vende o produto noutra plataforma por um preço muito mais 
alto.

### Cenário #2

Uma companhia aérea oferece a compra de bilhetes online sem taxa de 
cancelamento. Um utilizador com intenções maliciosas reserva 90% dos assentos de 
um voo desejado.

Alguns dias antes do voo, o utilizador malicioso cancelou todos os bilhetes de 
uma vez, o que obrigou a companhia aérea a baixar os preços dos bilhetes para 
preencher o voo.

Deste modo, o utilizador consegue comprar um bilhete que está muito mais barato 
do que o original.

### Cenário #3

Uma aplicação de partilha de boleias oferece um programa de referência - os 
utilizadores podem convidar os seus amigos e ganhar crédito por cada amigo que 
se juntar à aplicação. Este crédito pode ser posteriormente utilizado como 
dinheiro para reservar viagens.

Um atacante explora este fluxo escrevendo um script para automatizar o processo 
de registo, com cada novo utilizador a adicionar crédito à carteira do atacante.

O atacante pode posteriormente usufruir de viagens gratuitas ou vender as contas 
com créditos excessivos por dinheiro.

## Como Prevenir

O planeamento da mitigação deve ser feito em duas camadas:

* Negócio - identificar os fluxos de negócio que podem prejudicar a empresa se
  forem utilizados em excesso.
* Engenharia - escolher os mecanismos de proteção adequados para mitigar o risco
  empresarial.

    Alguns dos mecanismos de proteção são mais simples, enquanto outros são mais
    difíceis de implementar. Os seguintes métodos são utilizados para desacelerar
    ameaças automatizadas:

    * _Fingerprinting_ de dispositivos: negar serviço a dispositivos de cliente
      inesperados (e.g. navegadores _headless_) tende a fazer com que os atacantes
      usem soluções mais sofisticadas, tornando-as mais caras para eles.
    * Deteção humana: utilize _captcha_ ou soluções biométricas mais avançadas
      (e.g. padrões de digitação).
    * Padrões não humanos: analisar o fluxo do utilizador para detetar padrões
      não humanos (e.g. o utilizador acedeu às funções "adicionar ao carrinho" e
      "finalizar compra" em menos de um segundo).
    * Considere bloquear endereços IP de nós de saída da rede Tor e proxies bem
      conhecidos.

    Proteja e limite o acesso às APIs que são consumidas diretamente por máquinas
    (como APIs para desenvolvedores e B2B). Elas tendem a ser um alvo fácil para
    atacantes, pois muitas vezes não implementam todos os mecanismos de proteção
    necessários.

## Referências

### OWASP

* [OWASP Automated Threats to Web Applications][1]
* [API10:2019 Insufficient Logging & Monitoring][2]

[1]: https://owasp.org/www-project-automated-threats-to-web-applications/
[2]: https://owasp.org/API-Security/editions/2019/en/0xaa-insufficient-logging-monitoring/

