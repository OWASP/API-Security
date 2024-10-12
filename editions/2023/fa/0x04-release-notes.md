
<div dir="rtl" align='right'>

RN یادداشت
========

مستند پیش رو دومین ویراست ده ‌‌آسیب‌پذیری بحرانی امنیت API می‌باشد که دقیقاً چهار سال پس از نسخه اول آن منتشر شده است. در طول این چهار سال، تغییرات زیادی در زمینه امنیت API رخ داده است. از جمله این تغییرات می‌توان به موارد زیر اشاره کرد: افزایش چشمگیر تعداد تراکنش‌ها و ارتباطات صورت گرفته از طریق APIها، رشد بیشتر پروتکل‌های API، شرکت‌ها و راه‌حل‌های جدید در حوزه API و توسعه مهارت‌ها و تکنیک‌های جدید توسط مهاجمان برای نفوذ به APIها. با توجه به این موارد، وقت آن رسیده بود که لیست ده آسیب‌پذیری برتر امنیتی به‌روز شود.
با رشد و بهبود در صنعت امنیت API، برای نخستین بار، درخواستی عمومی برای جمع‌آوری داده در این زمینه ‌صورت گرفت. متأسفانه هیچ داده‌ای توسط افراد ارائه نشده، اما بر اساس تجربیات تیم پروژه، بازبینی دقیق از سوی متخصصان امنیت API و دریافت بازخورد از جامعه تخصصی در مورد نسخه آزمایشی، لیست جدیدی ایجاد شده است. برای آشنایی بیشتر با نحوه آماده سازی این مستند می‌توانید به بخش متدولوژی و داده مراجعه نمایید. همچنین جزئیات ریسک‌های امنیتی مرتبط در بخش ریسک‌‌‌های امنیتی API قابل مطالعه هستند.
OWASP API Security Top 10 2023 مستندی آگاهی‌بخش است که آینده صنعت امنیت API را مورد توجه قرار می‌دهد. این مستند به دلیل تغییرات و تحولات سریع در امنیت منتشر شده و هدف آن ارتقاء آگاهی از ریسک‌های امنیتی مرتبط با API است. مستند حاضر، جایگزینی برای دیگر لیست‌های TOP 10 OWASP محسوب نمی‌شود. در این ویرایش به تعدادی از ریسک‌های مهم امنیتی مرتبط با API پرداخته شده که عبارتند از:
•	دو مورد "افشای مفرط داده[1]* " و "تخصیص جمعی[2]* " با یکدیگر تلفیق شده‌اند و تمرکز بیشتری بر روی عامل مشترک آن‌ها، یعنی نقض اعتبارسنجی مجوز در سطح ویژگی‌های شیء[3]*  گذاشته‌ایم.
•	در برخی موارد به جای اهمیت دادن به مدیریت موثر منابع و کنترل آنها تا زمان اتمام، فقط به مصرف فعلی منابع توجه می‌کنیم. 
•	با ایجاد دسته‌بندی جدیدی به نام "دسترسی بدون ‌محدودیت به جریان‌های حساس کسب‌وکار"، بر دسته جدیدی از تهدیدات تمرکز کردیم. این تهدیدات معمولاً با استفاده از محدود کردن نرخ دسترسی به جریان‌های حساس مرتبط، کاهش پیدا می‌کنند. این اقدام به ارتقاء امنیت در مقابل این تهدیدات کمک خواهد کرد.
•	عنصر "استفاده ناایمن از APIها" را به لیست اضافه کرده‌ایم تا به رفتار جدیدی که اخیراً مشاهده شده، توجه داشته باشیم. موضوع نام برده شده، به این اشاره دارد که مهاجمان به جای حمله مستقیم به APIهای هدف، به دنبال نقاط ضعف در خدمات متکامل هدف می‌گردند تا از طریق آن‌ها به هدف خود نفوذ کنند. این مسئله به مرور زمان افزایش یافته و اکنون زمان مناسبی است تا به جامعه درباره این خطر در حال افزایش، اطلاع‌رسانی شود.
فهم تغییرات اساسی در معماری اپلیکیشن‌ها در سالیان گذشته از اهمیت زیادی برخوردار است. امروره APIها نقشی کلیدی در معماری ریزسرویس‌ها[4]* ، اپلیکیشن‌های تک صفحه ای (SPA )[5]*، اپلیکیشن‌های موبایل، اینترنت اشیاء و ... دارند.
پروژه حاضر، حاصل تلاش فوق‌العاده داوطلبانه افراد متعددی بوده که بدون آن‌ها، به سرانجام رساندن آن امکان‌پذیر نبود که در بخش تقدیر و تشکر، از آن‌ها نام برده شده است. متشکریم!

[1]: Excessive Data Exposure
[2]: Mass Assignment
[3]: object property level authorization validation failures
[4]: Microservices
[5]: Single Page Application

</div>