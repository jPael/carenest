import 'package:flutter/material.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/form/custom_form.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/prenatal_records/form/after_care_form.dart';
import 'package:smartguide_app/components/prenatal_records/form/birth_plan_form.dart';
import 'package:smartguide_app/components/prenatal_records/form/care_and_tests_form.dart';
import 'package:smartguide_app/components/section/custom_section.dart';

enum TrimesterEnum { first, second, third }

class PrenatalInfoForm extends StatefulWidget {
  const PrenatalInfoForm({super.key});

  @override
  State<PrenatalInfoForm> createState() => _PrenatalInfoFormState();
}

class _PrenatalInfoFormState extends State<PrenatalInfoForm> {
  // form data
  late TrimesterEnum selectedTrimester;
  bool consultWht = false;
  bool introducedBirthPlan = false;
  final TextEditingController fundicHeightController = TextEditingController();
  bool fundicNormal = false;
  final TextEditingController bloodPressureController = TextEditingController();
  bool bloodPressureNormal = false;

  final List<TextEditingController> advicesControllers =
      List.generate(3, (i) => TextEditingController());
  final List<TextEditingController> servicesControllers =
      List.generate(3, (i) => TextEditingController());

  final TextEditingController birthplaceController = TextEditingController();
  final TextEditingController assignedByController = TextEditingController();
  final TextEditingController accompaniedByController = TextEditingController();

  // form data

  void trimesterOnChange(TrimesterEnum value) {
    setState(() {
      selectedTrimester = value;
    });
  }

  final List<Map<String, dynamic>> trimesters = [
    {
      "label": "First Trimester",
      "value": TrimesterEnum.first,
    },
    {
      "label": "Second Trimester",
      "value": TrimesterEnum.second,
    },
    {
      "label": "Third Trimester",
      "value": TrimesterEnum.third,
    },
  ];

  @override
  void initState() {
    super.initState();
    selectedTrimester = trimesters.first["value"];
  }

  @override
  void dispose() {
    fundicHeightController.dispose();
    bloodPressureController.dispose();
    birthplaceController.dispose();
    assignedByController.dispose();
    accompaniedByController.dispose();
    for (var controller in advicesControllers) {
      controller.dispose();
    }
    for (var controller in servicesControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(4 * 2),
        child: CustomForm(actions: [
          CustomButton(
            onPress: () {},
            label: "Submit",
            verticalPadding: 2,
            horizontalPadding: 5,
          )
        ], children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0 * 2),
              child: CareAndTestsForm(
                fundicHeightController: fundicHeightController,
                isFundicNormal: fundicNormal,
                bloodPressureController: bloodPressureController,
                isBloodPressureNormal: bloodPressureNormal,
                advicesControllers: advicesControllers,
                servicesControllers: servicesControllers,
                introducedBirthPlanOnChange: (value) {
                  setState(() {
                    introducedBirthPlan = value!;
                  });
                },
                introducedBirthPlan: introducedBirthPlan,
                consultWhtOnChange: (value) {
                  setState(() {
                    consultWht = value!;
                  });
                },
                consultWht: consultWht,
                selectedTrimester: selectedTrimester,
                dropdownOnChange: (value) => trimesterOnChange(value as TrimesterEnum),
                trimesters: trimesters,
              ),
            ),
          ),
          const SizedBox(height: 4 * 2),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0 * 2),
              child: BirthPlanForm(
                  birthplaceController: birthplaceController,
                  assignedByController: assignedByController,
                  accompaniedByController: accompaniedByController),
            ),
          ),
          const SizedBox(height: 4 * 2),
          Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0 * 2),
            child: AfterCareForm(),
          ))
        ]),
      ),
    );
  }
}
