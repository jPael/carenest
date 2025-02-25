import 'package:flutter/material.dart';
import 'package:smartguide_app/components/midwife/home/forum/forum_toolbar_section.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/components/section/custom_section_item.dart';
import 'package:smartguide_app/pages/midwife/forum/forum_post_page.dart';

class ForumPage extends StatelessWidget {
  const ForumPage({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        title: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8 * 2),
          child: Column(
            spacing: 8 * 3,
            children: [
              ForumToolbarSection(),
              CustomSection(
                title: "Most recent",
                children: [
                  CustomSectionItem(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForumPostPage(
                                  user: "Rose",
                                  date: DateTime.now(),
                                  liked: true,
                                ))),
                    title: "What foods help with morning sickness?",
                    user: "Rose",
                    replyCount: 2,
                    date: DateTime.now(),
                    liked: true,
                  ),
                  CustomSectionItem(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForumPostPage(
                                  user: "Marry",
                                  date: DateTime(2024, 03, 12),
                                ))),
                    title: "What foods help with morning sickness?",
                    user: "Marry",
                    replyCount: 2,
                    date: DateTime(2024, 03, 12),
                  ),
                  CustomSectionItem(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForumPostPage(
                                  user: "Rose",
                                  date: DateTime(2024, 03, 15),
                                  liked: true,
                                ))),
                    title: "What foods help with morning sickness?",
                    user: "Rose",
                    replyCount: 12,
                    date: DateTime(2024, 03, 15),
                    liked: true,
                  ),
                ],
              ),
              CustomSection(
                title: "Most active",
                children: [
                  CustomSectionItem(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForumPostPage(
                                  user: "Marry",
                                  date: DateTime(2024, 03, 12),
                                ))),
                    title: "What foods help with morning sickness?",
                    user: "Marry",
                    replyCount: 2,
                    date: DateTime(2024, 03, 12),
                  ),
                  CustomSectionItem(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForumPostPage(
                                  user: "Rose",
                                  date: DateTime(2024, 03, 15),
                                ))),
                    title: "What foods help with morning sickness?",
                    user: "Rose",
                    replyCount: 12,
                    date: DateTime(2024, 03, 15),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
