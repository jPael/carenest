import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  const CardButton(
      {super.key, required this.onPressed, required this.label, required this.content});

  final VoidCallback onPressed;
  final String label;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.zero,
            width: 170,
            height: 170 * 1.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2), // Match button shadow
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Center(
              child: OverflowBox(
                maxWidth: double.infinity,
                maxHeight: double.infinity,
                child: Hero(tag: label, child: content),
              ),
            ),
          ),
          const SizedBox(
            height: 8 * 2,
          ),
          Text(
            label,
            style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
