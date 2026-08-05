import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constans/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widget/section_header.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  final List<Map<String, String>> _processSteps = const [
    {
      'step': '01',
      'title': 'Discovery',
      'description': 'Understanding your vision, goals, and requirements for the project.'
    },
    {
      'step': '02',
      'title': 'Planning',
      'description': 'Creating detailed project roadmap and technical architecture.'
    },
    {
      'step': '03',
      'title': 'Development',
      'description': 'Building your application with clean, maintainable code.'
    },
    {
      'step': '04',
      'title': 'Testing',
      'description': 'Comprehensive quality assurance and performance optimization.'
    },
    {
      'step': '05',
      'title': 'Launch',
      'description': 'Deploying your application and providing post-launch support.'
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
          child: Column(
            children: [
              const SectionHeader(
                title: 'PROCESS',
                subtitle: 'How I Work',
              ),
              const SizedBox(height: 48),
              isDesktop
                  ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _processSteps.asMap().entries.map((entry) {
                  return Expanded(
                    child: _buildProcessStep(entry.value)
                        .animate()
                        .fadeIn(duration: 400.ms, delay: (entry.key * 100).ms)
                        .slideY(begin: 0.2, end: 0),
                  );
                }).toList(),
              )
                  : Column(
                children: _processSteps.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: _buildProcessStep(entry.value)
                        .animate()
                        .fadeIn(duration: 400.ms, delay: (entry.key * 100).ms)
                        .slideY(begin: 0.2, end: 0),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProcessStep(Map<String, String> step) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: ColorConstants.primaryGradient,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Center(
              child: Text(
                step['step'] ?? '',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            step['title'] ?? '',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: ColorConstants.textWhite,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            step['description'] ?? '',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ColorConstants.textGray,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}