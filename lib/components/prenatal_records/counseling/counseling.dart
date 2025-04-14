import 'package:flutter/material.dart';
import 'package:smartguide_app/components/section/custom_section.dart';

class Counseling extends StatelessWidget {
  const Counseling({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(2 * 8.0),
      child: CustomSection(
        title: "Counseling",
        children: [],
      ),
    );
  }
}
