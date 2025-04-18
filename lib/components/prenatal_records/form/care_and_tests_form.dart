import 'package:flutter/material.dart';
import 'package:smartguide_app/components/button/custom_dropdown_button.dart';
import 'package:smartguide_app/components/checklist/custom_checkbox.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/trimester.dart';

class CareAndTestsForm extends StatefulWidget {
  const CareAndTestsForm(
      {super.key,
      required this.fundicHeightController,
      required this.isFundicNormal,
      required this.bloodPressureController,
      required this.isBloodPressureNormal,
      required this.advicesControllers,
      required this.servicesControllers,
      required this.introducedBirthPlan,
      required this.consultWht,
      required this.selectedTrimester,
      this.dropdownOnChange,
      required this.trimesters,
      this.introducedBirthPlanOnChange,
      this.consultWhtOnChange,
      required this.addAdvices,
      required this.addServices});

  final TextEditingController fundicHeightController;
  final bool isFundicNormal;
  final TextEditingController bloodPressureController;
  final bool isBloodPressureNormal;
  final List<TextEditingController> advicesControllers;
  final VoidCallback addAdvices;
  final List<TextEditingController> servicesControllers;
  final VoidCallback addServices;

  final Function(bool?)? introducedBirthPlanOnChange;
  final Function(bool?)? consultWhtOnChange;
  final bool introducedBirthPlan;
  final bool consultWht;
  final TrimesterEnum selectedTrimester;
  final Function(Object?)? dropdownOnChange;
  final List<Map<String, dynamic>> trimesters;

  @override
  State<CareAndTestsForm> createState() => _CareAndTestsFormState();
}

class _CareAndTestsFormState extends State<CareAndTestsForm> {
  @override
  Widget build(BuildContext context) {
    return CustomSection(
      title: "Care and Tests",
      headerSpacing: 4,
      children: [
        // trimester selector
        CustomDropdownButton(
          value: widget.selectedTrimester,
          data: widget.trimesters,
          onChange: widget.dropdownOnChange,
        ),
        const SizedBox(),
        // checkbox
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
                onChange: widget.consultWhtOnChange),
            CustomCheckbox(
                label: "WTH introduce & helped me accomplished my birth plan",
                value: widget.introducedBirthPlan,
                onChange: widget.introducedBirthPlanOnChange),
          ],
        ),
        // findings section
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
        // advice section
        CustomSection(
          title: "Advice",
          titleStyle: const TextStyle(
            fontSize: 8 * 3,
          ),
          headerSpacing: 1,
          childrenSpacing: 1,
          action: IconButton(
              onPressed: widget.addAdvices,
              icon: Icon(
                Icons.add_circle_outline,
                color: Theme.of(context).colorScheme.primary,
              )),
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
          action: IconButton(
              onPressed: widget.addServices,
              icon: Icon(
                Icons.add_circle_outline,
                color: Theme.of(context).colorScheme.primary,
              )),
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
