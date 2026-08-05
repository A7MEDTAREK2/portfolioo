import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constans/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widget/glass_card.dart';
import '../../../../core/widget/section_header.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  final List<Map<String, dynamic>> _projects = const [
    {
      'title': 'ModuPOS',
      'description':
      'A professional desktop Point of Sale (POS) system built with Flutter for restaurants, cafés, and retail businesses. It features inventory management, customer management, kitchen printing, barcode scanning, sales reports, REST API integration, and an offline-first architecture powered by SQLite.',
      'technologies': [
        'Flutter',
        'Bloc',
        'SQLite',
        'REST API',
        'Dio',
        'Windows Desktop',
      ],
      'image': 'assets/images/modu.png',
      'github': 'https://github.com/A7MEDTAREK2/pos',
    },
    {
      'title': 'Notito',
      'description':
      'A modern note-taking application built with Flutter and Firebase. It provides cloud synchronization, authentication, real-time data storage, responsive UI, and clean architecture for a seamless note management experience.',
      'technologies': [
        'Flutter',
        'Firebase',
        'Bloc',
        'Cloud Firestore',
        'Authentication',
      ],
      'image': 'assets/images/notito.png',
      'github': 'https://github.com/A7MEDTAREK2/notes_app',
    },
    {
      'title': 'Doctor Booking',
      'description':
      'A doctor appointment booking application with authentication, doctor browsing, appointment scheduling, REST API integration, responsive UI, and scalable state management using BLoC.',
      'technologies': [
        'Flutter',
        'Bloc',
        'REST API',
        'Dio',
        'Responsive UI',
      ],
      'image': 'assets/images/doc.png',
      'github': 'https://github.com/A7MEDTAREK2/docdoc',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 80,
      ),
      color: ColorConstants.background,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxWidth,
          ),
          child: Column(
            children: [
              const SectionHeader(
                title: 'PROJECTS',
                subtitle: 'Featured Work',
              ),
              const SizedBox(height: 48),
              LayoutBuilder(
                builder: (context, constraints) {
                  final double width = constraints.maxWidth;

                  // تحديد عدد الأعمدة بناءً على عرض الكونتينر المتاح
                  int crossAxisCount = 3;
                  if (width < 768) {
                    crossAxisCount = 1;
                  } else if (width < 1100) {
                    crossAxisCount = 2;
                  }

                  // استخدام ListView في الموبايل والتابلت الضيق لتفادي مشاكل الـ GridView والـ AspectRatio
                  if (crossAxisCount == 1) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _projects.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 24),
                      itemBuilder: (context, index) {
                        return _buildProjectCard(context, _projects[index])
                            .animate()
                            .fadeIn(duration: 400.ms, delay: (index * 150).ms)
                            .slideY(begin: .2, end: 0);
                      },
                    );
                  }

                  // استخدام GridView للديسك توب والتابلت العريض مع ضبط مقاسات آمنة
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _projects.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: crossAxisCount == 2 ? 0.72 : 0.68,
                    ),
                    itemBuilder: (context, index) {
                      return _buildProjectCard(context, _projects[index])
                          .animate()
                          .fadeIn(duration: 400.ms, delay: (index * 150).ms)
                          .slideY(begin: .2, end: 0);
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

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> project) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                project['image'],
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project['title'],
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.textWhite,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project['description'],
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      height: 1.5,
                      color: ColorConstants.textGray,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: (project['technologies'] as List)
                        .map(
                          (tech) => Container(
                        padding:  symmetricPadding(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstants.primary.withOpacity(.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          tech.toString(),
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.primary,
                          ),
                        ),
                      ),
                    )
                        .toList(),
                  ),
                  const Spacer(),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: ColorConstants.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        final Uri url = Uri.parse(project['github']);
                        try {
                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            throw 'Could not launch ${project['github']}';
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error opening link: $e')),
                            );
                          }
                        }
                      },
                      child: Text(
                        "View Project",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper extension or constant fix for padding if needed, standard EdgeInsets used below:
EdgeInsets symmetricPadding({required double horizontal, required double vertical}) {
  return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
}