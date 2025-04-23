import 'package:flutter/material.dart';
import 'package:smartguide_app/components/button/custom_dropdown_button.dart';
import 'package:smartguide_app/components/checklist/custom_checkbox.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/care_and_test.dart';
import 'package:smartguide_app/models/trimester.dart';

class CareAndTestsForm extends StatefulWidget {
  const CareAndTestsForm({
    super.key,
    required this.data,
    required this.selectedTrimester,
    required this.trimesterOnChange,
    required this.consultWht,
    required this.introducedBirthPlan,
    required this.consultWhtOnChange,
    required this.introducedBirthPlanOnChange,
    required this.fundicHeightController,
    required this.bloodPressureController,
    required this.isFundicNormal,
    required this.isBloodPressureNormal,
    required this.advicesControllers,
    required this.servicesControllers,
  });

  final CareAndTest? data;
  final TrimesterEnum selectedTrimester;
  final Function(Object?) trimesterOnChange;
  final Function(bool) consultWhtOnChange;
  final Function(bool) introducedBirthPlanOnChange;

  final TextEditingController fundicHeightController;
  final TextEditingController bloodPressureController;

  final List<TextEditingController> advicesControllers;
  final List<TextEditingController> servicesControllers;

  final bool consultWht;
  final bool introducedBirthPlan;
  final bool isFundicNormal;
  final bool isBloodPressureNormal;

  @override
  State<CareAndTestsForm> createState() => _CareAndTestsFormState();
}

class _CareAndTestsFormState extends State<CareAndTestsForm> {
  final List<Map<String, dynamic>> trimesters = [
    {"value": TrimesterEnum.first, "label": TrimesterEnum.first.label},
    {"value": TrimesterEnum.second, "label": TrimesterEnum.second.label},
    {"value": TrimesterEnum.third, "label": TrimesterEnum.third.label},
  ];

  void handleConsultWhtValue(bool? v) {
    if (v == null) return;
    widget.consultWhtOnChange(v);
  }

  void handleIntroducedBirthPlanValue(bool? v) {
    if (v == null) return;
    widget.introducedBirthPlanOnChange(v);
  }

  @override
  Widget build(BuildContext context) {
    return CustomSection(
      title: "Care and Tests",
      headerSpacing: 4,
      children: [
        // trimester selector
        CustomDropdownButton(
          value: widget.selectedTrimester,
          data: trimesters,
          onChange: widget.trimesterOnChange,
        ),
        const SizedBox(),
        // // checkbox
        CustomSection(
          alignment: CrossAxisAlignment.start,
          description: const Text(
              "Check the item if it applies to your current prenatal care status",
              style: TextStyle(fontStyle: FontStyle.italic)),
          headerSpacing: 1,
          childrenSpacing: 1,
          children: [
            CustomCheckbox(
                label:
                    "The women's Health team WHT will help me in my Pregnancyif there's anything I want to know I will consult",
                value: widget.consultWht,
                onChange: handleConsultWhtValue),
            CustomCheckbox(
                label: "WTH introduce & helped me accomplished my birth plan",
                value: widget.introducedBirthPlan,
                onChange: handleIntroducedBirthPlanValue),
          ],
        ),
        // // findings section
        CustomSection(
          title: "Findings",
          titleStyle: const TextStyle(
            fontSize: 8 * 3,
          ),
          headerSpacing: 1,
          childrenSpacing: 1,
          children: [
            CustomInput.inline(
                controller: widget.fundicHeightController,
                label: "Fundic height",
                isNormal: widget.isFundicNormal,
                suffixText: "cm"),
            CustomInput.inline(
                controller: widget.bloodPressureController,
                label: "Blood pressure",
                isNormal: widget.isBloodPressureNormal,
                suffixText: "mmHg"),
          ],
        ),
        const SizedBox(),
        // // advice section
        CustomSection(
          title: "Advice",
          titleStyle: const TextStyle(
            fontSize: 8 * 3,
          ),
          headerSpacing: 1,
          childrenSpacing: 1,
          children: [
            ...widget.advicesControllers.map((controller) => Row(
                  spacing: 4 * 2,
                  children: [
                    const Icon(
                      Icons.circle,
                      size: 4 * 3,
                    ),
                    CustomInput.inline(
                      hint: "Type the advice here",
                      controller: controller,
                    )
                  ],
                )),
          ],
        ),
        // Services section
        CustomSection(
          title: "Services",
          titleStyle: const TextStyle(
            fontSize: 8 * 3,
          ),
          headerSpacing: 1,
          childrenSpacing: 1,
          children: [
            ...widget.servicesControllers.map((controller) => Row(
                  spacing: 4 * 2,
                  children: [
                    const Icon(
                      Icons.circle,
                      size: 4 * 3,
                    ),
                    // Text(
                    //   content,
                    //   style: TextStyle(fontSize: 4 * 4),
                    // ),
                    CustomInput.inline(
                      hint: "Type the services here",
                      controller: controller,
                    )
                  ],
                )),
          ],
        ),
      ],
    );
  }
}
