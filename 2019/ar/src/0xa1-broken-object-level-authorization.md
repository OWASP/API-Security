<h2 dir='rtl' align='right'>API1:2019 خلل التفاويض والصلاحيات </h2>


<table dir='rtl' align="right">
  <tr>
    <th>التهديد / اسلوب الهجوم  </th>
    <th> نقاط الضعف </th>
    <th> التأثير </th>
    <tr>
    <td> تحديد API : قابلية الاستغلال </td>
    <td> الانتشار : 3 قابلية الاكتشاف : 2  </td>
    <td> التأثر التقني و تأثر الاعمال: 3 </td>
  </tr> 
     <td> يستطيع المهاجم استغلال نقاط الضعف في مصادر البيانات Endpoint المتأثرة بخلل في الصلاحيات من خلال التلاعب او التغير بالمعرف الفريد عند ارسال الطلبات. قد يؤدي كذلك الى الوصول غير المصرح به الى البيانات الحساسة. وتعتبر خلل تفويض الصلاحيات مشكلة شائعة جداً في التطبيقات بسبب عدم إمكانية الخوادم من تتبع العمليات التي يقوم بها المستخدم بشكل كامل. وحيث انه يعتمد بشكل كامل على إيصال كل معرف فريد لمصدر البيانات الذي يطلب منه. </td>
    <td> يعتبر هذا الهجوم هو الأكثر شيوعاً على واجهات برمجة التطبيقات API. حيث ان استخدام مثل هذه الاليات شائعة جداً في التطبيقات الحديثة وواسعة الانتشار. حتى وان كانت صلاحيات الوصول في البنية التحتية للتطبيق مبنيه بشكل سليم، فقد ينسى المطورون استخدام تلك الصلاحيات في الوصول الى البيانات الحساسة وقد لا يتم اكتشاف نقاط الضعف المبنية على خلل صلاحيات الوصول من خلال عمليات المسح للبحث عن الثغرات بشكل آلي.  </td>
    <td> يمكن أن يؤدي الوصول غير المصرح به إلى الكشف عن البيانات لأطراف غير مصرح لها أو فقدان البيانات أو التلاعب بها وكذلك يمكن أن يؤدي الوصول غير المصرح به إلى إلى الاستيلاء الكامل على الحساب. </td>    
  </tr>
  </table>        

<h3 dir='rtl' align='right'> هل واجهة برمجة التطبيقات (API) مصابة ؟</h3>

<p dir='rtl' align='right'> ان عمليات إدارة صلاحيات الوصول والتحكم بها عادة يبنى من خلال كتابة الاكواد البرمجية في المقام الأول  بشكل سليم بحيث يستطيع المستخدم الوصول الى البيانات المسموح له بالوصول لها.
ان جميع مصادر البيانات الخاصة بـ API لها معرف وكائن وصلاحيات خاص ومرتبطة بها، وعند وجود أي اجراء على تلك المصادر او الكائنات يجب ان يتم استخدام تلك التصاريح. حيث يتم التحقق من صلاحيات المستخدم الذي قام بعملية تسجيل الدخول ومعرفة إذا كان لدية حق الوصول لأجراء او استعراض او تعديل البيانات. وعادة ما يؤدي الفشل في التحقق من هذه الالية الى الكشف والتعديل عن معلومات وبيانات الغير مصرح به.


<h3 dir='rtl' align='right'> امثلة على سيناريوهات الهجوم: </h3>

<h4 dir='rtl' align='right'>السيناريو الاول: </h4>

<p dir='rtl' align='right'>
توفر منصة التجارة الالكترونية مواقع عبر الانترنت (عبارة عن متاجر الالكترونية) خدمة مصادر الربح الخاصة بالمتاجر المستضاف على المنصة، حيث يستطيع المهاجم من خلال عرض مصدر الصفحة معرفة API الذي قام بجلب تلك المعلومات ومعرفة مصدرها على سبيل المثال : `/shops/{shopName}/revenue_data.json`  ومن خلال تلك الطريقة يستطيع المهاجم من الحصول على بيانات الربح لجميع المتاجر المتسضافة في المنصة من خلال  تغير {shopName} في عنوان URL بطريقة غير مصرح بها.
    
### Scenario #2

While monitoring the network traffic of a wearable device, the following HTTP
`PATCH` request gets the attention of an attacker due to the presence of a
custom HTTP request header `X-User-Id: 54796`. Replacing the `X-User-Id` value
with `54795`, the attacker receives a successful HTTP response, and is able to
modify other users' account data.

## How To Prevent

* Implement a proper authorization mechanism that relies on the user policies
  and hierarchy.
* Use an authorization mechanism to check if the logged-in user has access to
  perform the requested action on the record in every function that uses an
  input from the client to access a record in the database.
* Prefer to use random and unpredictable values as GUIDs for records’ IDs.
* Write tests to evaluate the authorization mechanism. Do not deploy vulnerable
  changes that break the tests.

## References

### External

* [CWE-284: Improper Access Control][1]
* [CWE-285: Improper Authorization][2]
* [CWE-639: Authorization Bypass Through User-Controlled Key][3]

[1]: https://cwe.mitre.org/data/definitions/284.html
[2]: https://cwe.mitre.org/data/definitions/285.html
[3]: https://cwe.mitre.org/data/definitions/639.html
