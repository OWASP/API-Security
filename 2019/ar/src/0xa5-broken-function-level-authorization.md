<h2 dir='rtl' align='right'> API5:2019 ضعف في التحقق من الهوية وادارة الصلاحيات و التفويض </h2>

<table dir='rtl' align="right">
  <tr>
    <th>عوامل التهديد/ الاستغلال  </th>
    <th> نقاط الضعف </th>
    <th> التأثير </th>
    <tr>
    <td> خصائص API : قابلية الاستغلال </td>
    <td> الانتشار : 2 قابلية الاكتشاف : 1  </td>
    <td> التأثر التقني و تأثر الاعمال: 2 </td>
  </tr> 
     <td> ان عملية استغلال هذه الثغرة بسيط نسيباً بحيث يستطيع المهاجم ارسال طلب غير ضار من خلال واجهة برمجة التطبيقات API الى مصادر البيانات التي من الغير مصرح له بالاطلاع عليها. وقد تكون تلك المصادر متاحة للمسخدمين المجهولين او المستخدم الذي لا يملك صلاحيات عالية. وحيث ان من السهل اكتشاف مثل تلك الثغرات من خلال معرفة سلوك الطلبات والياتها المستخدمة وطرق طلبها والردود المتوقعة من كل طلب وقد يتم استغلالها ببساطة من خلال استبدال طلب GET  بـ PUT او تغير صلاحيات المستخدم من "User " الى "Admin".   </td>
    <td> عادة ما يتم تحديد صلاحيات الوصول للموارد من خلال الاعدادات. وفي بعض الأحيان على مستوى الاكواد البرمجية، ان عملية تنصيب طرق التحقق بالشكل الصحيح قد تكون في بعض الأحيان عملية معقدة. حيث ان معظم التطبيقات الحديثة تحتوي على مختلف الصلاحيات والمجموعات بتسلسل هرمي معقد بعض الشي. </td>
    <td> بعض آليات العمل قد تسمح للمهاجم في الاستفادة والوصول والاطلاع الغير مصرح به، او حصوله على صلاحيات إدارية تمكنه من التحكم والسيطرة. </td>    
  </tr>
  </table>    


<h3 dir='rtl' align='right'>هل أنا معرض لهذه الثغرة؟</h3>

<p dir='rtl' align='right'> أفضل طريقة للعثور على مشكلات وخلل تفويض مستوى الصلاحيات والمصادقة هي إجراء تحليل عميق لآلية التفويض ، مع مراعاة التسلسل الهرمي للمستخدم ، والأدوار أو المجموعات المختلفة في التطبيق ، وطرح الأسئلة التالية:
    
<p dir='rtl' align='right'>▪️ هل يستطيع المستخدم العادي الوصول الى مصادر صلاحيات المدراء ؟
<p dir='rtl' align='right'>▪️ هل يستطيع المستخدم التعديل او التعين او المسح لمصادر البيانات عند تغير طريقة الطلب للبروتوكول على سبيل المثال من GET الى DELETE ؟
<p dir='rtl' align='right'>▪️  هل يستطيع المستخدم في مجموعة أ من الوصول الى مصادر المجموعة ب من خلال تخمين مصدر تلك المجموعة /api/v1/users/export_all 

<p dir='rtl' align='right'> لا تقم بوضع وتقسيم الصلاحيات ما بين الصلاحيات المعتادة والصلاحيات الادارية من خلال مسار URL.
<p dir='rtl' align='right'>و من الشائع لدى المطورين عرض مصادر البيانات الإدارية ضمن مسار محدد مثل API/Admin ومن الشائع كذلك استخدام مصادر واحدة للمستخدم العادي وكذلك للمدراء مثل api/users.
    
    
<p dir='rtl' align='right'>▪️
<p dir='rtl' align='right'>▪️
<p dir='rtl' align='right'>▪️


<h3 dir='rtl' align='right'> امثلة على سيناريوهات الهجوم: </h3>

<h4 dir='rtl' align='right'>السيناريو الاول: </h4>

<p dir='rtl' align='right'> يقوم التطبيق فقط بالسماح للمستخدمين المدعوين بالتسجيل، حيث يقوم التطبيق بطلب API الخاص من خلال طلب GET  على سبيل المثال المسار التالي " /api/invites/{invite_guid}" ويأتي الرد من الخادم والذي يحتوي على ملف JSON مع تفاصيل الدعوة، وكذلك تفاصيل المستخدمين و الصلاحيات والبريد الالكتروني.

<p dir='rtl' align='right'> يقوم المهاجم بتكرار الطلبات ومحاولة التلاعب والتعديل في طريقة الطلب من مصدر البيانات  من GET  الى POST  مع المسار التالي " /api/invites/new" حيث ان هذا المسار مسموح بالوصول له فقط لأصحاب الصلاحيات الإدارية بواسطة صفحة الإدارة والتي من الوضح عدم تطبيق مستوى المصادقة والتفويض على مستوى الصلاحية.

<p dir='rtl' align='right'> المهاجم قام باستغلال الخطأ من خلال ارسال طلب دعوة لنفسة ومن ثم قام بإنشاء حساب بصلاحيات مرتفعة.

```
POST /api/invites/new

{“email”:”hugo@malicious.com”,”role”:”admin”}
```

<h4 dir='rtl' align='right'>السيناريو الثاني : </h4>

<p dir='rtl' align='right'>

An API contains an endpoint that should be exposed only to administrators -
`GET /api/admin/v1/users/all`. This endpoint returns the details of all the
users of the application and does not implement function-level authorization
checks. An attacker who learned the API structure takes an educated guess and
manages to access this endpoint, which exposes sensitive details of the users of
the application.

## How To Prevent

Your application should have a consistent and easy to analyze authorization
module that is invoked from all your business functions. Frequently, such
protection is provided by one or more components external to the application
code.

* The enforcement mechanism(s) should deny all access by default, requiring
  explicit grants to specific roles for access to every function.
* Review your API endpoints against function level authorization flaws, while
  keeping in mind the business logic of the application and groups hierarchy.
* Make sure that all of your administrative controllers inherit from an
  administrative abstract controller that implements authorization checks based
  on the user’s group/role.
* Make sure that administrative functions inside a regular controller implements
  authorization checks based on the user’s group and role.

## References

### OWASP

* [OWASP Article on Forced Browsing][1]
* [OWASP Top 10 2013-A7-Missing Function Level Access Control][2]
* [OWASP Development Guide: Chapter on Authorization][3]

### External

* [CWE-285: Improper Authorization][4]

[1]: https://www.owasp.org/index.php/Forced_browsing
[2]: https://www.owasp.org/index.php/Top_10_2013-A7-Missing_Function_Level_Access_Control
[3]: https://www.owasp.org/index.php/Category:Access_Control
[4]: https://cwe.mitre.org/data/definitions/285.html
