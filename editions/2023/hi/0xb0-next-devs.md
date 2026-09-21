# डेवलपर्स के लिए आगे क्या

सुरक्षित एप्लिकेशन बनाना और बनाए रखना, या मौजूदा एप्लिकेशन को सुधारना, कठिन
हो सकता है। APIs के लिए भी यही बात लागू होती है।

हम मानते हैं कि सुरक्षित सॉफ़्टवेयर लिखने के लिए शिक्षा और जागरूकता प्रमुख
कारक हैं। बाकी सब कुछ **दोहराने योग्य सुरक्षा प्रक्रियाओं और मानक सुरक्षा
नियंत्रणों को अपनाने और उनका पालन करने** पर निर्भर करता है।

OWASP सुरक्षा को मज़बूत बनाने में मदद के लिए कई मुफ़्त और ओपन-सोर्स
संसाधन उपलब्ध कराता है। उपलब्ध प्रोजेक्ट्स की विस्तृत सूची के लिए कृपया [OWASP Projects पेज][1]
देखें।

| | |
|-|-|
| **शिक्षा (Education)** | [Application Security Wayfinder][2] आपको सॉफ़्टवेयर डेवलपमेंट लाइफ़साइकिल (Software Development LifeCycle, SDLC) के प्रत्येक चरण/फ़ेज़ के लिए उपलब्ध प्रोजेक्ट्स का अच्छा अंदाज़ा देगा। हाथों-हाथ सीखने/प्रशिक्षण के लिए आप [OWASP **crAPI** - **C**ompletely **R**idiculous **API**][3] या [OWASP Juice Shop][4] से शुरू कर सकते हैं: दोनों में जानबूझकर भेद्य (vulnerable) API हैं। [OWASP Vulnerable Web Applications Directory Project][5] जानबूझकर भेद्य एप्लिकेशन की एक चुनी हुई सूची प्रदान करता है: वहाँ आपको कई अन्य भेद्य API मिलेंगे। आप [OWASP AppSec Conference][6] के प्रशिक्षण सत्रों में भी भाग ले सकते हैं, या [अपने स्थानीय चैप्टर से जुड़ सकते हैं][7]। |
| **सुरक्षा आवश्यकताएँ (Security Requirements)** | सुरक्षा शुरू से ही हर प्रोजेक्ट का हिस्सा होनी चाहिए। आवश्यकताएँ परिभाषित करते समय यह तय करना ज़रूरी है कि उस प्रोजेक्ट के लिए "सुरक्षित" का क्या अर्थ है। OWASP सुझाव देता है कि आप सुरक्षा आवश्यकताएँ निर्धारित करने के लिए [OWASP Application Security Verification Standard (ASVS)][8] को मार्गदर्शिका के रूप में उपयोग करें। यदि आप आउटसोर्स कर रहे हैं, तो [OWASP Secure Software Contract Annex][9] पर विचार करें, जिसे स्थानीय कानून और नियमों के अनुसार अनुकूलित किया जाना चाहिए। |
| **सुरक्षा आर्किटेक्चर (Security Architecture)** | प्रोजेक्ट के सभी चरणों में सुरक्षा एक चिंता का विषय बनी रहनी चाहिए। [OWASP Cheat Sheet Series][10] आर्किटेक्चर चरण के दौरान सुरक्षा को डिज़ाइन में शामिल करने के तरीके पर मार्गदर्शन के लिए एक अच्छा प्रारंभिक बिंदु है। कई अन्य के अलावा, आपको [REST Security Cheat Sheet][11] और [REST Assessment Cheat Sheet][12] तथा [GraphQL Cheat Sheet][13] भी मिलेंगे। |
| **मानक सुरक्षा नियंत्रण (Standard Security Controls)** | मानक सुरक्षा नियंत्रण अपनाने से अपना कोड लिखते समय सुरक्षा कमज़ोरियाँ आने का जोखिम कम हो जाता है। हालाँकि कई आधुनिक फ़्रेमवर्क अब प्रभावी बिल्ट-इन मानक नियंत्रणों के साथ आते हैं, [OWASP Proactive Controls][14] आपको इस बात का अच्छा अवलोकन देता है कि आपको अपने प्रोजेक्ट में कौन से सुरक्षा नियंत्रण शामिल करने चाहिए। OWASP कुछ लाइब्रेरी और टूल भी प्रदान करता है जो आपको उपयोगी लग सकते हैं, जैसे सत्यापन नियंत्रण। |
| **सुरक्षित सॉफ़्टवेयर डेवलपमेंट लाइफ़साइकिल (Secure Software Development Life Cycle)** | API बनाने की प्रक्रियाओं को बेहतर बनाने के लिए आप [OWASP Software Assurance Maturity Model (SAMM)][15] का उपयोग कर सकते हैं। API विकास के विभिन्न चरणों के दौरान आपकी मदद के लिए कई अन्य OWASP प्रोजेक्ट उपलब्ध हैं, जैसे [OWASP Code Review Guide][16]। |

[1]: https://owasp.org/projects/
[2]: https://owasp.org/projects/#owasp-projects-the-sdlc-and-the-security-wayfinder
[3]: https://owasp.org/www-project-crapi/
[4]: https://owasp.org/www-project-juice-shop/
[5]: https://owasp.org/www-project-vulnerable-web-applications-directory/
[6]: https://owasp.org/events/
[7]: https://owasp.org/chapters/
[8]: https://owasp.org/www-project-application-security-verification-standard/
[9]: https://owasp.org/www-community/OWASP_Secure_Software_Contract_Annex
[10]: https://cheatsheetseries.owasp.org/
[11]: https://cheatsheetseries.owasp.org/cheatsheets/REST_Security_Cheat_Sheet.html
[12]: https://cheatsheetseries.owasp.org/cheatsheets/REST_Assessment_Cheat_Sheet.html
[13]: https://cheatsheetseries.owasp.org/cheatsheets/GraphQL_Cheat_Sheet.html
[14]: https://owasp.org/www-project-proactive-controls/
[15]: https://owasp.org/www-project-samm/
[16]: https://owasp.org/www-project-code-review-guide/
