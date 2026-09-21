# API सुरक्षा जोखिम

जोखिम विश्लेषण करने के लिए [OWASP जोखिम रेटिंग कार्यप्रणाली (OWASP Risk Rating
Methodology)][1] का उपयोग किया गया।

नीचे दी गई तालिका जोखिम स्कोर से जुड़ी शब्दावली का सारांश देती है।

| खतरे के कारक | शोषण क्षमता | कमज़ोरी की व्यापकता | कमज़ोरी की पहचान क्षमता | तकनीकी प्रभाव | व्यावसायिक प्रभाव |
| :-: | :-: | :-: | :-: | :-: | :-: |
| API-विशिष्ट | आसान: **3** | व्यापक **3** | आसान **3** | गंभीर **3** | व्यवसाय-विशिष्ट |
| API-विशिष्ट | औसत: **2** | सामान्य **2** | औसत **2** | मध्यम **2** | व्यवसाय-विशिष्ट |
| API-विशिष्ट | कठिन: **1** | कठिन **1** | कठिन **1** | मामूली **1** | व्यवसाय-विशिष्ट |

**ध्यान दें (Note)**: यह तरीका खतरे के कारक की संभावना (likelihood) को ध्यान
में नहीं रखता। न ही यह आपके किसी विशेष एप्लिकेशन से जुड़े विभिन्न तकनीकी
विवरणों को ध्यान में रखता है। इनमें से कोई भी कारक किसी हमलावर द्वारा किसी विशेष
भेद्यता को खोजने और उसका शोषण करने की कुल संभावना को काफ़ी प्रभावित कर सकता है।
यह रेटिंग आपके व्यवसाय पर पड़ने वाले वास्तविक प्रभाव को ध्यान में नहीं रखती।
आपके संगठन को यह तय करना होगा कि अपनी संस्कृति, उद्योग और नियामक परिवेश को
देखते हुए वह एप्लिकेशन और API से जुड़ा कितना सुरक्षा जोखिम उठाने को
तैयार है। OWASP API Security Top 10 का उद्देश्य आपके लिए यह जोखिम विश्लेषण करना
नहीं है। चूँकि यह संस्करण डेटा-संचालित (data-driven) नहीं है, इसलिए व्यापकता के
परिणाम टीम के सदस्यों की आपसी सहमति पर आधारित हैं।

## संदर्भ

### OWASP

* [OWASP जोखिम रेटिंग कार्यप्रणाली (OWASP Risk Rating Methodology)][1]
* [खतरा/जोखिम मॉडलिंग पर लेख (Article on Threat/Risk Modeling)][2]

### बाहरी

* [ISO 31000: जोखिम प्रबंधन मानक (Risk Management Std)][3]
* [ISO 27001: ISMS][4]
* [NIST Cyber Framework (US)][5]
* [ASD Strategic Mitigations (AU)][6]
* [NIST CVSS 3.0][7]
* [Microsoft थ्रेट मॉडलिंग टूल (Microsoft Threat Modeling Tool)][8]

[1]: https://owasp.org/www-project-risk-assessment-framework/
[2]: https://owasp.org/www-community/Threat_Modeling
[3]: https://www.iso.org/iso-31000-risk-management.html
[4]: https://www.iso.org/isoiec-27001-information-security.html
[5]: https://www.nist.gov/cyberframework
[6]: https://www.asd.gov.au/infosec/mitigationstrategies.htm
[7]: https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator
[8]: https://www.microsoft.com/en-us/download/details.aspx?id=49168
