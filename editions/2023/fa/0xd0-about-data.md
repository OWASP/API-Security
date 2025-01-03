#  متدلوژی و داده

## بررسی اجمالی  
در تهیه این فهرست، تیم امنیت OWASP API از روش مشابهی که برای ایجاد لیست مشهور و پرطرفدار سال 2019 با موفقیت به کار رفته بود، استفاده کرده است. این روش شامل بررسی امنیت API ها و شناسایی مشکلات امنیتی آنها می‌باشد. علاوه بر روش اصلی، [فراخوانی عمومی][1]  به مدت سه ماه برای جمع‌آوری داده‌ هم اعلام شد. متأسفانه، داده‌های به دست آمده از فراخوان، امکان تجزیه و تحلیل معتبر آماری از مشکلات امنیتی رایج در APIها را نداشتند. با این حال، فرآیند به‌روزرسانی با استفاده از همان روش متداول ادامه یافت.  
امیدواریم به‌روزرسانی فعلی، که یک سند آگاهی‌دهنده و متمرکز بر مسائل مربوط به APIهای مدرن است برای استفاده تا سه الی چهار سال آینده مناسب باشد. هدف اصلی این پروژه این ارائه جایگزینی برای top 10 API نبوده و تمرکز آن بر مسائل مرتبط با امنیت API و ریسک‌های آینده در این زمینه است و به عنوان یک ابزار آموزشی و آگاهی‌دهنده عمل می‌کند تا صنعت به بهترین نحو ممکن از این موارد آگاه شده و اقدامات لازم را برای حفاظت از امنیت اطلاعات صورت پذیرد.

## متدلوژی   
در فاز اول، داده‌‌های در دسترس عموم در حوزه رخداد‌‌های مرتبط با امنیت API توسط گروهی از متخصصین امنیت جمع آوری، بازبینی و دسته بندی شدند. این داده‌‌ها از پلتفرم‌‌های شکار باگ و پایگاه‌‌های داده به منظور تحلیل آماری جمع آوری شده اند. این داده‌ها در بازه زمانی بین 2019 تا 2022 گزارش شده بودند و هدف از این جمع‌آوری آن‌ها، تکامل لیست 10 API پیشین برای سال‌های آینده و کمک به مدیریت داده‌های ارائه شده توسط افراد مختلف بود. به این ترتیب، تیم امنیت OWASP API توانست از تجربیات و داده‌های موجود به‌ شکل معقولی در تدوین لیست جدید امنیتی از مشکلات API استفاده کند.

 [فراخوانی عمومی][1] از سپتامبر تا آخر نوامبر 2022،  برای جمع‌آوری داده آغاز شد که هم‌زمان با آن، تیم پروژه به بررسی تغییراتی که از سال 2019 به وقوع پیوسته بود، پرداخت. این بررسی شامل ارزیابی تأثیر لیست امنیتی اول، بازخوردهای دریافتی از جامعه و مشاهده تغییرات و روندهای جدید در حوزه امنیت API بود. با انجام این فراخوان، داده‌ها و بازخوردهای تازه‌ای از افراد مختلف و جامعه امنیتی جمع‌آوری شد تا تیم پروژه با آگاهی از تغییرات اخیر در امنیت API، آن‌ها را در لیست جدید مسائل امنیتی مد نظر قرار دهد.  
این تلاش منجر به تهیه نسخه اولیه‌ای از ده ریسک‌ بحرانی امنیتی API شد. [روش ارزیابی ریسک OWASP][2] در تجزیه و تحلیل داده‌ها و ارائه نسخه اولیه مورد استفاده قرار گرفت. امتیازات میزان شیوع براساس توافق میان اعضای تیم پروژه و براساس تجربه‌ آن‌ها در این حوزه تعیین شدند. برای اطلاعات بیشتر در این خصوص، به بخش مرتبط با [ریسک‌های امنیتی API][3] مراجعه فرمایید.  
نسخه اولیه تهیه شده، با افراد متخصص در زمینه امنیت API به اشتراک گذاشته شد. نظرات ارائه‌شده، بررسی، بحث و در صورت نیاز به سند اضافه شدند. سند نهایی به عنوان [نسخه نهایی برای بحث عمومی][4] منتشر شد تا [مورد بحث][5] قرار گیرد و تعدادی از [نظرات و مشارکت‌های][6] ارائه‌شده از جامعه به سند نهایی اضافه گردید. در نهایت، با همکاری افراد متخصص و جامعه لیست نهایی مشکلات امنیتی API تدوین گردید.  
لیست مشارکت کنندگان در بخش [سپاسگزاری ها][7] قابل مشاهده است.

## ریسک‌های مختص API

لیست حاضر، به منظور پرداختن به مخاطرات امنیتی API‌ها ایجاد شده و از آن برای برطرف کردن چالش‌های امنیتی خاص API‌ها استفاده می‌شود. این لیست به تهدیدات عمومی امنیتی که در تمام برنامه‌های کاربردی وب و نرم‌افزارها وجود دارند، توجهی نمی‌کند و هدف اصلی آن، افزایش آگاهی از تهدیدات در زمینه API‌ها و راهکارهای مورد نیاز آن‌هاست.

[1]: https://owasp.org/www-project-api-security/announcements/cfd/2022/
[2]: https://www.owasp.org/index.php/OWASP_Risk_Rating_Methodology
[3]: ./0x10-api-security-risks.md
[4]: https://owasp.org/www-project-api-security/announcements/2023/02/api-top10-2023rc
[5]: https://github.com/OWASP/API-Security/issues?q=is%3Aissue+label%3A2023RC
[6]: https://github.com/OWASP/API-Security/pulls?q=is%3Apr+label%3A2023RC
[7]: ./0xd1-acknowledgments.md
