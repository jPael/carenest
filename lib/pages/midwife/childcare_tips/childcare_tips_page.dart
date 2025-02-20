import 'package:flutter/material.dart';
import 'package:smartguide_app/components/home/childcare_tips/feed_section.dart';
import 'package:smartguide_app/components/home/childcare_tips/profile_section.dart';

class ChildcareTipsPage extends StatelessWidget {
  const ChildcareTipsPage({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0 * 3),
        child: Column(
          children: [
            ProfileSection(label: label),
            const SizedBox(
              height: 8 * 4,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: SingleChildScrollView(child: FeedSection()))
          ],
        ),
      ),
    );
  }
}
