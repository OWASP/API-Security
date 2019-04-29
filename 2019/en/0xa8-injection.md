A8:2019 Injection
=================

| Threat agents/Attack vectors | Security Weakness | Impacts |
| -- | -- | -- |
| Access Lvl : Exploitability ? | Prevalence ? : Detectability ? | Technical ? : Business |
| | | |

## Is the API Vulnerable?

## Example Attack Scenarios

### Scenario #1

### Scenario #2

A parental control device firmware provides the endpoint `/api/CONFIG/restore`
which expects an `appId` to be sent as a multipart parameter. Using a decompiler
an attacker finds out that the `appId` is passed directly into a system call
without any sanitization. The following command allows the attacker to shutdown
any device with the same vulnerable firmware
`curl -k "https://${deviceIP}:4567/api/CONFIG/restore" -F ‘appid=$(/etc/pod/power_down.sh)’`.

## How To Prevent

## References

### OWASP

* [Command Injection][1]

### External

* [HOW TO: Command Injection, HackerOne][2]

[1]: https://www.owasp.org/index.php/Command_Injection
[2]: https://www.hackerone.com/blog/how-to-command-injections
