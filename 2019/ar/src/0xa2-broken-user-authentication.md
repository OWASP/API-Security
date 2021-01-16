<h2 dir='rtl' align='right'> API2:2019 خلل في صلاحيات المستخدم </h2>

<table dir='rtl' align="right">
  <tr>
    <th>عوامل التهديد/ الاستغلال  </th>
    <th> نقاط الضعف </th>
    <th> التأثير </th>
    <tr>
    <td> خصائص API : قابلية الاستغلال: 3 </td>
    <td> الانتشار : 2 قابلية الاكتشاف : 2  </td>
    <td> التأثر التقني و تأثر الاعمال: 3 </td>
  </tr> 
     <td> المصادقة في واجهات برمجة التطبيقات API هي آلية معقدة وصعبة الفهم وقد يكون لدى مهندسي البرمجيات ومهندس امن المعلومات بعض المفاهيم الخاطئة حول حدود المصادقة وكيفية تنفيذها بشكل صحيح. بالإضافة إلى ذلك، تعد آلية المصادقة هدفًا سهلاً للمهاجمين ، نظرًا لأنها متاحة للجميع. تجعل هاتان النقطتان مكون المصادقة عرضة للعديد من عمليات الاستغلال. </td>
    <td> هناك مسألتان فرعيتان: 1. محدودية آليات الحماية: يجب التعامل مع مصادر البيانات الخاصة بواجهات برمجة التطبيقات API والمسؤولة عن المصادقة بشكل مختلف عن المصادر الاخرى وتأمين طبقات إضافية من الحماية 2. سوء تنفيذ الآلية: يتم استخدام / تنفيذ الآلية دون مراعاة طرق الاستغلال الهجوم، أو أنها تبني بشكل غير صحيح (على سبيل المثال، قد لا تتناسب آلية المصادقة المصممة لأجهزة إنترنت الأشياء مع لتطبيقات الويب). </td>
    <td> يمكن للمهاجمين التحكم في حسابات المستخدمين الآخرين في النظام ، وقراءة بياناتهم الشخصية ، وتنفيذ إجراءات حساسة نيابة عنهم ، مثل المعاملات المالية وإرسال الرسائل الشخصية. </td>    
  </tr>
  </table>      

<h3 dir='rtl' align='right'>هل أنا معرض لهذه الثغرة؟</h3>
<p dir='rtl' align='right'>مصادر البيانات وآلية عملها والاصول الخاصة بها تحتاج إلى الحماية. حيث يجب معاملة "نسيت كلمة المرور / إعادة تعيين كلمة المرور" بنفس طريقة آليات المصادقة.
    
<p dir='rtl' align='right'> يكون API معرض للخطر اذا كان: 
<p dir='rtl' align='right'> ▪️ اذا كان لدى المهاجم قائمة متكاملة من اسماء المستخدمين وكلمات المرور تم الحصول عليها من اختراق او تسريب سابق
<p dir='rtl' align='right'> ▪️ عند قيام المهاجم بهجمات كسر كلمة المرور وعدم استخدام آلية تحقق اخرى من المستخدم مثل Captcha.
<p dir='rtl' align='right'> ▪️ كلمات المرور الضعيفة
<p dir='rtl' align='right'> ▪️ ارسال المعلومات الحساسة او كلمات المرور من خلال URL.
<p dir='rtl' align='right'> ▪️ عدم التحقق بالشكل الصحيح من عمليات المصادقة
<p dir='rtl' align='right'> ▪️ الموافقة على استخدام المصادقة الغير موقعه او الموقع بشكل غير امن ("alg":"none") او عدم التحقق من تاريخ انتهاء المصادقة.
<p dir='rtl' align='right'> ▪️ استخدام البيانات غير المشفرة في عمليات تسجيل الدخول او عدم حفظ الارقام السرية بشكل مشفر
<p dir='rtl' align='right'> ▪️ استخدام مفاتيح تشفير ضعيفة.


<h3 dir='rtl' align='right'> امثلة على سيناريوهات الهجوم: </h3>

<h4 dir='rtl' align='right'>السيناريو الاول: </h4>

<p dir='rtl' align='right'> في حال قام المهاجم باستخدام بمحاولة الدخول بحسابات متعددة والتي تم الحصول عليها من تسريب للبيانات والتي يجب ان نقوم بوضع آلية للحماية من هجمات الدخول المتعدد بحسابات صحيح في وقت قصير ومحدود.

<h4 dir='rtl' align='right'>السيناريو الثاني : </h4>

<p dir='rtl' align='right'>في حال قام المهاجم بمحاولة استعاد كلمة المرور من خلال ارسال طلب POST الى `/api/system/verification-codes` وذلك باستخدام اسم المستخدم فقط لتحقق من استعادة كلمة المرور. حيث يقوم التطبيق بإرسال رسالة نصية لهاتف الضحية مع آلية المصادقة الجديدة والمكونة من 6 ارقام. وحيث ان API لم يقم بوضع حد اعلى لطلبات المصادقة سيقوم المهاجم بتنفيذ جميع الاحتماليات وذلك بالتخمين على آلية المصادقة التي تم ارسالها الى هاتف الضحية وذلك بإرسال طلبات متعددة الى `/api/system/verification-codes/{smsToken}` لتحقق من مصدر البيانات في حال كان احد عمليات التخمين كانت صحيحة.
    

<h4 dir='rtl' align='right'>كيف أمنع هذه الثغرة؟ </h4>

* Make sure you know all the possible flows to authenticate to the API (mobile/
  web/deep links that implement one-click authentication/etc.)
* Ask your engineers what flows you missed.
* Read about your authentication mechanisms. Make sure you understand what and
  how they are used. OAuth is not authentication, and neither is API keys.
* Don't reinvent the wheel in authentication, token generation, password
  storage. Use the standards.
* Credential recovery/forget password endpoints should be treated as login
  endpoints in terms of brute force, rate limiting, and lockout protections.
* Use the [OWASP Authentication Cheatsheet][3].
* Where possible, implement multi-factor authentication.
* Implement anti brute force mechanisms to mitigate credential stuffing,
  dictionary attack, and brute force attacks on your authentication endpoints.
  This mechanism should be stricter than the regular rate limiting mechanism on
  your API.
* Implement [account lockout][4] / captcha mechanism to prevent brute force
  against specific users. Implement weak-password checks.
* API keys should not be used for user authentication, but for [client app/
  project authentication][5].

## References

### OWASP

* [OWASP Key Management Cheat Sheet][6]
* [OWASP Authentication Cheatsheet][3]
* [Credential Stuffing][1]

### External

* [CWE-798: Use of Hard-coded Credentials][7]

[1]: https://www.owasp.org/index.php/Credential_stuffing
[2]: https://github.com/danielmiessler/SecLists
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
[4]: https://www.owasp.org/index.php/Testing_for_Weak_lock_out_mechanism_(OTG-AUTHN-003)
[5]: https://cloud.google.com/endpoints/docs/openapi/when-why-api-key
[6]: https://www.owasp.org/index.php/Key_Management_Cheat_Sheet
[7]: https://cwe.mitre.org/data/definitions/798.html
