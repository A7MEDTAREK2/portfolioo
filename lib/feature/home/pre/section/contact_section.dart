import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constans/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widget/glass_card.dart';
import '../../../../core/widget/section_header.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  // تعريف Controllers لحقول الإدخال لقراءة البيانات منها
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // متغيرات لتتبع حالة الخطأ لكل حقل لو فاضي
  String? _nameError;
  String? _emailError;
  String? _messageError;

  final List<Map<String, dynamic>> _contactMethods = const [
    {
      'icon': '📧',
      'title': 'Email',
      'value': AppConstants.email,
      'action': 'mailto:${AppConstants.email}'
    },
    {
      'icon': '💼',
      'title': 'GitHub',
      'value': 'GitHub Profile',
      'action': AppConstants.github
    },
    {
      'icon': '🔗',
      'title': 'LinkedIn',
      'value': 'LinkedIn Profile',
      'action': AppConstants.linkedin
    },
    {
      'icon': '📱',
      'title': 'WhatsApp',
      'value': 'WhatsApp',
      'action': 'https://wa.me/${AppConstants.phone}'
    },
    {
      'icon': '📞',
      'title': 'Phone',
      'value': AppConstants.phone,
      'action': 'tel:${AppConstants.phone}'
    },
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // دالة إرسال الرسالة والتحقق من الحقول الفاضية بإظهار خطأ تحت كل فيلد
  Future<void> _sendMessage() async {
    setState(() {
      _nameError = _nameController.text.trim().isEmpty ? 'Please enter your name' : null;
      _emailError = _emailController.text.trim().isEmpty ? 'Please enter your email' : null;
      _messageError = _messageController.text.trim().isEmpty ? 'Please enter your message' : null;
    });

    if (_nameError != null || _emailError != null || _messageError != null) {
      return; // لو في أي فيلد فاضي، وقف التنفيذ
    }

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    // تنظيف رقم الواتساب واستخلاص الأرقام فقط لضمان عمل الرابط بشكل صحيح
    final cleanPhone = AppConstants.whatsapp.replaceAll(RegExp(r'[^0-9]'), '');

    // تجهيز نص الرسالة بشكل منسق واحترافي
    final text = 'Hello Ahmed, I want to get in touch from your Portfolio:\n\n'
        '👤 Name: $name\n'
        '📧 Email: $email\n'
        '💬 Message:\n$message';

    final encodedText = Uri.encodeComponent(text);
    final whatsappUri = Uri.parse('https://wa.me/$cleanPhone?text=$encodedText');

    try {
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not open WhatsApp';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Container(
        constraints: const BoxConstraints(maxWidth: AppConstants.maxWidth),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SectionHeader(
              title: 'CONTACT',
              subtitle: "Let's Work Together",
            ),
            const SizedBox(height: 48),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= 900) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: _buildContactForm()
                            .animate()
                            .fadeIn(duration: 500.ms)
                            .slideX(begin: -0.1, end: 0),
                      ),
                      const SizedBox(width: 48),
                      Expanded(
                        flex: 4,
                        child: _buildContactMethods()
                            .animate()
                            .fadeIn(duration: 500.ms, delay: 150.ms)
                            .slideX(begin: 0.1, end: 0),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      _buildContactForm(),
                      const SizedBox(height: 32),
                      _buildContactMethods(),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactForm() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Get in Touch',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: ColorConstants.textWhite,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Have a project in mind? Let\'s discuss how I can help.',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ColorConstants.textGray,
            ),
          ),
          const SizedBox(height: 24),
          _buildFormField(
            'Name',
            Icons.person_outline,
            controller: _nameController,
            errorText: _nameError,
            onChanged: (_) {
              if (_nameError != null) setState(() => _nameError = null);
            },
          ),
          const SizedBox(height: 16),
          _buildFormField(
            'Email',
            Icons.email_outlined,
            controller: _emailController,
            errorText: _emailError,
            onChanged: (_) {
              if (_emailError != null) setState(() => _emailError = null);
            },
          ),
          const SizedBox(height: 16),
          _buildFormField(
            'Message',
            Icons.message_outlined,
            controller: _messageController,
            maxLines: 4,
            errorText: _messageError,
            onChanged: (_) {
              if (_messageError != null) setState(() => _messageError = null);
            },
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: _sendMessage,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: ColorConstants.primaryGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Send Message',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(
      String label,
      IconData icon, {
        required TextEditingController controller,
        int maxLines = 1,
        String? errorText,
        ValueChanged<String>? onChanged,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorConstants.textWhite,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          maxLines: maxLines,
          onChanged: onChanged,
          textDirection: TextDirection.ltr,
          style: const TextStyle(color: ColorConstants.textWhite),
          decoration: InputDecoration(
            errorText: errorText, // هنا بيعرض الخطأ تحت الفيلد مباشرة لو فاضي
            prefixIcon: Icon(icon, color: ColorConstants.textGray),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: ColorConstants.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: ColorConstants.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: ColorConstants.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactMethods() {
    return Column(
      children: _contactMethods.map((method) {
        return _buildContactMethod(method);
      }).toList(),
    );
  }

  Widget _buildContactMethod(Map<String, dynamic> method) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConstants.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorConstants.border),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: ColorConstants.lightBlue.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                method['icon'] ?? '📧',
                style: GoogleFonts.inter(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  method['title'] ?? '',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.textWhite,
                  ),
                ),
                Text(
                  method['value'] ?? '',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.textGray,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.open_in_new, size: 18, color: ColorConstants.lightBlue),
            onPressed: () async {
              String action = method['action'] ?? '';
              Uri? launchUri;

              if (method['title'].toString().contains('WhatsApp')) {
                String cleanPhone = AppConstants.whatsapp.replaceAll(RegExp(r'[^0-9]'), '');
                launchUri = Uri.parse('https://wa.me/$cleanPhone');
              } else if (action.startsWith('mailto:') || action.startsWith('tel:')) {
                launchUri = Uri.parse(action);
              } else if (action.startsWith('http')) {
                launchUri = Uri.parse(action);
              }

              if (launchUri != null && await canLaunchUrl(launchUri)) {
                await launchUrl(launchUri, mode: LaunchMode.externalApplication);
              } else {
                await launchUrl(Uri.parse(action), mode: LaunchMode.platformDefault);
              }
            },
          ),
        ],
      ),
    );
  }
}