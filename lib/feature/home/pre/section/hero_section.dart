import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constans/app_constants.dart';
import '../../../../core/theme/app_colors.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onGetInTouchPressed;

  const HeroSection({super.key, this.onGetInTouchPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 1100) {
            return _buildDesktopLayout(context);
          } else if (constraints.maxWidth >= 768) {
            return _buildTabletLayout(context);
          } else {
            return _buildMobileLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: _buildHeroContent(context, crossAlignment: CrossAxisAlignment.start),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 2,
          child: _buildHeroImage(size: 280),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildHeroImage(size: 220),
        const SizedBox(height: 40),
        _buildHeroContent(context, crossAlignment: CrossAxisAlignment.center),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildHeroImage(size: 180),
        const SizedBox(height: 30),
        _buildHeroContent(context, crossAlignment: CrossAxisAlignment.center),
      ],
    );
  }

  Widget _buildHeroContent(BuildContext context, {required CrossAxisAlignment crossAlignment}) {
    return Column(
      crossAxisAlignment: crossAlignment,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Hello, I'm",
          style: GoogleFonts.inter(fontSize: 20, color: ColorConstants.lightBlue, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Text(
          "Ahmed Tarek",
          textAlign: crossAlignment == CrossAxisAlignment.center ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.inter(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: ColorConstants.textWhite,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Flutter Developer",
          style: GoogleFonts.inter(fontSize: 24, color: ColorConstants.textGray, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),
        Text(
          "I build high-performance, beautiful, and fully responsive cross-platform applications.",
          textAlign: crossAlignment == CrossAxisAlignment.center ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.inter(fontSize: 16, color: ColorConstants.textGray, height: 1.5),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 15,
          runSpacing: 15,
          alignment: crossAlignment == CrossAxisAlignment.center ? WrapAlignment.center : WrapAlignment.start,
          children: [
            // زرار Get in Touch (بيوديه لسكشن الـ Contact)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: ColorConstants.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: onGetInTouchPressed,
              child: Text("Get in Touch", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
            // زرار Preview CV (لعرض المعاينة من الـ Assets)
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                side: const BorderSide(color: ColorConstants.border),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () async {
                final Uri pdfUri = Uri.parse('assets/files/Ahmed_Tarek_linkin.pdf');

                try {
                  await launchUrl(
                    pdfUri,
                    mode: LaunchMode.externalApplication,
                  );
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Could not open PDF preview: $e')),
                    );
                  }
                }
              },
              child: Text("Preview CV", style: GoogleFonts.inter(color: ColorConstants.textWhite, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroImage({double size = 500}) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: ColorConstants.primaryGradient,
          boxShadow: [
            BoxShadow(
              color: ColorConstants.primary.withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ClipOval(
            child: Transform.scale(
              scale: 1.15, // تقدر تزود الرقم ده (مثلاً 1.2 أو 1.3) لو حابب تكبر الصورة أكتر جوه الدائرة
              child: Image.asset(
                'assets/images/profile.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}