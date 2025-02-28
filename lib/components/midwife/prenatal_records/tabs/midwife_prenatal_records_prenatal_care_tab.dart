import 'package:flutter/material.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/components/settings/settings_prenatal_records/prenatal_care/prenatal_care_group.dart';

class MidwifePrenatalRecordsPrenatalCareTab extends StatelessWidget {
  const MidwifePrenatalRecordsPrenatalCareTab({super.key, required this.trimester});

  final String trimester;

  @override
  Widget build(BuildContext context) {
    return CustomSection(headerSpacing: 0, childrenSpacing: 8, children: [
      PrenatalCareGroup(
        title: trimester,
      ),
    ]);
  }
}
