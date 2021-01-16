<h2 dir='rtl' align='right'> API10:2019 خلل في طريقة تسجيل الاحداث والمراقبة </h2>
============================================

<table dir='rtl' align="right">
  <tr>
    <th>عوامل التهديد/ الاستغلال  </th>
    <th> نقاط الضعف </th>
    <th> التأثير </th>
    <tr>
    <td> خصائص API : قابلية الاستغلال 2 </td>
    <td> الانتشار : 1 قابلية الاكتشاف : 3  </td>
    <td> التأثر التقني و تأثر الاعمال: 2 </td>
  </tr> 
     <td> يستغل المهاجمون عدم تسجيل الاحداث وحركة مرور البيانات للقيام بأنشطة ضارة. </td>
    <td> من دون وجود آلية او نظام لتسجيل حركة مرور البيانات او الاحداث سيكون هناك نظام مراقبة غير كفؤ، بل قد يصل في بعض الأحيان الى العملية المستحيلة لتتبع الأنشطة الضارة واتخاذ الاجراء في الوقت المناسب. </td>
    <td> من غير الحصول على تغطية شاملة لحركة المرور والسجلات سيكون لدى المهاجمين المقدرة على اختراق الأنظمة من غير وجود أي آلية لرصدهم او تتبع تحركاتهم داخل الأنظمة. </td>    
  </tr>
  </table>
<h3 dir='rtl' align='right'>هل أنا معرض لهذه الثغرة؟</h3>

<p dir='rtl' align='right'> سيكون النظام لديك معرض اذا كان: 

<p dir='rtl' align='right'>▪️ لا يتم استخراج أي سجلات او لم يتم تعين عمليات التسجيل بالشكل الصحيح او لم يتم جمع السجلات بشكل كافي وناضج.
<p dir='rtl' align='right'>▪️ عند عدم ضمان السجلات (على سبيل المثال في حال حقن السجلات بسجلات غير صحيح)
<p dir='rtl' align='right'>▪️ لا يتم مراقبة السجلات بشكل مستمر
<p dir='rtl' align='right'>▪️ لا يتم مراقبة البنية التحتية لواجهة برمجة التطبيقات API بشكل مستمر.
    
<h3 dir='rtl' align='right'> امثلة على سيناريوهات الهجوم: </h3>

<h4 dir='rtl' align='right'>السيناريو الاول: </h4>

<p dir='rtl' align='right'> عن طريق الخطأ تم تسريب احد مفاتيح إدارة المستودعات في احد قواعد البيانات العامة، تم احظار مالك المستودع عن طريق البريد الالكتروني بشأن التسريب المحتمل، ولكن لم يقم مالك المستودع من التجاوب خلال 48 ساعة والتصرف بشأن هذا التسريب، والذي من المحتمل استخدام هذه المفاتيح في عمليات تسريب البيانات، ولكن بسبب عدم كافية موارد تسجيل السجلات والاحداث لا تستطيع الشركة تقييم ومعرفة الأصول والبيانات التي تم الوصول لها او في حال تم تسريبها.

<h4 dir='rtl' align='right'>السيناريو الثاني : </h4>

<p dir='rtl' align='right'> تم استهداف أحد منصات مشاركة ملفات الفيديو بهجمات كسر كلمات المرور المسربة مسبقاً من أحد الهجمات السابقة. على الرغم من عدد المحاولات تسجيل الدخول غير الصحيحة لم يتم تفعيل التنبيهات خلال فترة الهجوم، وكردة فعل قام المستخدمين بالشكوى من اغلاق الحسابات الخاصة بهم بسبب عدد المحاولات، وبعد عملية تحليل السجلات الخاصة بواجهات برمجة التطبيقات API تبين ان هناك فعلاً هجوم وكان على الشركة اصدار اعلان لجميع المستخدمين بتغير كلمات المرور الخاصة. 


## How To Prevent

* Log all failed authentication attempts, denied access, and input validation
  errors.
* Logs should be written using a format suited to be consumed by a log
  management solution, and should include enough detail to identify the
  malicious actor.
* Logs should be handled as sensitive data, and their integrity should be
  guaranteed at rest and transit.
* Configure a monitoring system to continuously monitor the infrastructure,
  network, and the API functioning.
* Use a Security Information and Event Management (SIEM) system to aggregate and
  manage logs from all components of the API stack and hosts.
* Configure custom dashboards and alerts, enabling suspicious activities to be
  detected and responded to earlier.

## References

### OWASP

* [OWASP Logging Cheat Sheet][2]
* [OWASP Proactive Controls: Implement Logging and Intrusion Detection][3]
* [OWASP Application Security Verification Standard: V7: Error Handling and
  Logging Verification Requirements][4]

### External

* [CWE-223: Omission of Security-relevant Information][5]
* [CWE-778: Insufficient Logging][6]

[1]: https://www.owasp.org/index.php/Log_Injection
[2]: https://www.owasp.org/index.php/Logging_Cheat_Sheet
[3]: https://www.owasp.org/index.php/OWASP_Proactive_Controls
[4]: https://github.com/OWASP/ASVS/blob/master/4.0/en/0x15-V7-Error-Logging.md
[5]: https://cwe.mitre.org/data/definitions/223.html
[6]: https://cwe.mitre.org/data/definitions/778.html
