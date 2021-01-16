<h2 dir='rtl' align='right'> API8:2019 الحقن </h2>


<table dir='rtl' align="right">
  <tr>
    <th>عوامل التهديد/ الاستغلال  </th>
    <th> نقاط الضعف </th>
    <th> التأثير </th>
    <tr>
    <td> خصائص API : قابلية الاستغلال 3 </td>
    <td> الانتشار : 2 قابلية الاكتشاف : 3  </td>
    <td> التأثر التقني و تأثر الاعمال: 3 </td>
  </tr> 
    <td>يقوم المهاجمون بإرسال بيانات ضارة من خلال واجهة برمجة التطبيقاتAPI  وذلك بهدف حقنها وارسالها الى المفسر ومن صور طرق ادخل البيانات ( الادخال المباشر، التعليمات البرمجية، طرق ربط الخدمات ..الخ) متوقعين ارسالها الى المفسر. </td>
    <td>  تعد أساليب الحقن أسلوب شائع لدى المهاجمين وغالباً ما توجد استعلامات جاهزة لمختلف أنواع اللغات SQL,LDAP,NoSQL ,OS Command ,XML parsers. حيث انه من السهل الكشف عن الثغرات عند قراءة الشفرة المصدرية للاكواد البرمجية باستخدامات عمليات المسح الالية او اليدوية.</td>
    <td>  يمكن ان يؤدي الحقن الى الكشف عن المعلومات الغير مصرح به او مسح وفقدان البيانات وفي بعض الأحيان قد يودي الى هجمات حجب الخدمة DOS، او اختراق الكامل لنظام.</td>    
  </tr>
  </table>        

<h3 dir='rtl' align='right'>هل أنا معرض لهذه الثغرة؟</h3>

<p dir='rtl' align='right'> قد يكون واجهة برمجة التطبيقات API معرض للاستغلال بمثل هذه الهجمات عند : 

<p dir='rtl' align='right'>▪️  لا يتم تصفية البيانات او التحقق منها في حال كانت مقدمة من المستخدمين من طريق واجهة برمجة التطبيقات
<p dir='rtl' align='right'>▪️ يتم استخدام البيانات بشكل مباشر مع SQL/NoSQL/LDAP queries, OS commands, XML parsers.
<p dir='rtl' align='right'>▪️ لا يتم التحقق من صحة البيانات الواردة من أنظمة خارجية مثل (الأنظمة المرتبطة بالخادم) او تصفيتها او التحقق منها  قبل واجهة برمجة التطبيقات API قبل عملية استخدامها 
    
<h3 dir='rtl' align='right'> امثلة على سيناريوهات الهجوم: </h3>

<h4 dir='rtl' align='right'>السيناريو الاول: </h4>

<p dir='rtl' align='right'> يتم استخدام الكاميرات للمراقبة في المنازل مصدر بيانات للإعدادات في المسار التالي /api/CONFIG/restore و من المتوقع ان يتم استقبال معرف فريد في أجزاء متعددة، فباستخدام برنامج فك وتحويل الشفرات البرمجية(decompile)، تمكن المهاجم من إيجاد طريقة لتعامل مع النظام بشكل مباشر ومن غير عوامل التصفية المقترحة.

```c
snprintf(cmd, 128, "%srestore_backup.sh /tmp/postfile.bin %s %d",
         "/mnt/shares/usr/bin/scripts/", appid, 66);
system(cmd);
```

<p dir='rtl' align='right'> يسمح الامر التالي للمهاجم بإغلاق أي جهاز مصاب بتلك الثغرة البرمجية

```
$ curl -k "https://${deviceIP}:4567/api/CONFIG/restore" -F 'appid=$(/etc/pod/power_down.sh)'
```

<h4 dir='rtl' align='right'>السيناريو الثاني : </h4>


<p dir='rtl' align='right'> تطبيق للحجوزات قائم على وظائف CRUD، حيث قام المهاجم بالعديد من محاولات الفحص التي مكنته من معرفة اللغة المستخدمة في المفسر وهي NoSQL والتي استطاع من خلالها حقن المعرف الفريد للحجوزات bookingid باوامر من اجل مسح وحذف الحجوزات من خلال استخدام المسار التالي: DELETE /api/bookings?bookingId=678

<p dir='rtl' align='right'> حيث قام المهاجم بإرسال الطلب من خلال واجهة برمجة التطبيقات API لتعامل مع طلب الحذف الامر التالي:
    
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

<p dir='rtl' align='right'> قام المهاجم باعتراض الطلبات الخاصة بالمعرف الفريد bookinigid  وقام بتغير طريقة الاستعلام والتي أدت الى حذف حجز مستخدم اخر. 

```
DELETE /api/bookings?bookingId[$ne]=678
```

<h4 dir='rtl' align='right'>كيف أمنع هذه الثغرة؟ </h4>

<p dir='rtl' align='right'> لمنع عمليات الحقن انت بحاجة الى فصل الأوامر والتعليمات البرمجية عن الاستعلامات بشكل صحيح و امن.

<p dir='rtl' align='right'>▪️ قم بإجراء التحقق من صحة البيانات المدخلة باستخدام مكتبة موحدة وامنه وموثوقة  ويتم صيانتها بشكل دوري.
<p dir='rtl' align='right'>▪️ التحقق من صحة جميع البيانات المقدمة من المستخدم أو غيرها من البيانات الواردة من الأنظمة المتكاملة وتصفيتها.
<p dir='rtl' align='right'>▪️ يجب تخطي الأحرف الخاصة باستخدام الصيغة المحددة المفسر المستهدف.
<p dir='rtl' align='right'>▪️ قم بتوفير بيئة امنه لواجهة برمجة التطبيقات API ذات استعلامات واضحة.
<p dir='rtl' align='right'>▪️ حدد دائمًا عدد السجلات التي يتم إرجاعها لمنع تسريب البيانات للجميع في حالة نجاح عملية الحقن.
<p dir='rtl' align='right'>▪️ تحقق من صحة البيانات الواردة باستخدام عوامل تصفية كافية للسماح فقط بالقيم الصالحة لكل استعلام تم إدخاله.
<p dir='rtl' align='right'>▪️ تعريف بشكل واضح ومحدد ماهي الانماط و انواع البيانات المستخدمة في الاستعلامات 
## References

<h4 dir='rtl' align='right'>المراجع :  </h4>

<h4 dir='rtl' align='right'>المصادر الخارجية :   </h4>

[<p dir='rtl' align='right'>▪️ OWASP Injection Flaws  </p>](https://www.owasp.org/index.php/Injection_Flaws)
[<p dir='rtl' align='right'>▪️ SQL Injection </p>](https://www.owasp.org/index.php/SQL_Injection)
[<p dir='rtl' align='right'>▪️ NoSQL Injection Fun with Objects and Arrays </p>](https://www.owasp.org/images/e/ed/GOD16-NOSQL.pdf)
[<p dir='rtl' align='right'>▪️ Command Injection </p>]( https://www.owasp.org/index.php/Command_Injection)

[<p dir='rtl' align='right'>▪️ CWE-77: Command Injection </p>](https://cwe.mitre.org/data/definitions/77.html)
[<p dir='rtl' align='right'>▪️ CWE-89: SQL Injection </p>](https://cwe.mitre.org/data/definitions/89.html)
