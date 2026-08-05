import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../widget/navbar.dart';
import '../section/hero_section.dart';
import '../section/about_section.dart';
import '../section/services_section.dart';
import '../section/projects_section.dart';
import '../section/tech_stack_section.dart';
import '../section/process_section.dart';
import '../section/contact_section.dart';
import '../section/footer_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  int _currentNavIndex = 0;
  bool _isAutoScrolling = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isAutoScrolling) return;

    final offset = _scrollController.offset;
    int newIndex = 0;

    // تتبع دقيق لأماكن السكشنز أثناء السكرول اليدوي
    if (offset >= 3800) {
      newIndex = 4; // Contact
    } else if (offset >= 3000) {
      newIndex = 3; // About & Process
    } else if (offset >= 1500) {
      newIndex = 2; // Services & Tech Stack
    } else if (offset >= 500) {
      newIndex = 1; // Projects
    } else {
      newIndex = 0; // Home
    }

    if (_currentNavIndex != newIndex) {
      setState(() {
        _currentNavIndex = newIndex;
      });
    }
  }

  void _scrollToSection(int index) {
    setState(() {
      _currentNavIndex = index;
      _isAutoScrolling = true;
    });

    double targetOffset = 0.0;
    switch (index) {
      case 0:
        targetOffset = 0.0; // Home
        break;
      case 1:
        targetOffset = 600.0; // Projects
        break;
      case 2:
        targetOffset = 1500.0; // Services & Tech Stack
        break;
      case 3:
        targetOffset = 3600.0; // About & Process (تم ضبط المسافة لتناسب مكان الـ About بالظبط)
        break;
      case 4:
        targetOffset = 4800.0; // Contact (آخر الصفحة خالص)
        break;
    }

    _scrollController
        .animateTo(
      targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    )
        .then((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        _isAutoScrolling = false;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: SafeArea(
        child: Column(
          children: [
            Navbar(
              selectedIndex: _currentNavIndex,
              onItemSelected: _scrollToSection,
            )
                .animate()
                .fadeIn(duration: 300.ms)
                .slideY(begin: -0.2, end: 0),
            Expanded(
              child: ListView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                children: [
                  HeroSection(
                    onGetInTouchPressed: () => _scrollToSection(4),
                  ),
                  const ProjectsSection(),
                  const ServicesSection(),
                  const TechStackSection(),
                  const AboutSection(),
                  const ProcessSection(),
                  const ContactSection(),
                  RepaintBoundary(
                    child: FooterSection(
                      onBackToTop: () => _scrollToSection(0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}