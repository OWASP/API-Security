API8:2019 Inyección
===================

|Agente/Vector de Ataque | Debilidades de Seguridad | Impacto |
| - | - | - |
| API Específica : Explotabilidad **3** | Prevalencia **2** : Detectabilidad **3** | Técnico **3** : ¿Negocio? |
| Los atacantes alimentarán la API con datos maliciosos a través de los vectores de inyección disponibles (por ejemplo, entrada directa, parámetros, servicios integrados, etc.), esperando que se envíen a un intérprete. | Los defectos de inyección son muy comunes y a menudo se encuentran en consultas SQL, LDAP o NoSQL, comandos del sistema operativo, analizadores XML y ORM. Estos defectos son fáciles de descubrir cuando se revisa el código fuente. Los atacantes pueden usar escáneres y fuzzers. | La inyección puede conducir a la divulgación de información y pérdida de datos. También puede llevar a un DoS o apoderarse completamente del host. |

## ¿La API es Vulnerable?

La API es vulnerable a inyección si:

* Información suministrada por el cliente no es validada, filtrada, o sanitizada por la API.
* Información suministrada por el cliente es directamente usada o concatenada a consultas SQL/NoSQL/LDAP, comandos de SO, Analizadores de XML, y Mapeo Relacional de Objetos (ORM) / Mapeador de Documentos de Objetos (ODM).
* Datos que vienen de sistemas externos (ej. sistemas integrados) no son validados, filtrados, o sanitizados por la API.

## Ejemplos de escenarios de ataque

### Escenario #1

El firmware de un dispositivo de control parental expone el método `/api/CONFIG/restore` el cual espera un appId para que se
envíe como un parámetro multiparte. Usando un descompilador, un atacante descubre que un appId pasa directamente a una llamada al
sistema sin ningún tipo de sanitización:

```c
snprintf(cmd, 128, "%srestore_backup.sh /tmp/postfile.bin %s %d",
         "/mnt/shares/usr/bin/scripts/", appid, 66);
system(cmd);
```

El siguiente comando permite al atacante apagar cualquier dispositivo con el mismo firmware vulnerable:
```
$ curl -k "https://${deviceIP}:4567/api/CONFIG/restore" -F 'appid=$(/etc/pod/power_down.sh)'
```

### Escenario #2

Tenemos una aplicación con funcionalidad CRUD básica para operaciones con
reservaciones. Un atacante logró identificar que la inyección NoSQL podría ser posible
a través del parámetro de `bookingId`, un parámetro de tipo string en la petición para borrar una reservación. Así es como se ve dicha solicitud: `DELETE /api/bookings?bookingId=678`.

El servidor de la API usa la siguiente función para manejar las solicitudes de eliminación:

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

El atacante intercepta la petición y cambia el parámetro de tipo string  `bookingId` como se muestra a continuación. En este caso, el atacante logró eliminar la reservación de otro usuario.

```
DELETE /api/bookings?bookingId[$ne]=678
```

## Cómo se previene

Para prevenir ataques de inyección se requiere que los datos se mantengan separados de los comandos y las consultas.

* Realice la validación de datos utilizando una biblioteca única, confiable y actualizada.
* Valide, filtre y desinfecte todos los datos proporcionados por el cliente u otros datos provenientes de sistemas integrados.
* Los caracteres especiales se deben escapar utilizando la sintaxis específica para el intérprete de destino.
* Opte por una API segura que proporcione una interfaz parametrizada.
* Siempre limite el número de registros devueltos para evitar la divulgación masiva en caso de un ataque de inyección.
* Valide los datos entrantes utilizando filtros suficientes para permitir solo valores válidos para cada parámetro de entrada.
* Defina tipos de datos y patrones estrictos para todos los parámetros de tipo string.

## Referencias

### OWASP

* [OWASP Injection Flaws][1]
* [SQL Injection][2]
* [NoSQL Injection Fun with Objects and Arrays][3]
* [Command Injection][4]

### Externos

* [CWE-77: Command Injection][5]
* [CWE-89: SQL Injection][6]

[1]: https://www.owasp.org/index.php/Injection_Flaws
[2]: https://www.owasp.org/index.php/SQL_Injection
[3]: https://www.owasp.org/images/e/ed/GOD16-NOSQL.pdf
[4]: https://www.owasp.org/index.php/Command_Injection
[5]: https://cwe.mitre.org/data/definitions/77.html
[6]: https://cwe.mitre.org/data/definitions/89.html
