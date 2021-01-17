<h2 dir='rtl' align='right'> API8:2019 الحقن </h2>


<table dir='rtl' align="right">
  <tr>
    <th>عوامل التهديد/ الاستغلال</th>
    <th>نقاط الضعف</th>
    <th>التأثير</th>
  </tr>
  <tr>
    <td>خصائص API : قابلية الاستغلال 3</td>
    <td>الانتشار : 2 قابلية الاكتشاف : 3</td>
    <td>التأثر التقني و تأثر الأعمال: 3</td>
  </tr>
  <tr>
    <td>
    يقوم المهاجمون بإرسال بيانات ضارة من خلال واجهة برمجة التطبيقات API وذلك من خلال حقنها بأي طريقة ممكنة ( مثل الإدخال المباشر و التعليمات البرمجية و طرق ربط الخدمات ...الخ) على أمل إرسالها إلى المفسر.</td>
    <td>تعتبر ثغرات الحقن منشرة وشائعة في استعلامات SQL و LDAP و NoSQL وأوامر أنظمة التشغيل و XML parsers و ORM. واكتشاف هذه الثغرات يعتبر سهل عن مراجعة الشفرة المصدرية. بإمكان المهاجمين استخدام أدوات الفحص.</td>
    <td>يمكن أن يؤدي الحقن إلى إفشاء المعلومات أو مسح وفقدان البيانات. كما يمكن أن يودي إلى حجب الخدمة DoS، أو اختراق كامل للنظام.</td>
  </tr>
</table>

<h3 dir='rtl' align='right'>هل أنا معرض لهذه الثغرة؟</h3>

<p dir='rtl' align='right'>قد تكون واجهة برمجة التطبيقات API معرضة للاستغلال بمثل هذه الهجمات عندما :

<p dir='rtl' align='right'>▪️ لا يتم تصفية البيانات أو التحقق منها في حال كانت مقدمة من المستخدمين من طريق واجهة برمجة التطبيقات.
<p dir='rtl' align='right'>▪️ يتم استخدام البيانات بشكل مباشر مع SQL/NoSQL/LDAP queries, OS commands, XML parsers.
<p dir='rtl' align='right'>▪️ لا يتم التحقق من صحة البيانات الواردة من أنظمة خارجية مثل (الأنظمة المرتبطة بالخادم) أو تصفيتها أو التحقق منها من قبل واجهة برمجة التطبيقات API قبل عملية استخدامها

<h3 dir='rtl' align='right'>أمثلة على سيناريوهات الهجوم:</h3>

<h4 dir='rtl' align='right'>السيناريو الأول:</h4>

<p dir='rtl' align='right'>يقوم نظام جهاز التحكم الأبوي باستخدام المسار <code dir='ltr'>/api/CONFIG/restore</code> والذي يتوقع أن يستقبل معرف التطبيق appId في أجزاء متعددة.
فباستخدام برنامج فك وتحويل الشفرات البرمجية(decompile)، يجد المهاجم أن المعرف appId يتم تمريره مباشرة للنظام ومن غير عوامل التصفية المقترحة:

```c
snprintf(cmd, 128, "%srestore_backup.sh /tmp/postfile.bin %s %d",
         "/mnt/shares/usr/bin/scripts/", appid, 66);
system(cmd);
```

<p dir='rtl' align='right'> يسمح الأمر التالي للمهاجم بإغلاق أي جهاز مصاب بتلك الثغرة البرمجية

```
$ curl -k "https://${deviceIP}:4567/api/CONFIG/restore" -F 'appid=$(/etc/pod/power_down.sh)'
```

<h4 dir='rtl' align='right'>السيناريو الثاني :</h4>


<p dir='rtl' align='right'>لدينا تطبيق قائم على وظائف CRUD للتعامل مع الحجوزات، تمكن مهاجم من التعرف على إمكانية حقن NoSQL  من خلال الاستعلام بالمعرف الفريد للحجوزات <code>bookingId</code> وطلب الحذف بأمر كالتالي: <code dir='ltr'>DELETE /api/bookings?bookingId=678</code>

<p dir='rtl' align='right'>خادم واجهة برمجة التطبيقات (API Server) يستخدم الدالة التالية للتعامل مع طلبات الحذف:

```javascript
router.delete('/bookings', async function (req, res, next) {
  try {
      const deletedBooking = await Bookings.findOneAndRemove({'_id' : req.query.bookingId});
      res.status(200);
  } catch (err) {
     res.status(400).json({error: 'Unexpected error occured while processing a request'});
  }
});
```

<p dir='rtl' align='right'>قام المهاجم باعتراض الطلبات الخاصة بالمعرف الفريد <code>bookingId</code> وقام بتغير أمر الاستعلام كما هو معروض بالأسفل مما أدى إلى حذف حجز يعود لمستخدم آخر:

```
DELETE /api/bookings?bookingId[$ne]=678
```

<h3 dir='rtl' align='right'>كيف أمنع هذه الثغرة؟ </h3>

<p dir='rtl' align='right'> لمنع عمليات الحقن انت بحاجة إلى فصل الأوامر والتعليمات البرمجية عن الاستعلامات بشكل صحيح و امن.

<p dir='rtl' align='right'>▪️ قم بإجراء التحقق من صحة البيانات المدخلة باستخدام مكتبة موحدة وامنه وموثوقة ويتم صيانتها بشكل دوري.
<p dir='rtl' align='right'>▪️ تحقق من صحة جميع البيانات المقدمة من المستخدم أو غيرها من البيانات الواردة من الأنظمة المتكاملة وتصفيتها.
<p dir='rtl' align='right'>▪️ يجب التعامل مع الأحرف والرموز الخاصة باستخدام الصيغة المحددة للمفسر المستهدف.
<p dir='rtl' align='right'>▪️ استخدم واجهة برمجة تطبيقات آمنة (safe API) ذات استعلامات واضحة.
<p dir='rtl' align='right'>▪️ ضع حداً لعدد السجلات التي يتم إرجاعها لمنع تسريب البيانات بشكل كبير في حالة نجاح عملية الحقن.
<p dir='rtl' align='right'>▪️ تحقق من صحة البيانات الواردة باستخدام عوامل تصفية كافية للسماح فقط بالقيم الصالحة لكل استعلام تم إدخاله.
<p dir='rtl' align='right'>▪️ عرف بشكل واضح ومحدد الانماط و أنواع البيانات المستخدمة في الاستعلامات


<h3 dir='rtl' align='right'>المراجع :</h3>

<h4 dir='rtl' align='right'>OWASP :</h4>

[<p dir='rtl' align='right'>▪️ OWASP Injection Flaws</p>](https://www.owasp.org/index.php/Injection_Flaws)
[<p dir='rtl' align='right'>▪️ SQL Injection </p>](https://www.owasp.org/index.php/SQL_Injection)
[<p dir='rtl' align='right'>▪️ NoSQL Injection Fun with Objects and Arrays </p>](https://www.owasp.org/images/e/ed/GOD16-NOSQL.pdf)
[<p dir='rtl' align='right'>▪️ Command Injection </p>]( https://www.owasp.org/index.php/Command_Injection)

<h4 dir='rtl' align='right'>مصادر خارجية :</h4>

[<p dir='rtl' align='right'>▪️ CWE-77: Command Injection </p>](https://cwe.mitre.org/data/definitions/77.html)
[<p dir='rtl' align='right'>▪️ CWE-89: SQL Injection </p>](https://cwe.mitre.org/data/definitions/89.html)
