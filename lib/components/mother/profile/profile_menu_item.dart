import 'package:flutter/material.dart';

class ProfileMenuItem extends StatefulWidget {
  const ProfileMenuItem({
    super.key,
    required this.title,
    this.form,
    this.startIcon,
    this.endIcon,
    required this.isOpen,
    required this.onTap,
  });

  final String title;
  final Widget? form;
  final Widget? startIcon;
  final Widget? endIcon;
  final bool isOpen;
  final VoidCallback onTap;

  @override
  State<ProfileMenuItem> createState() => _ProfileMenuItemState();
}

class _ProfileMenuItemState extends State<ProfileMenuItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8 * 2, horizontal: 8.0 * 3),
            child: Row(
              spacing: 8 * 2,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.startIcon != null) widget.startIcon!,
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
                      ),
                      if (widget.endIcon != null) widget.endIcon!,
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        if (widget.form != null)
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
            child: widget.isOpen
                ? Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8 * 2),
                      child: widget.form!,
                    ),
                  )
                : const SizedBox(
                    width: double.infinity,
                  ),
          ),
      ],
    );
  }
}
