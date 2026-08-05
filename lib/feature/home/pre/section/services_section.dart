import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constans/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widget/glass_card.dart';
import '../../../../core/widget/section_header.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  final List<Map<String, String>> _services = const [
    {
      'icon': '📱',
      'title': 'Flutter App Development',
      'description':
      'Building high-performance cross-platform applications for Android, Windows, and Web using Flutter with scalable and maintainable architecture.',
    },
    {
      'icon': '🛒',
      'title': 'POS Systems',
      'description':
      'Designing and developing modern Point of Sale (POS) systems with inventory management, kitchen printing, sales reports, and offline-first functionality.',
    },
    {
      'icon': '🏗️',
      'title': 'Clean Architecture',
      'description':
      'Creating scalable applications using Clean Architecture, Repository Pattern, BLoC/Cubit, and best software engineering practices.',
    },
    {
      'icon': '🔗',
      'title': 'REST API Integration',
      'description':
      'Integrating REST APIs using Dio, authentication, JSON serialization, error handling, and secure networking.',
    },
    {
      'icon': '☁️',
      'title': 'Firebase Integration',
      'description':
      'Integrating Firebase Authentication, Cloud Firestore, Storage, Cloud Messaging, and backend services for scalable applications.',
    },
    {
      'icon': '💾',
      'title': 'Offline Database',
      'description':
      'Building offline-first applications using SQLite with synchronization, local caching, and high-performance database design.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      color: ColorConstants.background,
      child: Container(
        constraints: const BoxConstraints(maxWidth: AppConstants.maxWidth),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SectionHeader(
              title: 'SERVICES',
              subtitle: 'What I Do',
            ),
            const SizedBox(height: 48),
            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: _services.asMap().entries.map((entry) {
                return SizedBox(
                  width: 360,
                  child: GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.value['icon']!,
                          style: const TextStyle(fontSize: 42),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          entry.value['title']!,
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.textWhite,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          entry.value['description']!,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            color: ColorConstants.textGray,
                            height: 1.7,
                          ),
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(
                    duration: 600.ms,
                    delay: (entry.key * 150).ms,
                  )
                      .slideY(begin: .2, end: 0),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}