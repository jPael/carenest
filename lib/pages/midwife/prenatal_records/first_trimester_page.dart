import 'package:flutter/material.dart';
import 'package:smartguide_app/models/revamp/clinic_history.dart';
import 'package:smartguide_app/models/revamp/first_trimester.dart';

class FirstTrimesterPage extends StatelessWidget {
  const FirstTrimesterPage({super.key, required this.trimesters});

  final List<FirstTrimester> trimesters;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text("Hello world"), ...trimesters.map((t) => Text(t.checkUp.label.toString()))],
    );
  }
}
