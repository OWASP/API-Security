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

O OWASP API Security Top 10 2023 é um documento de sensibilização prospetivo 
para uma indústria de ritmo acelerado. Não substitui outros TOP 10. Nesta 
edição:

* Combinámos *Excessive Data Exposure* e *Mass Assignment*, focando na causa
  comum: falhas na validação de autorização ao nível das propriedades do objeto.
* Damos mais ênfase ao consumo de recursos, em vez de nos concentrarmos na 
  rapidez com que são esgotados.
* Criámos uma nova categoria "*Unrestricted Access to Sensitive Business Flows*"
  para abordar novas ameaças, incluindo a maioria daquelas que podem ser 
  mitigadas através de *rate limiting*.
* Adicionámos "*Unsafe Consumption of APIs*" para abordar algo que começámos a
  observar: os atacantes começaram a procurar serviços integrados de um alvo 
  para os comprometer, em vez de atingirem diretamente as APIs do seu alvo. Este
  é o momento certo para começar a sensibilizar sobre este risco crescente.

As APIs desempenham um papel cada vez mais importante na arquitetura moderna de 
microsserviços, *Single Page Applications* (SPAs), aplicações móveis, Internet 
das Coisas (IoT), etc. O OWASP API Security Top 10 é um esforço necessário para 
criar sensibilização sobre os problemas de segurança modernos das APIs.

Esta atualização só foi possível devido ao grande esforço de vários voluntários, 
listados na secção de [Agradecimentos][4].

Obrigado!

[1]: https://owasp.org/www-project-api-security/announcements/cfd/2022/
[2]: ./0xd0-about-data.md
[3]: ./0x10-api-security-risks.md
[4]: ./0xd1-acknowledgments.md
