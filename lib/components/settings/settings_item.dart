import 'package:flutter/material.dart';

class SettingsItem extends StatefulWidget {
  const SettingsItem({
    super.key,
    this.icon,
    required this.title,
    required this.onTap,
    this.isSelected = false,
  });

  final Widget? icon;
  final String title;
  final GestureTapCallback onTap;
  final bool isSelected;

  @override
  State<SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8.0 * 2),
        child: Row(
          spacing: 8 * 2,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.icon != null) widget.icon!,
            Flexible(
              child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: 8 * 3,
                    fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal),
              ),
            )
          ],
        ),
      ),
    );
  }
}
