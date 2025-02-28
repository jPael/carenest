import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/section/custom_section.dart';

class SettingsPrenatalRecordsImmunizationSupplementsTabView extends StatelessWidget {
  SettingsPrenatalRecordsImmunizationSupplementsTabView({super.key});

  /*

TT Immunization Status: (text input)
TT1: (Date given: DD/MM/YYYY)
TT2: (Date given: DD/MM/YYYY)
TT3: (Date given: DD/MM/YYYY)
TT4: (Date given: DD/MM/YYYY)
TT5: (Date given: DD/MM/YYYY)
FIM: (text input)
Iron Supplementation: (Date: DD/MM/YYYY, Tabs given: mg)

  */

  final TextEditingController ttImmunizationStatusController = TextEditingController();
  final List<DateTime> ttDates = [
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now()
  ];
  final TextEditingController fimController = TextEditingController();
  final Map<String, dynamic> ironSupplementation = {
    "date": DateTime.now(),
    "tabs": 0,
  };

  @override
  Widget build(BuildContext context) {
    return CustomSection(
      title: "Immunization And Supplements ",
      children: [
        CustomInput.text(
            context: context,
            controller: ttImmunizationStatusController,
            label: "TT Immunization Status"),
        for (int i = 0; i < ttDates.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2 * 8.0),
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 8 * 1.5,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "TT${i + 1}: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8 * 2),
                ),
                Text(
                  DateFormat("MMMM d, y").format(ttDates[i]),
                  style: TextStyle(fontSize: 8 * 2),
                )
              ],
            ),
          ),
        CustomInput.text(context: context, controller: fimController, label: "FIM"),
        Row(
          children: [
            Text(
              "Iron Supplementation",
              style: TextStyle(fontSize: 8 * 2.5),
            ),
          ],
        ),
        CustomInput.datepicker(
            context: context, onChange: (e) {}, selectedDate: ironSupplementation["date"]),
        CustomInput.text(
            context: context,
            controller: TextEditingController(text: ironSupplementation["tabs"].toString()),
            label: "Tabs")
      ],
    );
  }
}
