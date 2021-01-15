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


## Is the API Vulnerable?

Object level authorization is an access control mechanism that is usually
implemented at the code level to validate that one user can only access objects
that they should have access to.

Every API endpoint that receives an ID of an object, and performs any type of
action on the object, should implement object level authorization checks. The
checks should validate that the logged-in user does have access to perform the
requested action on the requested object.

Failures in this mechanism typically leads to unauthorized information
disclosure, modification, or destruction of all data.

## Example Attack Scenarios

### Scenario #1

An e-commerce platform for online stores (shops) provides a listing page with
the revenue charts for their hosted shops. Inspecting the browser requests, an
attacker can identify the API endpoints used as a data source for those charts
and their pattern `/shops/{shopName}/revenue_data.json`. Using another API
endpoint, the attacker can get the list of all hosted shop names. With a simple
script to manipulate the names in the list, replacing `{shopName}` in the URL,
the attacker gains access to the sales data of thousands of e-commerce stores.

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
