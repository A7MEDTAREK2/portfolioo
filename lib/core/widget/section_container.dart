import 'package:flutter/material.dart';
import '../../core/utils/responsive.dart';

class SectionContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? customPadding;

  const SectionContainer({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.customPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    final bool isTablet = Responsive.isTablet(context);

    EdgeInsetsGeometry defaultPadding;
    if (isDesktop) {
      defaultPadding = const EdgeInsets.symmetric(horizontal: 80.0, vertical: 60.0);
    } else if (isTablet) {
      defaultPadding = const EdgeInsets.symmetric(horizontal: 40.0, vertical: 50.0);
    } else {
      defaultPadding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0);
    }

    return Container(
      width: double.infinity,
      color: backgroundColor ?? Colors.transparent,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400), // أقصى عرض عشان الشاشات الضخمة جداً ما تكسرش التصميم
          child: Padding(
            padding: customPadding ?? defaultPadding,
            child: child,
          ),
        ),
      ),
    );
  }
}