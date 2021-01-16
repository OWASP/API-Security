<h2 dir='rtl' align='right'> API9:2019 خلل في ادارة الاصول </h2>

<table dir='rtl' align="right">
  <tr>
    <th>عوامل التهديد/ الاستغلال  </th>
    <th> نقاط الضعف </th>
    <th> التأثير </th>
    <tr>
    <td> خصائص API : قابلية الاستغلال </td>
    <td> الانتشار : 3 قابلية الاكتشاف : 2  </td>
    <td> التأثر التقني و تأثر الاعمال: 2 </td>
  </tr> 
     <td> ان استخدام واجهة برمجة التطبيقات القديمة و الغير محدثة هو اسهل طريقة تسبب اختراق الأنظمة لديك دون الحاجة والجهد الذي قد يبذلها المهاجم حتى وان كانت أدوات ومكونات الأمان تم ايجادها بشكل صحيح وسليم، ولكن جميع تلك الأدوات والمكونات وجدت للأنظمة الحديثة و المتطورة من واجهة برمجة التطبيقات API.</td>
    <td> ان عمليات التوثيق الغير محدثة تجعل من الصعب تتبع واصلاح الثغرات. وكذلك عدم جرد الأصول التقنية يؤدي بشكل مباشر الى عدم ترقيع الأنظمة من الثغرات الأمنية، والذي قد يؤدي الى تسريب للبيانات. وكما انه من الشائع رصد واجهة برمجة التطبيقات API متاحة على الانترنت دون الحاجة لها بسبب الأنظمة والمفاهيم الحديثة في الخدمات المصفرة والتي تجعل من التطبيقات سهلة النشر ومستقلة على سبيل المثال (الحوسبة السحابية) </td>
    <td> قد يتمكن المهاجمون من الوصول الى بيانات حساسة غير مصرح لهم بالوصول لها، او حتى اختراق الخادم من خلال استغلال احد الثغرات الغير مرقعه لخدمات واجهة برمجة التطبيقات API والتي تستخدم للاتصال بقاعدة البيانات. </td>    
  </tr>
  </table>        


<h3 dir='rtl' align='right'>هل أنا معرض لهذه الثغرة؟</h3>

<p dir='rtl' align='right'> قد يكون معرض واجهة برمجة التطبيقات لمثل هذه الثغره في حالة : 

<p dir='rtl' align='right'>▪️ الغرض من استخدام واجهة برمجة التطبيقات غير واضح والذي قد يقود للأسئلة التالية: 
<p dir='rtl' align='right'> -  ما هي البيئة التي تعمل فيها واجهة برمجة التطبيقات (على سبيل المثال ، الإنتاج ، التدريج ، الاختبار ، التطوير)؟
<p dir='rtl' align='right'> - من المخول للوصول الى الشبكة الخاصة بواجهة برمجة التطبيقات (على سبيل المثال ، عام ، داخلي ، شركاء)؟
<p dir='rtl' align='right'> - ما هو إصدار API  المستخدم ؟ 
<p dir='rtl' align='right'> - ماهي البيانات التي يتم جمعها بواسطة API؟ وهل هي بيانات شخصية؟
<p dir='rtl' align='right'> - ماهي آلية وسير العمليات ؟
<p dir='rtl' align='right'>▪️ لا توجد وثائق معتمدة او وثائق قديمة وغير محدثة.  
<p dir='rtl' align='right'>▪️ لا توجد خطة لإيقاف أي واجهة برمجة التطبيقات القديمة API
<p dir='rtl' align='right'>▪️ لا توجد آلية لحصر الأصول او انها قديمة.
<p dir='rtl' align='right'>▪️ لا توجد آلية لحصر الأصول المتصلة بالأنظمة سوء كانت طرف اول او طرف ثالث.
<p dir='rtl' align='right'>▪️ إصدارات قديمة وغير محدثة ولا تزال مستخدمة
<p dir='rtl' align='right'>▪️ 
    

<h3 dir='rtl' align='right'> امثلة على سيناريوهات الهجوم: </h3>

<h4 dir='rtl' align='right'>السيناريو الاول: </h4>

<p dir='rtl' align='right'> 

After redesigning their applications, a local search service left an old API
version (`api.someservice.com/v1`) running, unprotected, and with access to the
user database. While targeting one of the latest released applications, an
attacker found the API address (`api.someservice.com/v2`). Replacing `v2` with
`v1` in the URL gave the attacker access to the old, unprotected API,
exposing the personal identifiable information (PII) of over 100 Million users.

### Scenario #2

A social network implemented a rate-limiting mechanism that blocks attackers
from using brute-force to guess reset password tokens. This mechanism wasn’t
implemented as part of the API code itself, but in a separate component between
the client and the official API (`www.socialnetwork.com`).
A researcher found a beta API host (`www.mbasic.beta.socialnetwork.com`) that
runs the same API, including the reset password mechanism, but the rate limiting
mechanism was not in place. The researcher was able to reset the password of any
user by using a simple brute-force to guess the 6 digits token.

## How To Prevent

* Inventory all API hosts and document important aspects of each one of them,
  focusing on the API environment (e.g., production, staging, test,
  development), who should have network access to the host (e.g., public,
  internal, partners) and the API version.
* Inventory integrated services and document important aspects such as their
  role in the system, what data is exchanged (data flow), and its sensitivity.
* Document all aspects of your API such as authentication, errors, redirects,
  rate limiting, cross-origin resource sharing (CORS) policy and endpoints,
  including their parameters, requests, and responses.
* Generate documentation automatically by adopting open standards. Include the
  documentation build in your CI/CD pipeline.
* Make API documentation available to those authorized to use the API.
* Use external protection measures such as API security firewalls for all exposed versions of your APIs, not just for the current production version.
* Avoid using production data with non-production API deployments. If this is unavoidable, these endpoints should get the same security treatment as the production ones.
* When newer versions of APIs include security improvements, perform risk analysis to make the decision of the mitigation actions required for the older version: for example, whether it is possible to backport the improvements without breaking API compatibility or you need to take the older version out quickly and force all clients to move to the latest version.

## References

### External

* [CWE-1059: Incomplete Documentation][1]
* [OpenAPI Initiative][2]

[1]: https://cwe.mitre.org/data/definitions/1059.html
[2]: https://www.openapis.org/
