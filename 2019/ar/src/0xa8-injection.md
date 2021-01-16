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

### Scenario #2

We have an application with basic CRUD functionality for operations with
bookings. An attacker managed to identify that NoSQL injection might be possible
through `bookingId` query string parameter in the delete booking request. This
is how the request looks like: `DELETE /api/bookings?bookingId=678`.

The API server uses the following function to handle delete requests:

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

<h4 dir='rtl' align='right'>السيناريو الثاني : </h4>

<p dir='rtl' align='right'> تطبيق للحجوزات قائم على وظائف CRUD، حيث قام المهاجم بالعديد من محاولات الفحص التي مكنته من معرفة اللغة المستخدمة في المفسر وهي NoSQL والتي استطاع من خلالها حقن المعرف الفريد للحجوزات bookingid باوامر من اجل مسح وحذف الحجوزات من خلال استخدام المسار التالي: DELETE /api/bookings?bookingId=678
<p dir='rtl' align='right'> حيث قام المهاجم بإرسال الطلب من خلال واجهة برمجة التطبيقات API لتعامل مع طلب الحذف الامر التالي:
    
```
DELETE /api/bookings?bookingId[$ne]=678
```

## How To Prevent

Preventing injection requires keeping data separate from commands and queries.

* Perform data validation using a single, trustworthy, and actively maintained
  library.
* Validate, filter, and sanitize all client-provided data, or other data coming
  from integrated systems.
* Special characters should be escaped using the specific syntax for the target
  interpreter.
* Prefer a safe API that provides a parameterized interface.
* Always limit the number of returned records to prevent mass disclosure in case
  of injection.
* Validate incoming data using sufficient filters to only allow valid values for
  each input parameter.
* Define data types and strict patterns for all string parameters.

## References

### OWASP

* [OWASP Injection Flaws][1]
* [SQL Injection][2]
* [NoSQL Injection Fun with Objects and Arrays][3]
* [Command Injection][4]

### External

* [CWE-77: Command Injection][5]
* [CWE-89: SQL Injection][6]

[1]: https://www.owasp.org/index.php/Injection_Flaws
[2]: https://www.owasp.org/index.php/SQL_Injection
[3]: https://www.owasp.org/images/e/ed/GOD16-NOSQL.pdf
[4]: https://www.owasp.org/index.php/Command_Injection
[5]: https://cwe.mitre.org/data/definitions/77.html
[6]: https://cwe.mitre.org/data/definitions/89.html
