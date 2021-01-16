<h2 dir='rtl' align='right'>خلل في التعين او التعديل  </h2>

<table dir='rtl' align="right">
  <tr>
    <th>عوامل التهديد/ الاستغلال  </th>
    <th> نقاط الضعف </th>
    <th> التأثير </th>
    <tr>
    <td> خصائص API : قابلية الاستغلال 2 </td>
    <td> الانتشار : 2 قابلية الاكتشاف : 2  </td>
    <td> التأثر التقني و تأثر الاعمال: 2 </td>
  </tr> 
     <td> يتطلب الاستغلال عادةً فهم منطق آلية العمل وعلاقة الكائنات ببعضها وهيكل واجهة برمجة التطبيقات API حيث يعد استغلال الخلل في التعين او التعديل  أسهل في واجهات برمجة التطبيقاتAPI  ، حيث انها في بعض الاحيان عند عرض بعض الخصائص الخاصة بـAPI يقوم كذلك بعرض الإعدادات والخواص الخاصة بها. </td>
    <td> تشجع الاطر الحديثة في البرمجة المطورين على استخدام الطرق الأتوماتيكية التي تسمح للمستخدم بإدخال المتغيرات داخل الكائن. وهذا يسمح للمهاجمين باستخدامها لتحديث بعض المعلومات الحساسة او الكتابة فوق تلك الخصائص او الكائنات التي قام المطورين بإخفائها  </td>
    <td> قد يؤدي هذا الاستغلال الى تصعيد الصلاحيات والتلاعب بالامتيازات وتجاوز آليات الامان وغير ذلك   </td>    
  </tr>
  </table>


<h3 dir='rtl' align='right'>هل أنا معرض لهذه الثغرة؟</h3>

<p dir='rtl' align='right'> تحتوي بعض التطبيقات الحديثة على العديد من الخصائص وبعض تلك الخصائص يجب تحديثها بواسطة المستخدمين على سبيل المثال user.first_name  او  user.addressوبعض الخصائص لا يسمح للمستخدمين بتعديلها على سبيل المثال user.is_vip.

<p dir='rtl' align='right'> تكون واجهة برمجة التطبيقات API ومصادر البيانات عرضة للاختراق اذا تم استخدام مدخلات المستخدم ككائنات داخلية، من دون مراعات لمستوى حساسية وخطورة تلك الكائنات. وها قد يسمح للمهاجم بتحديث خصائص الكائنات التي لا يجب او غير مصرح له بالوصول اليها.

<p dir='rtl' align='right'> امثلة على بعض الخصائص الحساسة: 

<p dir='rtl' align='right'>▪️  التعديل في بعض الخواص: مثل user.is_admin, user.is_vip يجب ان تكون فقط لاصحاب الصلاحيات الإدارية.
<p dir='rtl' align='right'>▪️ الخواص المعتدة على العمليات: مثل user.cash يجب ان يتم التحقق داخلياً بعد التأكد من عملية الدفع.
<p dir='rtl' align='right'>▪️ الخواص الداخلية: على سبيل المثال article.created_time يجب ان يكون داخلياً وبواسطة التطبيق فقط.


<h3 dir='rtl' align='right'> امثلة على سيناريوهات الهجوم: </h3>

<h4 dir='rtl' align='right'>السيناريو الاول: </h4>

<p dir='rtl' align='right'> تطبيق مخصص لرحلات يوفر للمستخدم خيار تعديل البيانات والمعلومات الأساسية للملف الشخصي من خلال ارسال طلب بواسطة برمجة واجهة التطبيقات api التالي /api/v1/users/me بواسطة طلب PUT باستخدامJSON بالشكل التالي: 

```json
{"user_name":"inons","age":24}
```
<p dir='rtl' align='right'> يتضمن الطلب GET للمسار التالي /api/v1/users/me مع خاصية معرفة الرصيد الائتمانية: 

```json
{"user_name":"inons","age":24,"credit_balance":10}.
```

<p dir='rtl' align='right'> حيث قام المهاجم باعتراض الطلب وتغيره الى التالي:   
    
```json
{"user_name":"attacker","age":60,"credit_balance":99999}
```

<p dir='rtl' align='right'> ونظراً لان مصادر البيانات مصابة بخلل في التعيين والتعديل قام المهاجم بالحصول على مبالغ مالية من دون دفع أي مبلغ حقيقي.

<h4 dir='rtl' align='right'>السيناريو الثاني : </h4>

<p dir='rtl' align='right'> تتيح منصة مشاركة ملفات الفيديو تحميل ورفع وتنزيل الملفات بتنسيقات وامتدادات مختلفة. حيث لاحظ المهاجم ان واجهة برمجة التطبيقات والتي تستطيع الوصول لها من خلال طلب GET على المسار التالي /api/v1/videos/{video_id}/meta_data انه يستطيع الحصول على ملف JSON يحتوي على خصائص ملفات الفيديو. على سبيل المثال "mp4_conversion_params":"-v codec h264" مما يوضح ان التطبيق يستخدم أوامر Shell لعملية تحويل الفيديو.
<p dir='rtl' align='right'>    

A video sharing portal allows users to upload content and download content in
different formats. An attacker who explores the API found that the endpoint
`GET /api/v1/videos/{video_id}/meta_data` returns a JSON object with the video’s
properties. One of the properties is `"mp4_conversion_params":"-v codec h264"`,
which indicates that the application uses a shell command to convert the video.

The attacker also found the endpoint `POST /api/v1/videos/new` is vulnerable to
mass assignment and allows the client to set any property of the video object.
The attacker sets a malicious value as follows:
`"mp4_conversion_params":"-v codec h264 && format C:/"`. This value will cause a
shell command injection once the attacker downloads the video as MP4.

## How To Prevent

* If possible, avoid using functions that automatically bind a client’s input
  into code variables or internal objects.
* Whitelist only the properties that should be updated by the client.
* Use built-in features to blacklist properties that should not be accessed by
  clients.
* If applicable, explicitly define and enforce schemas for the input data
  payloads.

## References

### External

* [CWE-915: Improperly Controlled Modification of Dynamically-Determined Object Attributes][1]

[1]: https://cwe.mitre.org/data/definitions/915.html
