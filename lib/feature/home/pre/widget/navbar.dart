import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constans/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widget/responsive_layout.dart';

class Navbar extends StatefulWidget {
  final Function(int)? onItemSelected;
  final int selectedIndex;

  const Navbar({
    super.key,
    this.onItemSelected,
    this.selectedIndex = 0,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final List<String> _menuItems = [
    'Home',
    'Projects',
    'Services',
    'About',
    'Contact',
  ];

  void _scrollToSection(int index) {
    if (widget.onItemSelected != null) {
      widget.onItemSelected!(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: ColorConstants.surface.withOpacity(0.9),
        border: Border(
          bottom: BorderSide(color: ColorConstants.border),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxWidth),
          child: Responsive(
            mobile: _buildMobileNav(context),
            tablet: _buildTabletNav(),
            desktop: _buildDesktopNav(),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopNav() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(),
        _buildMenuItems(),
        _buildCTAButton(),
      ],
    );
  }

  Widget _buildTabletNav() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(),
        _buildMenuItems(),
      ],
    );
  }

  Widget _buildMobileNav(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(),
        IconButton(
          icon: const Icon(Icons.menu, color: ColorConstants.textWhite),
          onPressed: () {
            showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: 'Menu',
              barrierColor: Colors.black.withOpacity(0.5),
              transitionDuration: const Duration(milliseconds: 250),
              pageBuilder: (context, animation, secondaryAnimation) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorConstants.surface,
                        border: Border(
                          left: BorderSide(color: ColorConstants.border),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildLogo(),
                                IconButton(
                                  icon: const Icon(Icons.close, color: ColorConstants.textWhite),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Expanded(
                              child: ListView.builder(
                                itemCount: _menuItems.length,
                                itemBuilder: (context, index) {
                                  final isSelected = widget.selectedIndex == index;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      tileColor: isSelected
                                          ? ColorConstants.lightBlue.withOpacity(0.15)
                                          : Colors.transparent,
                                      title: Text(
                                        _menuItems[index],
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                          color: isSelected
                                              ? ColorConstants.lightBlue
                                              : ColorConstants.textWhite,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _scrollToContext(index);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  backgroundColor: ColorConstants.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);
                                  final whatsappUrl = Uri.parse(AppConstants.whatsapp);
                                  if (await canLaunchUrl(whatsappUrl)) {
                                    await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
                                  }
                                },
                                child: Text(
                                  'Hire Me',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              transitionBuilder: (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
                  child: child,
                );
              },
            );
          },
        ),
      ],
    );
  }

  void _scrollToContext(int index) {
    _scrollToSection(index);
  }

  Widget _buildLogo() {
    return Row(
      children: [
        // استبدال صندوق الحروف بصورة اللوجو مع حواف دائرية أنيقة
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/logo.png',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          AppConstants.developerName,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ColorConstants.textWhite,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItems() {
    return Row(
      children: _menuItems.asMap().entries.map((entry) {
        final isSelected = widget.selectedIndex == entry.key;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _scrollToSection(entry.key),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorConstants.lightBlue.withOpacity(0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  entry.value,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected
                        ? ColorConstants.lightBlue
                        : ColorConstants.textGray,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCTAButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final whatsappUrl = Uri.parse(AppConstants.whatsapp);
          if (await canLaunchUrl(whatsappUrl)) {
            await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(
            gradient: ColorConstants.primaryGradient,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.primary.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            'Hire Me',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}