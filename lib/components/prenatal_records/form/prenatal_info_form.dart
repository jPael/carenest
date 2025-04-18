import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/alert/alert.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/form/custom_form.dart';
import 'package:smartguide_app/components/prenatal_records/form/after_care_form.dart';
import 'package:smartguide_app/components/prenatal_records/form/birth_plan_form.dart';
import 'package:smartguide_app/components/prenatal_records/form/care_and_tests_form.dart';
import 'package:smartguide_app/components/prenatal_records/form/counseling_form.dart';
import 'package:smartguide_app/components/prenatal_records/form/patient_information_form.dart';
import 'package:smartguide_app/models/prenatal.dart';
import 'package:smartguide_app/models/trimester.dart';

import '../../../models/user.dart';

class PrenatalInfoForm extends StatefulWidget {
  const PrenatalInfoForm({super.key});

  @override
  State<PrenatalInfoForm> createState() => _PrenatalInfoFormState();
}

class _PrenatalInfoFormState extends State<PrenatalInfoForm> {
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

  final List<Map<String, dynamic>> counselingQuestionaire = [
    {"id": "breastFeeding", "description": "Breastfeeding", "value": false},
    {"id": "familyPlanning", "description": "Family Planning", "value": false},
    {"id": "properNutrition", "description": "Proper Nutrition", "value": false},
    {"id": "child", "description": "My Child", "value": false},
    {"id": "self", "description": "My Self", "value": false},
  ];

  // final TextEditingController forMyChildController = TextEditingController();
  // final TextEditingController forMyselfController = TextEditingController();

  void counselingOnChange(String id, bool value) {
    setState(() {
      for (var item in counselingQuestionaire) {
        if (item['id'] == id) {
          item['value'] = value;
          break;
        }
      }
    });
  }

  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController obStatusController = TextEditingController();
  //  blood donors

  final TextEditingController donorFullnameController = TextEditingController();
  final TextEditingController donorContactController = TextEditingController();
  // final TextEditingController donorBloodTypeController = TextEditingController();
  bool donorBloodTyped = false;

  //  blood donors

  String barangay = "";
  bool philHealth = false;
  bool nhts = false;
  DateTime expectedDateOfConfinement = DateTime.now();
  DateTime birthday = DateTime.now();
  DateTime lastMenstrualPeriod = DateTime.now();

  final List<Map<String, dynamic>> ttItems = [];
  // final List<Map<String, dynamic>> ttItems =
  //     List.generate(5, (i) => {"description": "TT${i + 1}", "datetime": DateTime.now()});

  // final List<Map<String, dynamic>> ironSuppItems =
  //     List.generate(5, (i) => {"tabs": Random().nextInt(10) + 1, "datetime": DateTime.now()});
  final List<Map<String, dynamic>> ironSuppItems = [];

  bool isSubmitting = false;

  Future<void> handleSubmit() async {
    final user = context.read<User>();

    final Prenatal record = Prenatal(
        donorBloodTyped: donorBloodTyped,
        donorContact: donorContactController.text,
        donorFullname: donorFullnameController.text,
        breastFeeding: counselingQuestionaire[0]["value"],
        familyPlanning: counselingQuestionaire[1]["value"],
        properNutrition: counselingQuestionaire[2]["value"],
        properNutritionForChild: counselingQuestionaire[3]["value"],
        properNutritionForMyself: counselingQuestionaire[4]["value"],
        age: ageController.text,
        fullname: fullnameController.text,
        obStatus: obStatusController.text,
        barangay: barangay,
        birthday: birthday,
        expectedDateOfConfinement: expectedDateOfConfinement,
        lastMenstrualPeriod: lastMenstrualPeriod,
        nhts: nhts,
        philhealth: philHealth,
        laravelId: user.laravelId!,
        ironSuppItems: ironSuppItems,
        ttItems: ttItems,
        selectedTrimester: selectedTrimester,
        consultWht: consultWht,
        introducedBirthPlan: introducedBirthPlan,
        fundicHeight: fundicHeightController.text,
        fundicNormal: fundicNormal,
        bloodPressure: bloodPressureController.text,
        bloodPressureNormal: bloodPressureNormal,
        advices: advicesControllers.map((c) => c.text).toList(),
        services: servicesControllers.map((c) => c.text).toList(),
        birthplace: birthplaceController.text,
        assignedBy: assignedByController.text,
        accompaniedBy: accompaniedByController.text);

    try {
      setState(() {
        isSubmitting = true;
      });

      final Map<String, dynamic> res = await record.storeRecord();

      if (!mounted) return;

      if (res['success']) {
        showSuccessMessage(context: context, message: res['message']);
      } else {
        showErrorMessage(context: context, message: res['message']);
      }
    } catch (e, stackTrace) {
      log("There was an error saving prenatal record: $e", stackTrace: stackTrace);
      if (!mounted) return;
      showErrorMessage(
          context: context,
          message: "There was an error on submitting your record please try again");
    } finally {
      if (mounted) {
        setState(() {
          isSubmitting = false;
        });
      }
    }
  }

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
    donorFullnameController.dispose();
    donorContactController.dispose();
    // donorBloodTyped.dispose();
    // forMyChildController.dispose();
    // forMyselfController.dispose();
    fullnameController.dispose();
    ageController.dispose();
    obStatusController.dispose();

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
            onPress: handleSubmit,
            label: "Submit",
            isLoading: isSubmitting,
            verticalPadding: 2,
            horizontalPadding: 5,
          )
        ], children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0 * 2),
              child: PatientInformationForm(
                bloodTypeOnChange: (value) {
                  setState(() {
                    donorBloodTyped = value!;
                  });
                },
                fullnameController: fullnameController,
                ageController: ageController,
                obStatusController: obStatusController,
                donorFullnameController: donorFullnameController,
                donorContactController: donorContactController,
                donorBloodTyped: donorBloodTyped,
                barangay: barangay,
                philHealth: philHealth,
                nhts: nhts,
                expectedDateOfConfinement: expectedDateOfConfinement,
                birthday: birthday,
                lastMenstrualPeriod: lastMenstrualPeriod,
                onBarangayChange: (barangay) {
                  setState(() {
                    this.barangay = barangay!;
                  });
                },
                birthdayOnChange: (value) {
                  setState(() {
                    birthday = value!;
                  });
                },
                lmpOnChange: (value) {
                  setState(() {
                    lastMenstrualPeriod = value!;
                  });
                },
                edcOnChange: (value) {
                  setState(() {
                    expectedDateOfConfinement = value!;
                  });
                },
                philHealthOnChange: (value) {
                  setState(() {
                    philHealth = value!;
                  });
                },
                nhtsOnChange: (value) {
                  setState(() {
                    nhts = value!;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 4 * 2),
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
                addAdvices: () {
                  setState(() {
                    advicesControllers.add(TextEditingController());
                  });
                },
                addServices: () {
                  setState(() {
                    servicesControllers.add(TextEditingController());
                  });
                },
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
            child: AfterCareForm(
              ttItems: ttItems,
              ironSuppItems: ironSuppItems,
            ),
          )),
          const SizedBox(
            height: 4 * 2,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0 * 2),
              child: CounselingForm(
                questionaire: counselingQuestionaire,
                onChange: counselingOnChange,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
