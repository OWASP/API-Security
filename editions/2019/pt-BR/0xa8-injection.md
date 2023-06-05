# API8:2019 Injection

| Agentes/Vetores | Fraquezas de Segurança | Impactos |
| - | - | - |
| Específico da API : Explorabilidade **3** | Prevalência **2** : Detecção **3** | Técnico **3** : Específico do negócio |
| Atacantes vão entregar à API dados maliciosos a quaisquer vetores de injeção disponíveis (ex.: dados, parâmetros, integrações e etc.), esperando que estes dados sejam entregues a um interpretador. | Falhas por injeção são muito comuns e geralmente encontrados em consultas SQL, LDAP ou noSQL, comando em SO, *parsers* de XML e ORM. São falhas simples de encontrar ao revisar código fonte, e atacantes podem utilizar *scanners* e *fuzzers*. | Injeção pode levar ao vazamento de informação e perda de dados. Também podem levar à DoS ou a perda completa de um *host*. |

## A API está vulnerável?

A API está vulnerável às falhas de injeção se:

* Dados enviados pelo cliente não são validados, filtrados ou sanitizados pela API.
* Dados enviados pelo cliente são utilizados diretamente ou concatenados para consultas SQL/NoSQL/LDAP, comandos de sistema operacional, *parsers* XML, ORM (*Object Relational Mapping*) ou ODM (*Object Document Mapper*).
* Dados vindos de sistemas externos (ex.: sistemas de integração) não são validados, filtrados ou sanitizados pela API.

## Cenários de exemplo de ataques

### Cenário #1

O *firmware* de um dispositivo de controle parental provê o *endpoint* `/api/CONFIG/restore` o qual espera um appId a ser enviado como um parâmetro *multipart*. Utilizando um descompilador, o atacante encontra que o parâmetro appId é repassado diretamente para uma chamada de sistema sem qualquer sanitização:

```c
snprintf(cmd, 128, "%srestore_backup.sh /tmp/postfile.bin %s %d",
         "/mnt/shares/usr/bin/scripts/", appid, 66);
system(cmd);
```
Com o seguinte comando o atacante consegue desligar qualquer dispositivo que estiver com o *firmware* vulnerável:

```
$ curl -k "https://${deviceIP}:4567/api/CONFIG/restore" -F 'appid=$(/etc/pod/power_down.sh)'
```

### Cenário #2

Estamos com uma aplicação com funcionalidades básicas de CRUD para operações de agendamento. Um atacante identifica que uma injeção NoSQL pode ser possível por meio do um parâmetro `bookingId` informado via *querystring* na requisição de exclusão de pedido de agendamento. Eis a requisição em questão: `DELETE /api/bookings?bookingId=678`.

O servidor da API utiliza a seguinte função para executar a requisição de exclusão:

```javascript
router.delete('/bookings', async function (req, res, next) {
  try {
      const deletedBooking = await Bookings.findOneAndRemove({'_id' : req.query.bookingId});
      res.status(200);
  } catch (err) {
     res.status(400).json({error: 'Unexpected error occured while processing a request'});
  }
});
```

O atacante intercepta a requisição de modifica o valor da *querystring* `bookingId` como demonstrado abaixo. Neste caso, o atacante consegue excluir todos os demais agendamentos de usuários:

```
DELETE /api/bookings?bookingId[$ne]=678
```

## Como prevenir

Prevenir injeção requer manter os dados separados de comandos e consultas.

* Execute validação de dados utilizando uma biblioteca única, confiável e de ativa manutenção.
* Valide, filtre e sanitize todos os dados providos pelo cliente, e também dados vindos de sistemas integradores.
* Caracteres especiais devem ser avaliados utilizando a sintaxe específica do interpretador dos comandos.
* Prefira APIs seguras, que entreguem interfaces seguras e parametrizadas.
* Sempre limite o número de registros retornados para prevenir vazamento em massa em caso de injeção.
* Valide os dados recebidos utilizando filtros suficientes para permitir que apenas valores válidos cheguem aos interpretadores.
* Defina tipos de dados de padrões *strict* em todos os parâmetros do tipo *string*.

## Referências

### OWASP

* [OWASP Injection Flaws][1]
* [SQL Injection][2]
* [NoSQL Injection Fun with Objects and Arrays][3]
* [Command Injection][4]

### Externas

* [CWE-77: Command Injection][5]
* [CWE-89: SQL Injection][6]

[1]: https://owasp.org/www-community/Injection_Flaws
[2]: https://owasp.org/www-community/attacks/SQL_Injection
[3]: https://www.owasp.org/images/e/ed/GOD16-NOSQL.pdf
[4]: https://owasp.org/www-community/attacks/Command_Injection
[5]: https://cwe.mitre.org/data/definitions/77.html
[6]: https://cwe.mitre.org/data/definitions/89.html
