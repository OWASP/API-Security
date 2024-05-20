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
  item de alta procura de uma só vez e revendê-lo por um preço mais alto (scalping).
* Fluxo de criação de comentário/publicação - um atacante pode inundar o sistema com spam.
* Realização de uma reserva - um atacante pode reservar todos os horários disponíveis
  e impedir que outros utilizadores utilizem o sistema.

O risco de acesso excessivo pode variar entre indústrias e empresas. Por exemplo, a 
criação de publicações através de um script pode ser considerada um risco de spam por 
uma rede social, mas incentivada por outra rede social.

Um endpoint de API está vulnerável se expõe um fluxo de negócio sensível sem restringir 
adequadamente o acesso a ele.

## Exemplos de Cenários de Ataque

### Cenário #1

A technology company announces they are going to release a new gaming console on
Thanksgiving. The product has a very high demand and the stock is limited. An
attacker writes code to automatically buy the new product and complete the
transaction.

On the release day, the attacker runs the code distributed across different IP
addresses and locations. The API doesn't implement the appropriate protection
and allows the attacker to buy the majority of the stock before other legitimate
users.

Later on, the attacker sells the product on another platform for a much higher
price.

### Cenário #2

An airline company offers online ticket purchasing with no cancellation fee. A
user with malicious intentions books 90% of the seats of a desired flight.

A few days before the flight the malicious user canceled all the tickets at
once, which forced the airline to discount the ticket prices in order to fill
the flight.

At this point, the user buys herself a single ticket that is much cheaper than
the original one.

### Cenário #3

A ride-sharing app provides a referral program - users can invite their friends
and gain credit for each friend who has joined the app. This credit can be later
used as cash to book rides.

An attacker exploits this flow by writing a script to automate the registration
process, with each new user adding credit to the attacker's wallet.

The attacker can later enjoy free rides or sell the accounts with excessive
credits for cash.

## Como Prevenir

The mitigation planning should be done in two layers:

* Business - identify the business flows that might harm the business if they
  are excessively used.
* Engineering - choose the right protection mechanisms to mitigate the business
  risk.

  Some of the protection mechanisms are more simple while others are more
  difficult to implement. The following methods are used to slow down automated
  threats:

  * Device fingerprinting: denying service to unexpected client devices (e.g
    headless browsers) tends to make threat actors use more sophisticated
    solutions, thus more costly for them
  * Human detection: using either captcha or more advanced biometric solutions
    (e.g. typing patterns)
  * Non-human patterns: analyze the user flow to detect non-human patterns (e.g.
    the user accessed the "add to cart" and "complete purchase" functions in
    less than one second)
  * Consider blocking IP addresses of Tor exit nodes and well-known proxies

  Secure and limit access to APIs that are consumed directly by machines (such
  as developer and B2B APIs). They tend to be an easy target for attackers
  because they often don't implement all the required protection mechanisms.

## Referências

### OWASP

* [OWASP Automated Threats to Web Applications][1]
* [API10:2019 Insufficient Logging & Monitoring][2]

[1]: https://owasp.org/www-project-automated-threats-to-web-applications/
[2]: https://owasp.org/API-Security/editions/2019/en/0xaa-insufficient-logging-monitoring/

