# Metodologia e Dati

## Panoramica

Per questo aggiornamento della lista, il team OWASP API Security ha utilizzato
la stessa metodologia adottata per la lista 2019, di grande successo e ampia
adozione, con l'aggiunta di una [raccolta pubblica di dati][1] della durata di
3 mesi. Purtroppo, questa raccolta non ha prodotto dati sufficienti per
un'analisi statistica rilevante dei problemi di sicurezza delle API più comuni.

Tuttavia, con un settore della sicurezza delle API più maturo e in grado di
fornire feedback e approfondimenti diretti, il processo di aggiornamento è
andato avanti utilizzando la stessa metodologia precedente.

Giunti a questo punto, riteniamo di avere un buon documento di sensibilizzazione
orientato al futuro per i prossimi tre o quattro anni, più focalizzato sui
problemi specifici delle API moderne. L'obiettivo di questo progetto non è
sostituire altre classifiche top 10, bensì coprire i rischi di sicurezza delle
API attuali ed emergenti di cui riteniamo che il settore dovrebbe essere
consapevole e diligente.

## Metodologia

Nella prima fase, sono stati raccolti, esaminati e categorizzati dati
pubblicamente disponibili sugli incidenti di sicurezza delle API. Tali dati
sono stati raccolti da piattaforme di bug bounty e rapporti pubblicamente
disponibili. Sono stati considerati solo i problemi segnalati tra il 2019 e il
2022. Questi dati sono stati utilizzati per dare al team un'idea della direzione
in cui la precedente lista top 10 avrebbe dovuto evolversi, nonché per aiutare
a gestire possibili bias nei dati contribuiti.

Una [raccolta pubblica di dati][1] è stata condotta dal 1° settembre al 30
novembre 2022. In parallelo, il team di progetto ha avviato la discussione su
cosa fosse cambiato dal 2019. La discussione ha incluso l'impatto della prima
lista, il feedback ricevuto dalla community e le nuove tendenze della sicurezza
delle API.

Il team di progetto ha promosso incontri con specialisti sulle minacce rilevanti
alla sicurezza delle API per ottenere approfondimenti su come le vittime vengono
colpite e su come tali minacce possono essere mitigate.

Questo lavoro ha prodotto una bozza iniziale di quelli che il team ritiene
essere i dieci rischi di sicurezza delle API più critici. La [Metodologia di
Valutazione del Rischio OWASP][2] è stata utilizzata per eseguire l'analisi del
rischio. I rating di diffusione sono stati decisi mediante consenso tra i membri
del team di progetto, basandosi sulla loro esperienza sul campo. Per
considerazioni su queste questioni, si prega di fare riferimento alla sezione
[Rischi di Sicurezza delle API][3].

La bozza iniziale è stata poi condivisa per la revisione con professionisti
della sicurezza con esperienza rilevante nel campo della sicurezza delle API.
I loro commenti sono stati esaminati, discussi e, ove applicabile, inclusi nel
documento. Il documento risultante è stato [pubblicato come Release Candidate][4]
per una [discussione aperta][5]. Diversi [contributi della community][6] sono
stati inclusi nel documento finale.

L'elenco dei contributori è disponibile nella sezione [Riconoscimenti][7].

## Rischi Specifici delle API

La lista è stata costruita per affrontare i rischi di sicurezza più specifici
delle API.

Non implica che altri rischi generici di sicurezza delle applicazioni non
esistano nelle applicazioni basate su API. Ad esempio, non abbiamo incluso
rischi come "Componenti Vulnerabili e Obsoleti" o "Injection", sebbene possano
essere presenti nelle applicazioni basate su API. Questi rischi sono generici,
non si comportano diversamente nelle API e il loro sfruttamento non è diverso.

Il nostro obiettivo è aumentare la consapevolezza sui rischi di sicurezza che
meritano particolare attenzione nelle API.

[1]: https://owasp.org/www-project-api-security/announcements/cfd/2022/
[2]: https://www.owasp.org/index.php/OWASP_Risk_Rating_Methodology
[3]: ./0x10-api-security-risks.md
[4]: https://owasp.org/www-project-api-security/announcements/2023/02/api-top10-2023rc
[5]: https://github.com/OWASP/API-Security/issues?q=is%3Aissue+label%3A2023RC
[6]: https://github.com/OWASP/API-Security/pulls?q=is%3Apr+label%3A2023RC
[7]: ./0xd1-acknowledgments.md