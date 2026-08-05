import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart'; // تأكد إن مسار الاستيراد مظبوط حسب مكان الملف عندك

class AppTextStyles {
  AppTextStyles._();

  static final TextStyle heroTitle = GoogleFonts.inter(
    fontSize: 56,
    fontWeight: FontWeight.w800,
    color: ColorConstants.textWhite, // أبيض صريح عشان العنوان الرئيسي يخطف العين
    height: 1.1,
  );

  static final TextStyle heading1 = GoogleFonts.inter(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: ColorConstants.textWhite,
  );

  static final TextStyle heading2 = GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: ColorConstants.textWhite,
  );

  static final TextStyle body = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ColorConstants.textGray, // رمادي هادئ ومريح للعين في قراءة النصوص الطويلة
    height: 1.7,
  );

  static final TextStyle button = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: ColorConstants.textWhite, // النص جوه الأزرار هيبقى أبيض
  );

  static final TextStyle navItem = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: ColorConstants.textWhite,
  );

  static final TextStyle logo = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: ColorConstants.textWhite,
  );
}