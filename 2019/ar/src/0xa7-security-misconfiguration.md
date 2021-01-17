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
     <td> يحاول المهاجمون غالباً البحث عن الثغرات الأمنية على مستوى الأنظمة او اليات العمل اول على مصادر بيانات غير محمية وذلك بغاية الوصول الغير مصرح به للمعلومات. </td>
    <td> يمكن ان يحدث الاعداد الخاطئ في أي مستوى من مستويات واجهة برمجة التطبيقات API، ابتداءًا من مستوى الشبكة الى مستوى التطبيقات، حيث تتوفر الأدوات للقيام بالفحص واكتشاف الأخطاء بشكل آلي وذلك بهدف البحث عن مواطن الإعدادات الخاطئة او الخدمات الفعالة والغير ضرورية او الخيارات القديمة والمصابة بثغرات. </td>
    <td> قد يؤدي عملية الإعدادات الخاطئة الى تسريب البيانات وكذلك اختراق الأنظمة والخوادم. </td>    
  </tr>
  </table>

<h3 dir='rtl' align='right'>هل أنا معرض لهذه الثغرة؟</h3>

<p dir='rtl' align='right'> قد يكون واجهة التطبيقات API معرضة لثغرات في حال :

<p dir='rtl' align='right'>▪️ اذا لم يكن هناك أي آلية متبعة لعملية تعزيز حماية النظام في جميع مراحله او اذا كان هناك تهيئة غير صحيحة على الخدمات السحابية.
<p dir='rtl' align='right'>▪️ اذا لم يكن هناك آلية لسد الثغرات الأمنية او في حال كانت الأنظمة المستخدمة غير محدثة او خارجة عن الخدمة.
<p dir='rtl' align='right'>▪️ اذا كان هناك تفعيل لبعض الطلبات الغير مطلوبة مثل بعض طلبات HTTP الغير مستخدمة TREAC او DELETE على سبيل المثال.
<p dir='rtl' align='right'>▪️  اذا لم يتم استخدام التشفير بواسطة TLS. 
<p dir='rtl' align='right'>▪️ إذا لم يتم تعين سياسة مشاركة المواد بطريقة صحيحة او كان هناك خطا في الإعدادات الخاصة بها
<p dir='rtl' align='right'>▪️ إذا كانت رسائل الخطأ تحتوي على معلومات حساسة ويمكن تتبعها.   


<h3 dir='rtl' align='right'> امثلة على سيناريوهات الهجوم: </h3>

<h4 dir='rtl' align='right'>السيناريو الاول: </h4>

<p dir='rtl' align='right'> يعثر المهاجم على ملف .bash_history في احد المسارات الرئيسية في الخادم والذي يحتوي على الأوامر التي يستخدمها المطورين في الوصول الى واجهة برمجية التطبيقات API.

```
$ curl -X GET 'https://api.server/endpoint/' -H 'authorization: Basic Zm9vOmJhcg=='
```
<p dir='rtl' align='right'> يمكن للمهاجم ايضاً معرفة مصادر البيانات من خلال الأوامر التي يستخدمها المطورين من خلال تكرار عملية الوصول للملف أعلاه وما حدث ذلك الا بسبب عدم توثيق الإجراءات بالشكل الصحيح.

    
<h4 dir='rtl' align='right'>السيناريو الثاني : </h4>

<p dir='rtl' align='right'> يقوم المهاجمون في معظم الأحيان باستخدام محركات البحث بهدف الحصول على خوادم يستطيع من خلالها الوصول الى مصدر البيانات بشكل مباشر. او من خلال البحث عن أحد المنافذ المشهورة في قواعد البيانات او في إدارة الأنظمة والخوادم.  وفي حال كان الخادم او النظام المستهدف يقوم باستخدام الأعدادت الافتراضية وغير محمي باستخدام مصادقة صحيحة قد يمكن المهاجم من الوصول للبيانات الشخصية PII والذي قد يؤدي الى تسريب بيانات المستخدمين لتلك الخدمة.

<h4 dir='rtl' align='right'>السيناريو الثالث  : </h4>

