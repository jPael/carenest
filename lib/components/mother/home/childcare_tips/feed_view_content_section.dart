import 'package:flutter/material.dart';

class FeedViewContentSection extends StatelessWidget {
  const FeedViewContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Flexible(
                child: Text(
              '''Here is the Step-by-Step Guide:

Step 1: Set a consistent bedtime routine.

Step 2: Use soft lighting and quiet sounds.

Step 3: Avoid over stimulation before bedtime.''',
              softWrap: true,
              style: TextStyle(fontSize: 8 * 3),
            ))
          ],
        ),
        const SizedBox(
          height: 8 * 3,
        ),
        Container(
          height: 150,
          width: 250,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8 * 3), border: Border.all(width: 2)),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.play_circle_filled_rounded,
                  size: 8 * 8,
                  color: Colors.red,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
