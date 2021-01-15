<h2 dir='rtl' align='right'>مخاطر برمجة واجهة التطبيقات</h2>


The [OWASP Risk Rating Methodology][1] was used to do the risk analysis.
[<p dir='rtl' align='right'>▪️ تم استخدام نموذج تقييم المخاطر الخاص بـ OWASP وذلك بهدف تحليل المخاطر  </p>](0x03-introduction.md)

<p dir='rtl' align='right'>يلخص الجدول أدناه المصطلحات المرتبطة بدرجة المخاطر. 
 
<table dir='rtl' align="right">
  <tr>
    <th>التهديد </th>
    <th> الاستغلال </th>
    <th> نقاط الضعف </th>
    <th> قابلية اكتشاف الضعف </th>
    <th> التأثير التقني </th>
    <th> التأثير على مستوى الاعمال </th>
    <tr>
      <td> تحديد API  </td> 
       <td> بسيط : 3 </td> 
        <td> منتشرة: 3 </td> 
         <td> بسيط : 3 </td> 
         <td> الخادم : 3 </td> 
         <td> تحديد الاعمال </td>
        </tr> 
         <td> تحديد API </td> 
         <td> متوسط : 2 </td> 
         <td> عام : 2 </td> 
         <td> متوسط : 2 </td> 
         <td> متوسط : 2  </td> 
         <td> تحديد الاعمال </td> 
         </tr> 
         <td> صعب : 1 </td> 
         <td> صعب : 1 </td> 
         <td> صعب : 1 </td> 
         <td> صعب : 1 </td> 
         <td> منخفض </td> 
         <td> تحديد الاعمال </td> 
 

**Note**: This approach does not take the likelihood of the threat agent into
account. Nor does it account for any of the various technical details associated
with your particular application. Any of these factors could significantly
affect the overall likelihood of an attacker finding and exploiting a particular
vulnerability. This rating does not take into account the actual impact on your
business. Your organization will have to decide how much security risk from
applications and APIs the organization is willing to accept given your culture,
industry, and regulatory environment. The purpose of the OWASP API Security Top
10 is not to do this risk analysis for you.

## References

### OWASP

* [OWASP Risk Rating Methodology][1]
* [Article on Threat/Risk Modeling][2]

### External

* [ISO 31000: Risk Management Std][3]
* [ISO 27001: ISMS][4]
* [NIST Cyber Framework (US)][5]
* [ASD Strategic Mitigations (AU)][6]
* [NIST CVSS 3.0][7]
* [Microsoft Threat Modeling Tool][8]

[1]: https://www.owasp.org/index.php/OWASP_Risk_Rating_Methodology
[2]: https://www.owasp.org/index.php/Threat_Risk_Modeling
[3]: https://www.iso.org/iso-31000-risk-management.html
[4]: https://www.iso.org/isoiec-27001-information-security.html
[5]: https://www.nist.gov/cyberframework
[6]: https://www.asd.gov.au/infosec/mitigationstrategies.htm
[7]: https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator
[8]: https://www.microsoft.com/en-us/download/details.aspx?id=49168
