<h2 dir='rtl' align='right'> API4:2019 ضعف في البنية التحتية و حد محاولات الطلبات </h2>


<table dir='rtl' align="right">
  <tr>
    <th>عوامل التهديد/ الاستغلال  </th>
    <th> نقاط الضعف </th>
    <th> التأثير </th>
    <tr>
    <td> خصائص API : قابلية الاستغلال </td>
    <td> الانتشار : 3 قابلية الاكتشاف : 3  </td>
    <td> التأثر التقني و تأثر الاعمال: 2 </td>
  </tr> 
     <td> ان عملية الاختراق في بعض الاحيان عملية غير معقدة حيث لا يستلزم الا طلب بسيط للـAPI ومن غير عملية مصادقة كذلك وقد يتم ارسال طلب من خلال جهاز واحد او أجهزة متعددة او أجهزة الخدمات السحابية. </td>
    <td> من الاخطاء الشائعة والمنتشرة هو عدم وضع معدل لطلبات او لم يتم اختيار الموصفات المناسبة عند تنصيب واجهات برمجة التطبيقات API. </td>
    <td> قد يؤدي الاستغلال الى هجمات حجب الخدمة DOS مما يجعل واجهة برمجة التطبيقات API غير مستجيبة او خارج الخدمة. </td>    
  </tr>
  </table> 
  

<h3 dir='rtl' align='right'>هل أنا معرض لهذه الثغرة؟</h3>

<p dir='rtl' align='right'>تستهلك واجهة برمجة التطبيقات API المصادر والأصول من شبكات ووحدات المعالجة وكذلك وسائط التخزين حيث يعتمد بشكل كبير مقدرة تعامل البنية التحتية حسب طلبات ومدخلات المستخدم لمصادر البيانات. وضع في الاعتبار ان طلبات واجهة برمجة التطبيقات API التي تفوق قدرات البنية التحتية تعرضها للخطر بشكل كبير اذا لم يتم تداركها و وضع معدل لمستوى ومحتوى تلك الطلبات ومنها:

<p dir='rtl' align='right'>▪️ مدة حياة الطلب
<p dir='rtl' align='right'>▪️ اعلى حد من استخدام الذاكرة العشوائية لكل طلب
<p dir='rtl' align='right'>▪️ عدد الملفات وطرق وصفها وحفظها وعرضها 
<p dir='rtl' align='right'>▪️  عدد العمليات
<p dir='rtl' align='right'>▪️ عدد وحجم البياتات عند رفعها
<p dir='rtl' align='right'>▪️ عدد الطلبات لكل مستخدم 
<p dir='rtl' align='right'>▪️ عدد الصفحات التي يتم عرضها في كل طلب و استجابة لصفحة الواحدة.


<h3 dir='rtl' align='right'> امثلة على سيناريوهات الهجوم: </h3>

<h4 dir='rtl' align='right'>السيناريو الاول: </h4>
<p dir='rtl' align='right'> يقوم المهاجم برفع صورة كبيرة الحجم والابعاد عن طريق طلب POST  الى `/api/v1/images` وعند اكتمال عملية الرفع يقوم الخادم باستعراض الصور المتبقية على هيئة ايقونات مصغرة بسبب الابعاد والحجم الذي قد يستغرق الموارد وقد يؤدي الى عدم واجهة برمجة التطبيقات API.
    
<h4 dir='rtl' align='right'>السيناريو الثاني : </h4>

<p dir='rtl' align='right'> يقوم التطبيق بعرض المستخدمين بحد اقصى 100 مستخدم في كل صفحة من خلال ارسال طلب الى `/api/users?page=1&size=100`، مما قد يمكن المهاجم من تغير القيمة الى 200000 في عدد أسماء المستخدمين المعروضة في صفحة واحد مما يسبب في حدوث مشكلات في أداة قاعدة البيانات وفي الوقت نفسة تصبح واجهة برمجة التطبيقات غير متاحة وغير قادرة على التعامل مع الطلبات الأخرى ( هجمة حجب الخدمة DOS ) ويمكن استخدام نفس السيناريو لاستعراض الأخطاء او لاستغلال بعض عمليات Integer Overflow  او Buffer Overflow.

<h4 dir='rtl' align='right'>كيف أمنع هذه الثغرة؟ </h4>

<p dir='rtl' align='right'>▪️ يجعل منصة Docker  الامر في غاية البساطة في التحكم في الذاكرة العشوائية او وحدات المعالجة و التخزين 
<p dir='rtl' align='right'>▪️ ضع معدل محدد لعدد الطلبات التي يقوم بطلبها المستخدم خلال اطار زمني معين
<p dir='rtl' align='right'>▪️ اخطار المستخدم عند تجازو المعدل المحدد في الاطار الزمني المعين 
<p dir='rtl' align='right'>▪️ قم باضافة بعض آليات التحقق من جانب الخادم في عمليات الطلبات او حتى التحقق من النصوص او العمليات او الطلبات وتحديداً في تلك العمليات التي تتطلب عدد من السجلات يتم استرجاعها من العميل.
<p dir='rtl' align='right'>▪️ تحديد وفرض الحد الاعلى لحجم وابعاد الطلبات المرفوعة مثل الحد الاقصى لعدد الجمل او الحد الاعلى لعدد الاسطر

<h4 dir='rtl' align='right'>المراجع :  </h4>

[<p dir='rtl' align='right'>▪️ Blocking Brute Force Attacks  </p>](https://www.owasp.org/index.php/Blocking_Brute_Force_Attacks)

[<p dir='rtl' align='right'>▪️ Docker Cheat Sheet - Limit resources (memory, CPU, file descriptors, processes, restarts  </p>](https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/Docker_Security_Cheat_Sheet.md#rule-7---limit-resources-memory-cpu-file-descriptors-processes-restarts)

[<p dir='rtl' align='right'>▪️ REST Assessment Cheat Sheet  </p>](https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/REST_Assessment_Cheat_Sheet.md)

<h4 dir='rtl' align='right'>المصادر الخارجية :   </h4>

[<p dir='rtl' align='right'>▪️ CWE-307: Improper Restriction of Excessive Authentication Attempts  </p>](https://cwe.mitre.org/data/definitions/307.html)

[<p dir='rtl' align='right'>▪️ CWE-770: Allocation of Resources Without Limits or Throttling  </p>](https://cwe.mitre.org/data/definitions/770.html)

[<p dir='rtl' align='right'>▪️ “_Rate Limiting (Throttling)_” - Security Strategies for Microservices-based Application Systems </p>](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-204-draft.pdf)

