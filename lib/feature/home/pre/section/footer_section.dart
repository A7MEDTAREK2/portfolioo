import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constans/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widget/responsive_layout.dart';

class FooterSection extends StatelessWidget {
  final VoidCallback? onBackToTop;

  const FooterSection({super.key, this.onBackToTop});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      color: ColorConstants.darkNavy,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxWidth),
          child: Column(
            children: [
              Responsive(
                mobile: _buildMobileFooter(),
                tablet: _buildDesktopFooter(),
                desktop: _buildDesktopFooter(),
              ),
              const SizedBox(height: 24),
              const Divider(color: ColorConstants.secondaryNavy),
              const SizedBox(height: 24),
              Responsive(
                mobile: _buildMobileFooterBottom(),
                tablet: _buildFooterBottom(),
                desktop: _buildFooterBottom(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildFooterLogo(),
        _buildBackToTop(),
      ],
    );
  }

  Widget _buildMobileFooter() {
    return Column(
      children: [
        _buildFooterLogo(),
        const SizedBox(height: 20),
        _buildBackToTop(),
      ],
    );
  }

  Widget _buildFooterLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // استبدال صندوق الحروف بصورة اللوجو مع حواف دائرية أنيقة
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/logo.png',
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 9),
        Text(
          AppConstants.developerName,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildBackToTop() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onBackToTop,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: ColorConstants.secondaryNavy),
            borderRadius: BorderRadius.circular(8),
            color: ColorConstants.secondaryNavy.withOpacity(0.2),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.arrow_upward,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                'Back to Top',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterBottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '© ${DateTime.now().year} ${AppConstants.developerName}. Flutter Developer.',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
        Text(
          'Designed and Developed by Ahmed Tarek',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileFooterBottom() {
    return Column(
      children: [
        Text(
          '© ${DateTime.now().year} ${AppConstants.developerName}. All rights reserved.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Designed and Developed by Ahmed Tarek',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}