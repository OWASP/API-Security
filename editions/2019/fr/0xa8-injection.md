# API8:2019 Injection

| Facteurs de menace / Vecteurs d'attaque | Faille de sécurité | Impact |
| - | - | - |
| Spécifique API : Exploitabilité **3** | Prévalence **2** : Détectabilité **3** | Technique **3** : Spécifique à l'organisation |
| Les attaquants vont envoyer à l'API des données malveillantes via tout vecteur d'injection disponible (ex : entrée directe, paramètres, services intégrés, etc), en espérant qu'elles soient envoyés à un interpréteur. | Les failles par injection sont très courantes et souvent trouvées dans des requêtes SQL, LDAP, ou NoSQL, des commandes systèmes (OS), des parsers XML et des ORM. Ces failles sont faciles à trouver lors de la revue du code source. Les attaquants peuvent utiliser des scanners et des fuzzers. | L'injection peut aboutir à des divulgations d'informations et des pertes de données. Elle peut aussi aboutir à un déni de service, ou à une prise de contrôle complète de l'hôte. |

## L'API est-elle vulnérable ?

L'API est vulnérables à l'injection si :

* Les données fournies par le client ne sont pas validées, filtrées et épurées
  par l'API.
* Les données fournies par le client sont directement utilisées ou concaténées
  dans des requêtes SQL / NoSQL / LDAP, des commandes de système
  d'exploitation, des parsers XML ou des mappages objet-relationnel (ORM) /
  mappages objet-document (ODM).
* Les données en provenance de systèmes externes (ex : systèmes intégrés) ne
  sont pas validées, filtrées et épurées par l'API.

## Exemples de scénarios d'attaque

### Scénario #1

Le firmware d'un appareil de contrôle parental dispose d'un point d'accès
`/api/CONFIG/restore` qui prend en entrée un appId devant être envoyé comme
paramètre multiparties. Avec un décompilateur, un attaquant découvre que
l'appId est passé directement dans un appel système sans aucune épuration :

```c
snprintf(cmd, 128, "%srestore_backup.sh /tmp/postfile.bin %s %d",
         "/mnt/shares/usr/bin/scripts/", appid, 66);
system(cmd);
```

La commande suivante permet à l'attaquant d'arrêter tout appareil équipé de ce
même firmware vulnérable :

```
$ curl -k "https://${deviceIP}:4567/api/CONFIG/restore" -F 'appid=$(/etc/pod/power_down.sh)'
```

### Scénario #2

Nous avons une application dotée de fonctionnalités CRUD basiques pour les
opérations de réservation. Un attaquant a réussi à découvrir qu'une injection
NoSQL pourrait être possible via le paramètre `bookingId` de la chaine de
requête pour la suppression d'une réservation. Voici à quoi ressemble cette
requête : `DELETE /api/bookings?bookingId=678`.

L'API serveur utilise la fonction suivante pour traiter les requêtes de
suppression :

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

L'attaquant a intercepté la requête et a remplacé le paramètre `bookingId` de
la chaine de requête comme indiqué ci-dessous. Dans le cas présent, l'attaquant
a réussi à supprimer la réservation d'un autre utilisateur :

```
DELETE /api/bookings?bookingId[$ne]=678
```

## Comment s'en prémunir

Prévenir les injections requiert de séparer les données des commandes et des
requêtes.

* Effectuez la validation des données avec une bibliothèque unique, digne de
  confiance et activement maintenue.
* Validez, filtrez et épurez toutes les données fournies par le client, ou les
  autres données en provenance de systèmes intégrés.
* Les caractères spéciaux doivent être échappés en utilisant la syntaxe
  spécifique à l'interpréteur cible.
* Préférez une API sûre qui fournit une interface paramétrée.
* Limitez toujours le nombre d'enregistrements retournés pour éviter les
  divulgations de masse en cas d'injection.
* Validez les données entrantes avec suffisamment de filtres pour accepter
  uniquement les valeurs valides pour chaque paramètre d'entrée.
* Définissez des types de données et des schémas stricts pour tous les
  paramètres de chaines.

## Références

### OWASP

* [OWASP Injection Flaws][1]
* [SQL Injection][2]
* [NoSQL Injection Fun with Objects and Arrays][3]
* [Command Injection][4]

### Externes

* [CWE-77: Command Injection][5]
* [CWE-89: SQL Injection][6]

[1]: https://www.owasp.org/index.php/Injection_Flaws
[2]: https://www.owasp.org/index.php/SQL_Injection
[3]: https://www.owasp.org/images/e/ed/GOD16-NOSQL.pdf
[4]: https://www.owasp.org/index.php/Command_Injection
[5]: https://cwe.mitre.org/data/definitions/77.html
[6]: https://cwe.mitre.org/data/definitions/89.html
