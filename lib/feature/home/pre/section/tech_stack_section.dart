import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constans/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widget/glass_card.dart';
import '../../../../core/widget/section_header.dart';

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

  final List<Map<String, String>> _techStack = const [
    {
      'icon': '💙',
      'title': 'Flutter',
      'description': 'Cross-platform Mobile, Desktop & Web Applications',
    },
    {
      'icon': '🎯',
      'title': 'Dart',
      'description': 'Modern Programming Language',
    },
    {
      'icon': '🧩',
      'title': 'BLoC / Cubit',
      'description': 'Scalable State Management',
    },
    {
      'icon': '🏗️',
      'title': 'Clean Architecture',
      'description': 'Maintainable Project Structure',
    },
    {
      'icon': '💾',
      'title': 'SQLite',
      'description': 'Offline Local Database',
    },
    {
      'icon': '🌐',
      'title': 'REST APIs',
      'description': 'Dio • JSON • Authentication',
    },
    {
      'icon': '🖥️',
      'title': 'Windows',
      'description': 'Desktop POS Applications',
    },
    {
      'icon': '🤖',
      'title': 'Android',
      'description': 'Native-like Flutter Apps',
    },
    {
      'icon': '🔧',
      'title': 'Git & GitHub',
      'description': 'Version Control',
    },
    {
      'icon': '🎨',
      'title': 'Figma',
      'description': 'UI Implementation',
    },
    {
      'icon': '🛠️',
      'title': 'Photoshop',
      'description': 'Graphics & Assets',
    },
    {
      'icon': '⚡',
      'title': 'Performance',
      'description': 'Optimization & Best Practices',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      color: ColorConstants.background,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxWidth),
          child: Column(
            children: [
              const SectionHeader(
                title: 'TECH STACK',
                subtitle: 'Technologies I Work With',
              ),
              const SizedBox(height: 48),
              LayoutBuilder(
                builder: (context, constraints) {
                  final double width = constraints.maxWidth;
                  int crossAxisCount = 4;
                  double childAspectRatio = 1.05;

                  if (width < 768) {
                    crossAxisCount = 1; // موبايل
                    childAspectRatio = 1.6;
                  } else if (width < 1100) {
                    crossAxisCount = 2; // تابلت
                    childAspectRatio = 1.2;
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemCount: _techStack.length,
                    itemBuilder: (context, index) {
                      return _buildTechCard(_techStack[index])
                          .animate()
                          .fadeIn(
                        duration: 400.ms,
                        delay: (index * 60).ms,
                      )
                          .slideY(
                        begin: 0.2,
                        end: 0,
                        duration: 400.ms,
                        delay: (index * 60).ms,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTechCard(Map<String, String> tech) {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tech['icon'] ?? '📱',
              style: GoogleFonts.inter(fontSize: 36),
            ),
            const SizedBox(height: 8),
            Text(
              tech['title'] ?? '',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: ColorConstants.textWhite,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              tech['description'] ?? '',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: ColorConstants.textGray,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}