# Note di Rilascio

Questa è la seconda edizione dell'OWASP API Security Top 10, esattamente quattro
anni dopo la prima pubblicazione. Molto è cambiato nel panorama della sicurezza
delle API. Il traffico API è cresciuto rapidamente, alcuni protocolli API hanno
guadagnato molto più spazio, sono emersi molti nuovi vendor e soluzioni per la
sicurezza delle API e, naturalmente, gli attaccanti hanno sviluppato nuove
competenze e tecniche per compromettere le API. Era giunto il momento di
aggiornare la lista dei dieci rischi di sicurezza delle API più critici.

Con un settore della sicurezza delle API più maturo, per la prima volta è stata
lanciata una [raccolta pubblica di dati][1]. Purtroppo non sono stati forniti
dati sufficienti per un'analisi statistica rilevante, ma basandoci sull'esperienza
del team di progetto, su un'attenta revisione da parte di specialisti in sicurezza
delle API e sul feedback della community sulla release candidate, abbiamo
costruito questa nuova lista. Nella [sezione Metodologia e Dati][2] troverai
maggiori dettagli su come è stata costruita questa versione. Per ulteriori
informazioni sui rischi di sicurezza, fai riferimento alla
[sezione Rischi di Sicurezza delle API][3].

L'OWASP API Security Top 10 2023 è un documento di sensibilizzazione
orientato al futuro per un settore in rapida evoluzione. Non sostituisce
altre classifiche Top 10. In questa edizione:

* Abbiamo unito Excessive Data Exposure e Mass Assignment, concentrandoci sulla
  causa radice comune: le carenze nella validazione dell'autorizzazione a livello
  di proprietà degli oggetti.
* Abbiamo posto maggiore enfasi sul consumo delle risorse, rispetto alla
  velocità con cui vengono esaurite.
* Abbiamo creato una nuova categoria "Unrestricted Access to Sensitive Business
  Flows" per affrontare nuove minacce, incluse la maggior parte di quelle
  mitigabili tramite il rate limiting.
* Abbiamo aggiunto "Unsafe Consumption of APIs" per trattare un fenomeno
  emergente: gli attaccanti hanno iniziato a prendere di mira i servizi
  integrati di un bersaglio per comprometterli, anziché colpire direttamente
  le API del target. È il momento giusto per iniziare a creare consapevolezza
  su questo rischio crescente.

Le API svolgono un ruolo sempre più importante nelle architetture moderne a
microservizi, nelle Single Page Application (SPA), nelle app mobile, nell'IoT e
altro ancora. L'OWASP API Security Top 10 è uno sforzo necessario per creare
consapevolezza sui problemi di sicurezza delle API moderne.

Questo aggiornamento è stato possibile grazie al grande impegno di numerosi
volontari, elencati nella sezione [Riconoscimenti][4].

Grazie!

[1]: https://owasp.org/www-project-api-security/announcements/cfd/2022/
[2]: ./0xd0-about-data.md
[3]: ./0x10-api-security-risks.md
[4]: ./0xd1-acknowledgments.md