<p dir='rtl' align='right'> عند اعتراض حركة المرور للبيانات الخاصة بأحد تطبيقات الهواتف المحمولة والتي تستخدم بروتوكول TLS  في حركة البيانات ولكن  لا تعتمد على التشفير باستخدام TLS  عند استخدام واجهة برمجة التطبيقات API وبعد البحث من قبل المهاجم استطاع معرفة ان عملية تحميل ورفع الصور يتم بشكل غير مشفر، فقد وجد المهاجم نمط وطريقة لمعرفة الاستجابة الواردة من قبل الخادم او من قبل مصدر البيانات والتي قد تمكنه بطريقة او بأخرى من تتبع تفضيلات المستخدمين عند تنزيل او عرض تلك الصور.


<h4 dir='rtl' align='right'>كيف أمنع هذه الثغرة؟ </h4>

<p dir='rtl' align='right'> دورة حياة واجهة برمجة التطبيقات API لابد ان تشتمل على : 

<p dir='rtl' align='right'>▪️ عملية تعزيز حماية الأنظمة تساهم بشكل كبير في بناء بيئة امنة و موثوقة 
<p dir='rtl' align='right'>▪️ إيجاد آلية لمراجعة الإعدادات و التحديثات بأكملها ويجب ان تتضمن مراجعة كل من ملفات الحفظ و المزامنة مكونات واجهة برمجة التطبيقات API و الخدمات السحابية.
<p dir='rtl' align='right'>▪️ توفير اتصال امن و مشفر لجميع الاتصالات في التعامل مع التطبيق او رفع وتحميل الصور.
<p dir='rtl' align='right'>▪️ عملية تقييم امني مستمر لمعرفة مستوى نضج الاعدادات في جميع انحاء البنية التحتية.

<p dir='rtl' align='right'> علاوة على ذلك: 

<p dir='rtl' align='right'>▪️ لمنع تتبع الأخطاء التي قد يتم الرد بها بعد عمليات الطلب والتي قد تمكن المهاجم من استعراض البيانات الحساسة يجب ان تكون جميع الردود محدودة ومحصورة بما في ذلك عمليات الاستجابة للأخطاء.
<p dir='rtl' align='right'>▪️ تأكد انه لا يمكن الوصول الى واجهة برمجة التطبيقات API الا من خلال احد الطلبات المحددة وعدم السماح بجميع الطلبات الخاصة ببروتوكول HTTP بالعمل بل ويجب تعطيلها مثال (HEAD , TRACE).
<p dir='rtl' align='right'>▪️ يجب على واجهات برمجة التطبيقات API التي تتوقع أن يتم الوصول إليها من عملاء يستندون إلى المتصفح على سبيل المثال (الواجهة الامامية لخدمات الويب) يجب تنفيذ سياسة سليمة وموثوقة لمشاركة الموارد عبر (CORS).
    

<h4 dir='rtl' align='right'>المراجع :  </h4>

[<p dir='rtl' align='right'>▪️ OWASP Secure Headers Project </p>](https://www.owasp.org/index.php/OWASP_Secure_Headers_Project)
[<p dir='rtl' align='right'>▪️ OWASP Testing Guide: Configuration Management </p>](https://www.owasp.org/index.php/Testing_for_configuration_management)
[<p dir='rtl' align='right'>▪️ OWASP Testing Guide: Testing for Error Codes </p>](https://www.owasp.org/index.php/Testing_for_Error_Code_(OTG-ERR-001))
[<p dir='rtl' align='right'>▪️ OWASP Testing Guide: Test Cross Origin Resource Sharing</p>](https://www.owasp.org/index.php/Test_Cross_Origin_Resource_Sharing_(OTG-CLIENT-007))

<h4 dir='rtl' align='right'>المصادر الخارجية :   </h4>


[<p dir='rtl' align='right'>▪️ CWE-2: Environmental Security Flaws </p>]( https://cwe.mitre.org/data/definitions/2.html)
[<p dir='rtl' align='right'>▪️ CWE-16: Configuration </p>](https://cwe.mitre.org/data/definitions/16.html)
[<p dir='rtl' align='right'>▪️ CWE-388: Error Handling </p>](https://cwe.mitre.org/data/definitions/388.html)
[<p dir='rtl' align='right'>▪️ Guide to General Server Security , NIST </p>]( https://csrc.nist.gov/publications/detail/sp/800-123/final)
[<p dir='rtl' align='right'>▪️ Let’s Encrypt: a free, automated, and open Certificate Authority </p>](https://letsencrypt.org/)
