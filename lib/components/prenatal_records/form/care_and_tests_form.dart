import 'package:flutter/material.dart';
import 'package:smartguide_app/components/button/custom_dropdown_button.dart';
import 'package:smartguide_app/components/checklist/custom_checkbox.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/care_and_test.dart';
import 'package:smartguide_app/models/trimester.dart';
import 'package:url_launcher/url_launcher.dart';

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
    required this.isReadonly,
  });

  final bool isReadonly;

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
    if (widget.isReadonly || v == null) return;
    widget.consultWhtOnChange(v);
  }

  void handleIntroducedBirthPlanValue(bool? v) {
    if (widget.isReadonly || v == null) return;
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
          readonly: widget.isReadonly,
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
                    "The women's Health team WHT will help me in my Pregnancyif there's anything I want to know I willconsult",
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
                readonly: widget.isReadonly,
                controller: widget.fundicHeightController,
                label: "Fundic height",
                isNormal: widget.isFundicNormal,
                suffixText: "cm"),
            fundicWarning(),
            // CustomInput.inline(
            //     readonly: widget.isReadonly,
            //     controller: widget.bloodPressureController,
            //     label: "Blood pressure",
            //     isNormal: widget.isBloodPressureNormal,
            //     suffixText: "mmHg"),
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
            ...widget.advicesControllers.map((controller) => CustomInput.text(
                readonly: widget.isReadonly,
                context: context,
                label: "I was advice to the following",
                hint: "Type the advice here",
                controller: controller,
                minLines: 3,
                maxLines: 5)),
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
            ...widget.servicesControllers.map((controller) => CustomInput.text(
                readonly: widget.isReadonly,
                context: context,
                label: "I was given the following services",
                hint: "Type the services here",
                controller: controller,
                minLines: 3,
                maxLines: 5)),
          ],
        ),
      ],
    );
  }

  Widget fundicWarning() {
    Future<void> _launchURL() async {
      const url = 'https://www.who.int/publications/i/item/9789241549912';
      final Uri uri = Uri.parse(url);
      try {
        await launchUrl(
          uri,
          mode: LaunchMode.externalNonBrowserApplication, // Android-only
        );
      } catch (e) {
        // Fallback to default browser
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.2),
          border: Border.all(color: Colors.redAccent.withValues(alpha: 0.4), width: 2),
          borderRadius: BorderRadius.circular(8 * 2)),
      padding: const EdgeInsets.all(8 * 2),
      child: Column(
        spacing: 8,
        children: [
          const Row(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline_rounded),
              Text(
                "When to Be Concerned?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 4 * 5),
              ),
            ],
          ),
          const Row(
            spacing: 4 * 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Icon(
                  Icons.circle,
                  size: 4 * 2,
                ),
              ),
              Flexible(
                child: Text(
                    "Fundic height calculation are less accurate in obese women, fibroids, or multiple pregnancies"),
              ),
            ],
          ),
          const Row(
            spacing: 4 * 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Icon(
                  Icons.circle,
                  size: 4 * 2,
                ),
              ),
              Flexible(
                child: Text(
                    "After 36 weeks, the fundal height may not increase (or even decrease slightly) as the baby engages in the pelvis"),
              ),
            ],
          ),
          const Row(
            spacing: 4 * 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Icon(
                  Icons.circle,
                  size: 4 * 2,
                ),
              ),
              Flexible(
                child: Text(
                    "If the fundal height is >3 cm off from gestational age, further evaluation (ultrasound, amniotic fluid assessment) may be needed."),
              ),
            ],
          ),
          const Row(
            spacing: 4 * 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Icon(
                  Icons.circle,
                  size: 4 * 2,
                ),
              ),
              Flexible(
                child: Text("Consistently abnormal measurements may require fetal monitoring"),
              ),
            ],
          ),
          const Row(
            spacing: 4 * 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Icon(
                  Icons.circle,
                  size: 4 * 2,
                ),
              ),
              Flexible(
                child: Text("Normal Range = (Gestational Age in Weeks) ± 2 cm"),
              ),
            ],
          ),
          const Row(
            spacing: 4 * 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  "Source:",
                ),
              ),
            ],
          ),
          Row(
            spacing: 4 * 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: GestureDetector(
                  onTap: _launchURL,
                  child: const Text(
                    "https://www.who.int/publications/i/item/9789241549912",
                    style: TextStyle(fontStyle: FontStyle.italic),
                    softWrap: true,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
