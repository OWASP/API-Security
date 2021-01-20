<h2 dir='rtl' align='right'>مخاطر برمجة واجهة التطبيقات</h2> 

[<p dir='rtl' align='right'>▪️ تم استخدام نموذج تقييم المخاطر الخاص بـ OWASP وذلك بهدف تحليل المخاطر  </p> ](0x03-introduction.md) </p>  

<p dir='rtl' align='right'>يلخص الجدول أدناه المصطلحات المرتبطة بدرجة المخاطر: </p>   

<table dir='rtl' align="right">  
  <tr>
    <th>عوامل التهديد </th>
    <th> الاستغلال </th>
    <th> نقاط الضعف الأمنية  </th>
    <th> اكتشاف الضعف الأمني </th>
    <th> التأثيرات التقنية </th>
    <th> التأثيرات على العمل </th>
  </tr> 
  <tr>    
    <td> خصائص API  </td> 
    <td> بسيط  3 </td> 
    <td> منتشرة 3 </td> 
    <td> بسيط  3 </td> 
    <td> حرج  3 </td> 
    <td> تحديد الأعمال </td>
  </tr>  
  <tr>
    <td> خصائص API </td> 
    <td> متوسط  2 </td> 
    <td> عام  2 </td> 
    <td> متوسط  2 </td> 
    <td> متوسط  2  </td> 
    <td> تحديد الأعمال </td> 
  </tr>  
  <tr>
    <td> خصائص API </td> 
    <td> صعب  1 </td> 
    <td> صعب  1 </td> 
    <td> صعب  1 </td> 
    <td> منخفض </td> 
    <td> تحديد الأعمال </td> 
   </tr>
</table>  
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>

<h4 dir='rtl' align='right'>ملاحظة:</h4>

<p dir='rtl' align='right'> هذا النهج لا يأخذ في الاعتبار احتمال وجود عامل التهديد، كما أنه لا يأخذ في الحسبان أيًا من التفاصيل الفنية المختلفة المرتبطة بتطبيقك. يمكن لأي من هذه العوامل أن تؤثر بشكل كبير على الاحتمالية الإجمالية للمهاجم للعثور على ثغرة أمنية معينة واستغلالها. لا يأخذ هذا التصنيف في الاعتبار التأثير الفعلي على عملك، سيتعين على مؤسستك تحديد مقدار المخاطر الأمنية من التطبيقات وواجهات برمجة التطبيقات التي ترغب المؤسسة في قبولها في ضوء بيئتك التنظيمية. الغرض من OWASP API Security Top 10 ليس القيام بتحليل المخاطر هذا نيابة عنك.


<h4 dir='rtl' align='right'>المراجع</h4>

<p dir='rtl' align='right'>▪️ [OWASP Risk Rating Methodology][1]
<p dir='rtl' align='right'>▪️ [Article on Threat/Risk Modeling][2]

<h4 dir='rtl' align='right'>الروابط الخارجية</h4>

<p dir='rtl' align='right'>▪️ [ISO 31000: Risk Management Std][3]
<p dir='rtl' align='right'>▪️ [ISO 27001: ISMS][4]
<p dir='rtl' align='right'>▪️ [NIST Cyber Framework (US)][5]
<p dir='rtl' align='right'>▪️ [ASD Strategic Mitigations (AU)][6]
<p dir='rtl' align='right'>▪️ [NIST CVSS 3.0][7]
<p dir='rtl' align='right'>▪️ [Microsoft Threat Modeling Tool][8]

[1]: https://www.owasp.org/index.php/OWASP_Risk_Rating_Methodology
[2]: https://www.owasp.org/index.php/Threat_Risk_Modeling
[3]: https://www.iso.org/iso-31000-risk-management.html
[4]: https://www.iso.org/isoiec-27001-information-security.html
[5]: https://www.nist.gov/cyberframework
[6]: https://www.asd.gov.au/infosec/mitigationstrategies.htm
[7]: https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator
[8]: https://www.microsoft.com/en-us/download/details.aspx?id=49168

