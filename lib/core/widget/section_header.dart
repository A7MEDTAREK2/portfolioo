import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool centered;

  const SectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.centered = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // الـ Badge العلوي بخلفية شفافة وهادئة تماشياً مع الثيم الغامق
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: ColorConstants.lightBlue.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: ColorConstants.lightBlue.withOpacity(0.3)),
          ),
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: ColorConstants.lightBlue,
              letterSpacing: 1.0,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // العنوان الرئيسي بلون أبيض ناصع ومتناسق مع الخلفية الكحلي
        Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 38,
            fontWeight: FontWeight.w700,
            color: ColorConstants.textWhite,
            letterSpacing: -0.5,
          ),
          textAlign: centered ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 16),
        // خط التدرج الجمالي تحت العنوان
        Container(
          width: 50,
          height: 4,
          decoration: BoxDecoration(
            gradient: ColorConstants.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}