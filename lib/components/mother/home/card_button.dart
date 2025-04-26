import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  const CardButton(
      {super.key,
      required this.onPressed,
      required this.label,
      required this.content,
      this.notifCount = 0});

  final VoidCallback onPressed;
  final String label;
  final Widget content;
  final int? notifCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Badge.count(
        padding: const EdgeInsets.all(8 / 2),
        isLabelVisible: notifCount != 0,
        count: 3,
        largeSize: 8 * 4,
        textStyle: const TextStyle(fontSize: 8 * 3),
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
                    offset: const Offset(2, 2),
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
              style: const TextStyle(fontSize: 4 * 5, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
