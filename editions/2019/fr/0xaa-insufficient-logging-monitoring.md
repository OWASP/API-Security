# API10:2019 Insufficient Logging & Monitoring

| Facteurs de menace / Vecteurs d'attaque | Faille de sécurité | Impact |
| - | - | - |
| Spécifique API : Exploitabilité **2** | Prévalence **3** : Détectabilité **1** | Technique **2** : Spécifique à l'organisation |
| Les attaquants exploitent l'absence de logging et de monitoring pour utiliser frauduleusement des systèmes sans se faire repérer. | En l'absence de logging et de monitoring, ou si le logging et le monitoring sont insuffisants, il est pratiquement impossible de suivre des activités suspectes et d'y répondre rapidement. | Sans visibilité sur les activités malveillantes en cours, les attaquants disposent de beaucoup de temps et peuvent compromettre complètement les systèmes. |

## L'API est-elle vulnérable ?

L'API is vulnérable si :

* Elle ne produit pas de logs, le niveau de logging n'est pas réglé
  correctement, ou les messages de log ne comportent pas suffisamment
  d'informations.
* L'intégrité des logs ne peut pas être garantie (ex : [Log Injection][1]).
* Les logs ne sont pas monitorés en permanence.
* L'infrastructure de l'API n'est pas monitorée en permanence.

## Exemples de scénarios d'attaque

### Scénario #1

Les clés d'accès d'une API d'administration ont fuité sur un répertoire public.
Le propriétaire du répertoire a été notifié par e-mail à propos de cette fuite
potentielle, mais a mis plus de 48 heures à réagir à l'incident, et
l'exposition des clés d'accès peut avoir permis l'accès à des données
personnelles. Du fait d'un logging insuffisant, l'entreprise n'est pas capable
d'évaluer quelles données ont pu être consultées par des acteurs malveillants.

### Scénario #2

Une plate-forme de partage de vidéos a subi une attaque par bourrage
d'identifiants de “grande ampleur”. Malgré le log des essais infructueux,
aucune alerte n'a été émise pendant la durée de l'attaque. En réaction aux
plaintes des utilisateurs, les logs de l'API ont été analysés et l'attaque a
été détectée. L'entreprise a dû faire une annonce publique pour demander aux
utilisateurs de réinitialiser leur mot de passe, et a dû déclarer l'incident
aux autorités de contrôle.

## Comment s'en prémunir

* Loggez toutes les tentatives infructueuses d'authentification, les accès
  refusés et les erreurs de validations des données entrées.
* Les logs doivent être formatés pour pouvoir être traités par un outil de
  gestion des logs, et doivent inclure suffisamment d'informations pour pouvoir
  identifier un acteur malveillant.
* Les logs doivent être considérés comme des données sensibles, et leur
  intégrité doit être garantie durant leur stockage comme au cours de leur transfert.
* Configurez un système de monitoring pour surveiller en permanence
  l'infrastructure, le réseau et le fonctionnement de l'API.
* Utilisez un système d'information et de gestion des événements (SIEM) pour
  agréger et gérer les logs de tous les composants de la pile de l'API et des
  hôtes.
* Configurez des tableaux de bord et des alertes personnalisés, permettant la
  détection et le traitement plus rapide d'activités suspectes.

## Références

### OWASP

* [OWASP Logging Cheat Sheet][2]
* [OWASP Proactive Controls: Implement Logging and Intrusion Detection][3]
* [OWASP Application Security Verification Standard: V7: Error Handling and
  Logging Verification Requirements][4]

### Externes

* [CWE-223: Omission of Security-relevant Information][5]
* [CWE-778: Insufficient Logging][6]

[1]: https://www.owasp.org/index.php/Log_Injection
[2]: https://www.owasp.org/index.php/Logging_Cheat_Sheet
[3]: https://www.owasp.org/index.php/OWASP_Proactive_Controls
[4]: https://github.com/OWASP/ASVS/blob/master/4.0/en/0x15-V7-Error-Logging.md
[5]: https://cwe.mitre.org/data/definitions/223.html
[6]: https://cwe.mitre.org/data/definitions/778.html
