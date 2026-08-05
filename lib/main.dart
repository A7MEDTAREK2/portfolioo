import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme/app_colors.dart'; // تأكد إن مسار الاستيراد مظبوط
import 'feature/home/pre/page/home_page.dart';

void main() {
  runApp(const AhmedTarekPortfolio());
}

class AhmedTarekPortfolio extends StatelessWidget {
  const AhmedTarekPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ahmed Tarek - Flutter Developer',
      // هنا خلينا التطبيق كله يشتغل بالثيم الغامق المودرن المتناسق مع ألوانك
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ColorConstants.background,
        primaryColor: ColorConstants.primary,
        colorScheme: const ColorScheme.dark(
          primary: ColorConstants.primary,
          surface: ColorConstants.surface,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}