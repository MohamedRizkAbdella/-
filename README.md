# حسابات مزرعتي | My Farm Accounts

نواة أولية لتطبيق محاسبي وإداري لمزارع النخيل، تعمل على Android وWeb باستخدام Flutter.

## التشغيل

```bash
flutter pub get
flutter run -d chrome       # Web
flutter run                 # Android / emulator
flutter test
```

## ما تم بناؤه في هذه النسخة

- لوحة تحكم متجاوبة مع قائمة تنقل جانبية/سفلية.
- دعم العربية والإنجليزية مع RTL/LTR من داخل التطبيق.
- شاشة الإيرادات والمصروفات مع إضافة وتعديل وحذف وبحث وتصنيف.
- بطاقات مؤشرات مالية، حركة حديثة، ومخطط مبسط بدون اعتماد على مكتبة رسوم خارجية.
- نماذج المجال الأساسية ونقطة واضحة لاستبدال التخزين المؤقت بقاعدة بيانات.

## الخطة المعمارية المقترحة

- **Presentation:** Flutter + Material 3، شاشات responsive، وطبقة ترجمة قابلة للتوسع.
- **State:** Provider/ChangeNotifier حالياً؛ يمكن نقلها إلى Riverpod عند توسع الفريق.
- **Domain:** نماذج مستقلة (`FarmTransaction`) وخدمات حالات الاستخدام.
- **Data:** REST API بـ NestJS/Node.js أو Supabase/Firebase. يفضل PostgreSQL للقيود والتقارير المحاسبية.
- **Offline-first:** Drift/SQLite محلياً مع طابور مزامنة، ورفع المرفقات إلى S3/Firebase Storage.
- **Security:** JWT + refresh tokens، RBAC (مالك/محاسب/مدخل بيانات)، تشفير النسخ الاحتياطية، وتدقيق Audit Log.
- **Integrations:** Firebase Cloud Messaging، موفر WhatsApp/SMS رسمي، Google Drive OAuth، وكاميرا الجهاز عبر plugin موثوق.
- **Reports:** خدمة تقارير تعيد بيانات مجمعة، ثم PDF/طباعة من Flutter مع صلاحيات لكل حساب.

## خارطة الطريق

1. ربط `FarmStore` بقاعدة بيانات ومصادقة حقيقية.
2. إضافة الموظفين، الحضور، السلف، المخزون والصوبة الزراعية.
3. المرفقات والكاميرا والمزامنة offline-first.
4. التقارير PDF، الإشعارات، سجل التدقيق، والاختبارات الآلية.

حقوق التصميم والتطوير: مهندس / محمد رزق عبداللا — 01126201133
