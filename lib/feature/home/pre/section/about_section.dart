import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constans/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widget/section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  final List<Map<String, String>> _timeline = const [
    {
      'year': '2026',
      'title': 'Started Professional Flutter Development',
    },
    {
      'year': '2026',
      'title': 'Built Notito Notes Application',
    },
    {
      'year': '2026',
      'title': 'Developed Doctor Booking System',
    },
    {
      'year': '2026',
      'title': 'Developed ModuPOS System',
    },
    {
      'year': '2026',
      'title': 'Integrated Firebase, SQLite & REST APIs',
    },
    {
      'year': '2026',
      'title': 'Applied Clean Architecture & BLoC',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth >= 992;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 24 : 16,
        vertical: 80,
      ),
      color: ColorConstants.background,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxWidth),
          margin: EdgeInsets.symmetric(horizontal: isDesktop ? 24 : 8),
          child: isDesktop
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: _buildAboutContent(context),
              ),
              const SizedBox(width: 60),
              Expanded(
                flex: 4,
                child: _buildTimeline(context),
              ),
            ],
          )
              : Column(
            children: [
              _buildAboutContent(context),
              const SizedBox(height: 48),
              _buildTimeline(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'ABOUT',
          subtitle: 'Who I Am',
          centered: false,
        ),
        const SizedBox(height: 24),
        Text(
          "I'm Ahmed Tarek, a Flutter Developer passionate about building modern, high-performance applications for Mobile, Desktop, and Web. I focus on writing clean, scalable code while delivering smooth user experiences.",
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: ColorConstants.textGray,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'My experience includes developing complete Point of Sale (POS) systems, integrating REST APIs, Firebase services, local databases with SQLite, and applying Clean Architecture with BLoC/Cubit to build production-ready applications.',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: ColorConstants.textGray,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 40,
          runSpacing: 20,
          children: [
            _buildStatItem('3+', 'Major Projects'),
            _buildStatItem('10+', 'Technologies'),
            _buildStatItem('100%', 'Cross Platform'),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1, end: 0);
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: GoogleFonts.inter(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: ColorConstants.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorConstants.textWhite,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeline(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: ColorConstants.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorConstants.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Career Timeline',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: ColorConstants.textWhite,
            ),
          ),
          const SizedBox(height: 24),
          ..._timeline.map((item) => _buildTimelineItem(item)).toList(),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.1, end: 0);
  }

  Widget _buildTimelineItem(Map<String, String> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: ColorConstants.primary,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: ColorConstants.lightBlue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              item['year'] ?? '',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: ColorConstants.lightBlue,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              item['title'] ?? '',
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: ColorConstants.textWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}