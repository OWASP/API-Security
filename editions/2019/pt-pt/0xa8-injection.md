# API8:2019 Injection

| Agentes Ameaça/Vetores Ataque | Falha Segurança | Impactos |
| - | - | - |
| Específico da API : Abuso **3** | Prevalência **2** : Deteção **3** | Técnico **3** : Específico Negócio |
| Os atacantes fornecem à API dados maliciosos através dos vetores de injeção disponíveis (e.g., formulários, parâmetros, integrações, etc.), na expetativa que estes sejam enviados a um interpretador. | Falhas de injeção são bastante comuns e são geralmente encontradas em consultas SQL, LDAP ou NoSQL, comandos enviados ao sistema operativo, _parsers_ XML e ORM. Estas falhas são fáceis de identificar durante a revisão do código. Os atacantes podem fazer uso de _scanners_ e _fuzzers_. | As injeções podem conduzir à divulgação de informação e perda de dados. Podem ainda conduzir à negação de serviço (DoS) ou à tomada de controlo do _host_. |

## A API é vulnerável?

A API é vulnerável se:

* Dados fornecidos pelo cliente não são validados, filtrados ou sanitizados pela
  API.
* Dados fornecidos pelo cliente são concatenados diretamente em consultas
  SQL/NoSQL/LDAP, comandos a enviar ao sistema operativo, _parsers_ XML e
  _Object Relational Mapping_ (ORM)/_Object Document Mapper_ (ODM).
* Dados com origem em sistemas externos (e.g., sistemas integrados) não são
  validados, filtrados ou sanitizados pela API.

## Exemplos de Cenários de Ataque

### Cenário #1

O _firmware_ dum dispositivo de controlo parental implementa o _endpoint_
`/api/CONFIG/restore`, o qual espera que lhe seja enviado uma parâmetro `appId`
no formato `multipart`. Com recurso a um descompilador, um atacante descobre que
o parâmetro `appId` é passado diretamente numa chamada ao sistema sem qualquer
tipo de sanitização:

```c
snprintf(cmd, 128, "%srestore_backup.sh /tmp/postfile.bin %s %d",
         "/mnt/shares/usr/bin/scripts/", appid, 66);
system(cmd);
```

O comando abaixo permite ao atacante desligar qualquer equipamento que corra o
mesmo _firmware_ vulnerável:

```
$ curl -k "https://${deviceIP}:4567/api/CONFIG/restore" -F 'appid=$(/etc/pod/power_down.sh)'
```

### Cenário #2

Perante uma aplicação de reservas com funcionalidades de criação, consulta,
atualização e remoção, um atacante desconfia que talvez seja possível realizar
injeções NoSQL através do parâmetro `bookingId` presente na _query string_ dos
pedidos de remoção. Este é o aspeto do pedido:
`DELETE /api/bookings?bookingId=678`.

Esta é a função usada pelo servidor da API para atender tais pedidos:

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

O atacante interceta o pedido e altera o parâmetro `bookingId` na
_query string_, conforme apresentado abaixo. Neste caso o atacante consegue
apagar a reserva doutro utilizador.

```
DELETE /api/bookings?bookingId[$ne]=678
```

## Como Prevenir

A prevenção de injeções exige que os dados sejam separados dos comandos e
consultas.

* Usar uma única biblioteca para validação de dados que seja confiável e
  ativamente mantida.
* Validar, filtrar e sanitizar todos os dados fornecidos pelo cliente ou outros
  dados provenientes de sistemas integrados.
* Caracteres especiais devem ser neutralizados com recurso à sintaxe específica
  do interpretador para onde serão enviados.
* Opte por APIs de consulta seguras que oferecem interfaces parametrizadas.
* Limite sempre o número de registos a devolver por forma a prevenir a
  divulgação massiva de dados em caso de injeção.
* Valide os dados de entrada usando os filtros necessários para apenas permitir
  valores válidos para cada parâmetro.
* Defina tipos de dados e padrões bem definidos para todos os parâmetros
  textuais.

## Referências

### OWASP

* [OWASP Injection Flaws][1]
* [SQL Injection][2]
* [NoSQL Injection Fun with Objects and Arrays][3]
* [Command Injection][4]

### External

* [CWE-77: Command Injection][5]
* [CWE-89: SQL Injection][6]

[1]: https://owasp.org/www-community/Injection_Flaws
[2]: https://owasp.org/www-community/attacks/SQL_Injection
[3]: https://www.owasp.org/images/e/ed/GOD16-NOSQL.pdf
[4]: https://owasp.org/www-community/attacks/Command_Injection
[5]: https://cwe.mitre.org/data/definitions/77.html
[6]: https://cwe.mitre.org/data/definitions/89.html
