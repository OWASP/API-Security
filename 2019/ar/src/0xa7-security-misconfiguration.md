<h2 dir='rtl' align='right'> API7:2019 الاعداد الخاطئ</h2>

<table dir='rtl' align="right">
  <tr>
    <th>عوامل التهديد/ الاستغلال  </th>
    <th> نقاط الضعف </th>
    <th> التأثير </th>
    <tr>
    <td> خصائص API : قابلية الاستغلال 3</td>
    <td> الانتشار : 3 قابلية الاكتشاف : 3  </td>
    <td> التأثر التقني و تأثر الاعمال: 3 </td>
  </tr> 
     <td> يحاول المهاجمون غالباً البحث عن الثغرات الأمنية على مستوى الأنظمة او اليات العمل اول على مصادر بيانات غير محمية وذلك بغيت الوصول الغير مصرح به للمعلومات. </td>
    <td> يمكن ان يحدث الاعداد الخاطئ في أي مستوى من مستويات واجهة برمجة التطبيقات API، ابتداءًا من مستوى الشبكة الى مستوى التطبيقات، حيث تتوفر الأدوات للقيام بالفحص واكتشاف الأخطاء بشكل آلي وذلك بهدف البحث عن مواطن الإعدادات الخاطئة او الخدمات الفعلة والغير ضرورية او الخيارات القديمة والمصابة بثغرات. </td>
    <td> قد يؤدي عملية الإعدادات الخاطئة الى تسريب البيانات وكذلك اختراق الأنظمة والخوادم. </td>    
  </tr>
  </table>

<h3 dir='rtl' align='right'>هل أنا معرض لهذه الثغرة؟</h3>

<p dir='rtl' align='right'> قد يكون واجهة التطبيقات API معرض لثغرات في حال :

<p dir='rtl' align='right'>▪️ اذا لم يكن هناك أي آلية متبعة لعملية تعزيز حماية النظام في جميع مراحلة او اذا كان هناك تهيئة غير صحيحة على الخدمات السحابية.
<p dir='rtl' align='right'>▪️ اذا لم يكن هناك آلية لسد الثغرات الأمنية او في حال كانت الأنظمة المستخدمة غير محدثة او خارجة عن الخدمة.
<p dir='rtl' align='right'>▪️ اذا كان هناك تفعيل لبعض الطلبات الغير مطلوبة مثل بعض طلبات HTTP الغير مستخدمة TREAC او DELETE على سبيل المثال.
<p dir='rtl' align='right'>▪️  اذا لم يتم استخدام التشفير بواسطة TLS. 
<p dir='rtl' align='right'>▪️ إذا لم يتم تعين سياسة مشاركة المواد بطريقة صحيحة او كان هناك خطا في الإعدادات الخاصة بها
<p dir='rtl' align='right'>▪️ إذا كانت رسائل الخطة تحتوي على معلومات حساسة ويمكن تتبعها.   

<p dir='rtl' align='right'>▪️    

<h3 dir='rtl' align='right'> امثلة على سيناريوهات الهجوم: </h3>

<h4 dir='rtl' align='right'>السيناريو الاول: </h4>

<p dir='rtl' align='right'> يعثر المهاجم على ملف .bash_history في احد المسارات الرئيسية في الخادم والذي يحتوي على الأوامر التي يستخدمها المطورين في الوصول الى واجهة برمجية التطبيقات API.

```
$ curl -X GET 'https://api.server/endpoint/' -H 'authorization: Basic Zm9vOmJhcg=='
```
<p dir='rtl' align='right'> يمكن للمهاجم ايضاً معرفة مصادر البيانات من خلال الأوامر التي يستخدمها المطورين من خلال تكرار عملية الوصول للملف أعلاه وما حدث ذلك الا بسبب عد توثيق الإجراءات بالشكل الصحيح.

    
<h4 dir='rtl' align='right'>السيناريو الثاني : </h4>

<p dir='rtl' align='right'> يقوم المهاجمون في معظم الأحيان في استخدام محركات البحث بهدف الحصول على خوادم يستطيع من خلالها الوصول الى مصدر البيانات بشكل مباشر. او من خلال البحث عن أحد المنافذ المشهورة في قواعد البيانات او في إدارة الأنظمة والخوادم.  وفي حال كان الخادم او النظام المستهدف يقوم باستخدام الأعدادت الافتراضية وغير محمي باستخدام مصادقة صحيحة قد يمكن المهاجم من الوصول للبيانات الشخصية PII والذي قد يؤدي الى تسريب بيانات المستخدمين لتلك الخدمة.

<h4 dir='rtl' align='right'>السيناريو الثالث  : </h4>

<p dir='rtl' align='right'> عند اعتراض حركة المرور للبيانات الخاصة بأحد تطبيقات الهواتف المحمولة والتي تستخدم بروتوكول TLS  في حركة البيانات ولكن  لا تعتمد على التشفير باستخدام TLS  عند استخدام واجهة برمجة التطبيقات API وبعد البحث من قبل المهاجم استطاع معرفة ان عملية تحميل ورفع الصور يتم بشكل غير مشفر، فقد وجد المهاجم نمط وطريقة لمعرفة الاستجابة الواردة من قبل الخادم او من قبل مصدر البيانات والتي قد تمكنه بطريقة او بأخرى من تتبع تفضيلات المستخدمين عند تنزيل او عرض تلك الصور.

## How To Prevent

The API life cycle should include:

* A repeatable hardening process leading to fast and easy deployment of a
  properly locked down environment.
* A task to review and update configurations across the entire API stack. The
  review should include: orchestration files, API components, and cloud services
  (e.g., S3 bucket permissions).
* A secure communication channel for all API interactions access to static
  assets (e.g., images).
* An automated process to continuously assess the effectiveness of the
  configuration and settings in all environments.

Furthermore:

* To prevent exception traces and other valuable information from being sent
  back to attackers, if applicable, define and enforce all API response payload
  schemas including error responses.
* Ensure API can only be accessed by the specified HTTP verbs. All other HTTP
  verbs should be disabled (e.g. `HEAD`).
* APIs expecting to be accessed from browser-based clients (e.g., WebApp
  front-end) should implement a proper Cross-Origin Resource Sharing (CORS)
  policy.

## References

### OWASP

* [OWASP Secure Headers Project][1]
* [OWASP Testing Guide: Configuration Management][2]
* [OWASP Testing Guide: Testing for Error Codes][3]
* [OWASP Testing Guide: Test Cross Origin Resource Sharing][9]

### External

* [CWE-2: Environmental Security Flaws][4]
* [CWE-16: Configuration][5]
* [CWE-388: Error Handling][6]
* [Guide to General Server Security][7], NIST
* [Let’s Encrypt: a free, automated, and open Certificate Authority][8]

[1]: https://www.owasp.org/index.php/OWASP_Secure_Headers_Project
[2]: https://www.owasp.org/index.php/Testing_for_configuration_management
[3]: https://www.owasp.org/index.php/Testing_for_Error_Code_(OTG-ERR-001)
[4]: https://cwe.mitre.org/data/definitions/2.html
[5]: https://cwe.mitre.org/data/definitions/16.html
[6]: https://cwe.mitre.org/data/definitions/388.html
[7]: https://csrc.nist.gov/publications/detail/sp/800-123/final
[8]: https://letsencrypt.org/
[9]: https://www.owasp.org/index.php/Test_Cross_Origin_Resource_Sharing_(OTG-CLIENT-007)
