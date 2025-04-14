import 'package:flutter/material.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/components/settings/settings_prenatal_records/prenatal_care/prenatal_care_group.dart';

class SettingsPrenatalRecordsPrenatalCareTabView extends StatelessWidget {
  const SettingsPrenatalRecordsPrenatalCareTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: CustomSection(
        childrenSpacing: 8,
        title: "Prenatal Care",
        children: [
          PrenatalCareGroup(
            title: "First Trimester",
          ),
          PrenatalCareGroup(
            title: "Second Trimester",
          ),
          PrenatalCareGroup(
            title: "Third Trimester",
          ),
          PrenatalCareGroup(
            title: "Fourth Trimester",
          ),
        ],
      ),
    );
  }
}
