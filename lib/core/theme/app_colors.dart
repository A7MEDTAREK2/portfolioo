import 'package:flutter/material.dart';

class ColorConstants {
  // الألوان الأساسية (درجات الكحلي والأزرق العميق للخلفيات والبطاقات)
  static const Color darkNavy = Color(0xFF0B132B);      // كحلي غامق جداً وفخم للخلفية الرئيسية
  static const Color secondaryNavy = Color(0xFF1C2541); // كحلي متوسط للبطاقات والـ Sections
  static const Color primary = Color(0xFF3A86EF);       // أزرق ساطع ومميز للعناوين والأزرار البارزة
  static const Color primaryHover = Color(0xFF4361EE);  // درجة أزرق عند الـ Hover

  static const Color lightBlue = Color(0xFF48CAE4);     // أزرق فاتح هادئ للتفاصيل البسيطة

  // الألوان الثابتة (الأبيض للعناصر والزرارير حسب طلبك)
  static const Color background = Color(0xFF0B132B);    // الخلفية العامة للموقع
  static const Color surface = Color(0xFF1C2541);       // خلفية الكروت (Cards)
  static const Color textWhite = Color(0xFFFFFFFF);     // نصوص بيضاء صريحة للوضوح التام
  static const Color textGray = Color(0xFF8D99AE);      // نصوص رمادية هادئة للوصف

  static const Color border = Color(0xFF2B3A67);        // حدود هادئة ومتناسقة مع الكحلي
  static const Color success = Color(0xFF2EC4B6);       // أخضر هادئ للنجاح أو المتاح للعمل
  static const Color error = Color(0xFFEF476F);         // أحمر هادئ للـ Errors

  // تدرجات لونية (Gradients) فخمة متناسقة مع الكحلي والأزرق
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF3A86EF), Color(0xFF4361EE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF0B132B), Color(0xFF1C2541), Color(0xFF3A86EF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}