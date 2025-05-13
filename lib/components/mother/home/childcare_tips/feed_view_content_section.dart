import 'package:flutter/material.dart';
import 'package:smartguide_app/models/revamp/child_care_tips.dart';

class FeedViewContentSection extends StatelessWidget {
  const FeedViewContentSection({super.key, required this.data});
  final ChildCareTips data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24), // 8 * 3 = 24
            border: Border.all(width: 2),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Network image with fit and error handling
              ClipRRect(
                borderRadius: BorderRadius.circular(22), // Slightly smaller than container
                child: Image.network(
                  data.imagePath, // Replace with your image URL
                  height: 150,
                  width: 250,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image, size: 50),
                    );
                  },
                ),
              ),

              // Play icon overlay
            ],
          ),
        ),
        const SizedBox(
          height: 8 * 3,
        ),
        Row(
          children: [
            Flexible(
                child: Text(
              '''${data.description}''',
              softWrap: true,
              style: const TextStyle(fontSize: 8 * 3),
            ))
          ],
        ),
        const SizedBox(
          height: 8 * 10,
        ),
      ],
    );
  }
}
