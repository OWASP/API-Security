# Notas da Versão

Esta é a segunda edição do OWASP API Security Top 10, exatamente quatro anos
após a primeira versão. Muito mudou no panorama das API (a nível de 
segurança). O tráfego das API aumentou a um ritmo acelerado, alguns protocolos 
de API ganharam muito mais popularidade, surgiram muitos novos vendedores/
soluções de segurança para API e, claro, os atacantes desenvolveram novas 
capacidades e técnicas para comprometer APIs. Já era hora de atualizar a lista 
dos dez riscos de segurança de API mais críticos.

Com uma indústria de segurança de API mais madura, pela primeira vez, houve [um
 apelo público para dados][1]. Infelizmente, não foram fornecidos dados, mas 
 com base na experiência da equipa do projeto, numa análise cuidadosa por 
 especialistas em segurança de API e no feedback da comunidade sobre a versão 
 preliminar, construímos esta nova lista. Na [secção Metodologia e Dados][2], 
 encontrará mais detalhes sobre como esta versão foi elaborada. Para mais 
 detalhes sobre os riscos de segurança, consulte a [secção Riscos de Segurança 
 em APIs][3].

The OWASP API Security Top 10 2023 is a forward-looking awareness document for
a fast pace industry. It does not replace other TOP 10's. In this edition:

* We've combined Excessive Data Exposure and Mass Assignment focusing on the
  common root cause: object property level authorization validation failures.
* We've put more emphasis on resource consumption, over focusing on the pace
  they are exhausted.
* We've created a new category "Unrestricted Access to Sensitive Business Flows"
  to address new threats, including most of those that can be mitigated using
  rate limiting.
* We added "Unsafe Consumption of APIs" to address something we've started
  seeing: attackers have started looking for a target's integrated services to
  compromise those, instead of hitting the APIs of their target directly. This
  is the right time to start creating awareness about this increasing risk.

APIs play an increasingly important role in modern microservices architecture,
Single Page Applications (SPAs), mobile apps, IoT, etc. The OWASP API Security
Top 10 is a required effort to create awareness about modern API security
issues.

This update was only possible due to the great effort of several volunteers,
listed in the [Acknowledgments][4] section.

Thank you!

[1]: https://owasp.org/www-project-api-security/announcements/cfd/2022/
[2]: ./0xd0-about-data.md
[3]: ./0x10-api-security-risks.md
[4]: ./0xd1-acknowledgments.md
