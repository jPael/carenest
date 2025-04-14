import 'package:flutter/material.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/components/settings/settings_prenatal_records/prenatal_care/prenatal_care_item.dart';

class SettingsPrenatalRecordsCounselingTopicsTabView extends StatelessWidget {
  SettingsPrenatalRecordsCounselingTopicsTabView({super.key});

  final TextEditingController forMyChildController = TextEditingController();
  final TextEditingController forMyselfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomSection(
      title: "Counseling Topics",
      children: [
        const PrenatalCareItem(description: "Breastfeeding", checked: true),
        const PrenatalCareItem(description: "Family Planning", checked: false),
        const PrenatalCareItem(description: "Proper Nutrition", checked: true),
        const PrenatalCareItem(description: "Breastfeeding", checked: true),
        CustomInput.text(context: context, controller: forMyChildController, label: "For My Child"),
        CustomInput.text(context: context, controller: forMyselfController, label: "For Myself"),
      ],
    );
  }
}
