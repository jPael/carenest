import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/section/custom_section.dart';

class MidwifePrenatalRecordsImmunizationSupplementTab extends StatelessWidget {
  MidwifePrenatalRecordsImmunizationSupplementTab({super.key});

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
      headerSpacing: 1,
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
                const Icon(
                  Icons.circle,
                  size: 8 * 1.5,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "TT${i + 1}: ",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8 * 2),
                ),
                Text(
                  DateFormat("MMMM d, y").format(ttDates[i]),
                  style: const TextStyle(fontSize: 8 * 2),
                )
              ],
            ),
          ),
        CustomInput.text(context: context, controller: fimController, label: "FIM"),
        const Row(
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
