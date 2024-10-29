# RISK ریسک های امنیتی API

به منظور تحلیل ریسک، از متدولوژی رتبه بندی ریسک OWASP استفاده شده است.
جدول زیر، واژگان مرتبط با رتبه ریسک را مختصرا نشان می‌دهد.

| عوامل تهدید    | قابلیت بهره برداری | میزان شیوع آسیب‌پذیری | قابلیت شناسایی آسیب‌پذیری | پیامد فنی  | تاثیر بر کسب و کار   |
|----------------|--------------------|-----------------------|----------------------------|------------|----------------------|
| خاص API        | آسان: 3            | گسترده: 3             | آسان: 3                    | شدید: 3    | خاص کسب و کار        |
|                | متوسط: 2           | متداول: 2             | متوسط: 2                   | متوسط: 2   |                      |
|                | سخت: 1             | سخت: 1                | سخت: 1                     | جزئی: 1    |                      |

در این رویکرد، نوع فناوری مورد استفاده و احتمال وقوع آسیب‌پذیری در رتبه ریسک تاثیر ندارند؛ بعبارت دیگر در این روش رتبه بندی ریسک، راهکار مورد استفاده برای ‌‌‌‌پیاده‌سازی API، با رویکردی مستقل از جزئیات فناوری به ارزیابی ریسک می‌پردازد. هرکدام از عوامل یاد شده می‌تواند در پیداکردن و سواستفاده از یک آسیب‌پذیری به مهاجم کمک بسزایی کند. این رتبه بندی تاثیر واقعی بر کسب و کارها را نشان نداده و این سازمان‌ها هستند که با توجه به نوع کسب و کار و فرهنگ سازمانی خود، در میزان پذیرش خطر امنیتی استفاده از اپلیکیشن‌ها و APIها تصمیم گیرنده هستند. هدف از مستند ده آسیب‌پذیری بحرانی امنیت API، تحلیل ریسک نیست.

## مراجع

### OWASP

-	[OWASP Risk Rating Methodology][1]
-	[Article on Threat/Risk Modeling][2]

### خارجی

-	[ISO 31000: Risk Management Std][3]
-	[ISO 27001: ISMS][4]
-	[NIST Cyber Framework (US)][5]
-	[ASD Strategic Mitigations (AU)][6]
-	[NIST CVSS 3.0][7]
-	[Microsoft Threat Modeling Tool][8]

[1]: https://owasp.org/www-project-risk-assessment-framework/
[2]: https://owasp.org/www-community/Threat_Modeling
[3]: https://www.iso.org/iso-31000-risk-management.html
[4]: https://www.iso.org/isoiec-27001-information-security.html
[5]: https://www.nist.gov/cyberframework
[6]: https://www.asd.gov.au/infosec/mitigationstrategies.htm
[7]: https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator
[8]: https://www.microsoft.com/en-us/download/details.aspx?id=49168
