import 'package:flutter/material.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/components/settings/settings_prenatal_records/prenatal_care/prenatal_care_item.dart';

class MidwifePrenatalRecordsCounselingTopicTab extends StatelessWidget {
  MidwifePrenatalRecordsCounselingTopicTab({super.key});

  final TextEditingController forMyChildController = TextEditingController();
  final TextEditingController forMyselfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomSection(
      headerSpacing: 1,
      children: [
        PrenatalCareItem(description: "Breastfeeding", checked: true),
        PrenatalCareItem(description: "Family Planning", checked: false),
        PrenatalCareItem(description: "Proper Nutrition", checked: true),
        PrenatalCareItem(description: "Breastfeeding", checked: true),
        CustomInput.text(context: context, controller: forMyChildController, label: "For My Child"),
        CustomInput.text(context: context, controller: forMyselfController, label: "For Myself"),
      ],
    );
  }
}
