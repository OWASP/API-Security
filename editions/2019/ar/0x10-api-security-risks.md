# مخاطر برمجة واجهة التطبيقات

* تم استخدام [ نموذج تقييم المخاطر الخاص بـ OWASP](0x03-introduction.md) وذلك بهدف تحليل المخاطر.

يلخص الجدول أدناه المصطلحات المرتبطة بدرجة المخاطر.


| عوامل التهديد | الاستغلال | نقاط الضعف الأمنية	 | اكتشاف الضعف الأمني	 | التأثيرات التقنية	 | التأثيرات على العمل |
|---------------|-----------|---------------------|----------------------|--------------------|---------------------|
| خصائص API     | بسيط 3	   | منتشرة 3	           | بسيط 3	              | حرج 3	             | تحديد الأعمال       |
| خصائص API     | متوسط 2	  | عام 2	              | متوسط 2	             | متوسط 2	           | تحديد الأعمال       |
| خصائص API     | صعب 1	    | صعب 1	              | صعب 1	               | منخفض              | تحديد الأعمال       |


**ملاحظة:**  هذا النهج لا يأخذ في الاعتبار احتمال وجود عامل التهديد، كما أنه لا يأخذ في الحسبان أيًا من التفاصيل الفنية المختلفة المرتبطة بتطبيقك. يمكن لأي من هذه العوامل أن تؤثر بشكل كبير على الاحتمالية الإجمالية للمهاجم  للعثور على ثغرة أمنية معينة واستغلالها. لا يأخذ هذا التصنيف في الاعتبار التأثير الفعلي على عملك، سيتعين على مؤسستك تحديد مقدار المخاطر الأمنية من التطبيقات وواجهات برمجة التطبيقات التي ترغب المؤسسة في قبولها في ضوء البيئة  التنظيمية. الغرض من OWASP API Security Top 10 ليس القيام بتحليل المخاطره  نيابة عنك 


## المراجع

### أواسب
* [OWASP Risk Rating Methodology][1]
* [Article on Threat/Risk Modeling][2]

### الروابط الخارجية

* [ISO 31000: Risk Management Std][3]
* [ISO 27001: ISMS][4]
* [NIST Cyber Framework (US)][5]
* [ASD Strategic Mitigations (AU)][6]
* [NIST CVSS 3.0][7]
* [Microsoft Threat Modeling Tool][8]

[1]: https://www.owasp.org/index.php/OWASP_Risk_Rating_Methodology
[2]: https://www.owasp.org/index.php/Threat_Risk_Modeling
[3]: https://www.iso.org/iso-31000-risk-management.html
[4]: https://www.iso.org/isoiec-27001-information-security.html
[5]: https://www.nist.gov/cyberframework
[6]: https://www.asd.gov.au/infosec/mitigationstrategies.htm
[7]: https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator
[8]: https://www.microsoft.com/en-us/download/details.aspx?id=49168
