// import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/checklist/custom_checkbox.dart';
import 'package:smartguide_app/components/form/custom_form.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/input/datepicker.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/clinic_view.dart/clinic_visit_dropdown.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/clinic_view.dart/multi_data_input.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/clinic_view.dart/nutrition_status_dropdown.dart';
import 'package:smartguide_app/models/revamp/STI.dart';
import 'package:smartguide_app/models/revamp/clinic_history.dart';
import 'package:smartguide_app/models/revamp/counseling.dart';
import 'package:smartguide_app/models/revamp/first_trimester.dart';
import 'package:smartguide_app/models/revamp/laboratory.dart';
import 'package:smartguide_app/models/revamp/treatments.dart';
import 'package:smartguide_app/models/user.dart';

class FirstTrimesterVisitCreatePage extends StatefulWidget {
  const FirstTrimesterVisitCreatePage({super.key, required this.clinicHistory});

  final ClinicHistory clinicHistory;

  @override
  FirstTrimesterVisitCreatePageState createState() => FirstTrimesterVisitCreatePageState();
}

class FirstTrimesterVisitCreatePageState extends State<FirstTrimesterVisitCreatePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ClinicHistoryEnum checkup = ClinicHistoryEnum.first;
  final DateTime date = DateTime.now();

  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController gestationAgeController = TextEditingController();
  final TextEditingController bloodPressureController = TextEditingController();
  final TextEditingController birthPlanController = TextEditingController();
  final TextEditingController teetFindingsController = TextEditingController();
  final TextEditingController hemoglobinCountController = TextEditingController();
  final TextEditingController urinalysisController = TextEditingController();
  final TextEditingController completeBloodCountController = TextEditingController();
  final TextEditingController stoolExaminationController = TextEditingController();
  final TextEditingController aceticAcidWashController = TextEditingController();
  final TextEditingController nameHealthServiceProviderController = TextEditingController();
  final TextEditingController referralController = TextEditingController();
  final TextEditingController otherServicesController = TextEditingController();

  final List<Map<String, TextEditingController>> laboratoryControllers = List.generate(
      1, (i) => {"name": TextEditingController(), "description": TextEditingController()});
  final List<Map<String, TextEditingController>> stiControllers = List.generate(
      1, (i) => {"name": TextEditingController(), "description": TextEditingController()});
  final List<Map<String, TextEditingController>> treatmentControllers =
      List.generate(1, (i) => {"name": TextEditingController()});
  final List<Map<String, TextEditingController>> counselingControllers =
      List.generate(1, (i) => {"name": TextEditingController()});

  @override
  void dispose() {
    super.dispose();
    weightController.dispose();
    heightController.dispose();
    gestationAgeController.dispose();
    bloodPressureController.dispose();
    birthPlanController.dispose();
    teetFindingsController.dispose();
    hemoglobinCountController.dispose();
    urinalysisController.dispose();
    completeBloodCountController.dispose();
    stoolExaminationController.dispose();
    aceticAcidWashController.dispose();
    nameHealthServiceProviderController.dispose();
    referralController.dispose();
    otherServicesController.dispose();

    for (var c in laboratoryControllers) {
      c['name']!.dispose();
      c['descripiton']!.dispose();
    }
    for (var c in stiControllers) {
      c['name']!.dispose();
      c['description']!.dispose();
    }
    for (var c in treatmentControllers) {
      c['name']!.dispose();
    }
    for (var c in counselingControllers) {
      c['dispose']!.dispose();
    }
  }

  bool tetanusVaccine = false;

  DateTime tetanusVaccineDate = DateTime.now();
  DateTime returnDate = DateTime.now();

  NutritionalStatusEnum nutritionStatus = NutritionalStatusEnum.normal;

  bool isLoading = false;

  void handleSubmit() async {
    setState(() {
      isLoading = true;
    });

    final User user = context.read<User>();

    if (!formKey.currentState!.validate()) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    try {
      final FirstTrimester ft = FirstTrimester(
        clinicVisitId: widget.clinicHistory.id,
        checkUp: checkup,
        weight: double.parse(weightController.text),
        height: double.parse(heightController.text),
        ageGestation: int.parse(gestationAgeController.text),
        bloodPressure: bloodPressureController.text,
        nutritionalStatus: nutritionStatus,
        birthPlan: birthPlanController.text,
        teethFindings: teetFindingsController.text,
        hemoglobinCount: hemoglobinCountController.text,
        urinalysis: urinalysisController.text,
        completeBloodCount: completeBloodCountController.text,
        stoolExam: stoolExaminationController.text,
        aceticAcidWash: aceticAcidWashController.text,
        tetanusVaccine: tetanusVaccine,
        tetanusVaccineGivenAt: tetanusVaccineDate,
        returnDate: returnDate,
        healthServiceProviderId: user.laravelId!,
        hospitalReferral: referralController.text,
        otherServices: otherServicesController.text,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        laboratories: laboratoryControllers
            .map(
                (l) => Laboratory(name: l['name']!.text, description: l['description']?.text ?? ""))
            .toList(),
        stis: stiControllers
            .map((s) => Sti(name: s['name']!.text, description: s['description']?.text ?? ""))
            .toList(),
        treatments:
            treatmentControllers.map((t) => Treatment(description: t['name']!.text)).toList(),
        counselings:
            counselingControllers.map((c) => Counseling(description: c['name']!.text)).toList(),
      );

      await ft.store(token: user.token!);

      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
    } finally {
      log("finally");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    final User user = context.read<User>();

    nameHealthServiceProviderController.text = "${user.firstname!} ${user.lastname!}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("First Trimester | ${checkup.label}"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0 * 2),
            child: Form(
              key: formKey,
              child: CustomForm(childrenSpacing: 8, actions: [
                CustomButton(
                  isLoading: isLoading,
                  onPress: handleSubmit,
                  label: "Submit",
                )
              ], children: [
                ClinicHistoryEnumDropdown(
                    defaultValue: checkup,
                    onChange: (ClinicHistoryEnum? c) {
                      setState(() {
                        checkup = c ?? ClinicHistoryEnum.first;
                      });
                    }),
                Text(
                  "Clinic Date: ${DateFormat("EEEE MMMM, dd yyyy").format(date)}",
                  style: const TextStyle(fontSize: 4 * 4),
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomInput.text(
                  context: context,
                  label: "Weight",
                  textInputType: TextInputType.number,
                  controller: weightController,
                  suffixText: "kg",
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "This is required!";
                    }

                    return null;
                  },
                ),
                CustomInput.text(
                  context: context,
                  label: "Height",
                  controller: heightController,
                  suffixText: "ft",
                  hint: "00'00",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This is required!";
                    }

                    // Check if input is just digits (e.g., "5" or "05") → treated as feet only
                    if (RegExp(r'^\d+$').hasMatch(value)) {
                      final feet = int.tryParse(value);
                      if (feet == null || feet < 0) {
                        return "Feet must be a positive number";
                      }
                      return null; // Valid (feet only)
                    }

                    // Check if input is in feet'inches format (e.g., "5'9" or "05'09")
                    if (RegExp(r"\d+\'\d+$").hasMatch(value)) {
                      final parts = value.split('\'');
                      if (parts.length != 2) return "Use format: 00 or 00'00";

                      final feet = int.tryParse(parts[0]);
                      final inches = int.tryParse(parts[1]);

                      if (feet == null || inches == null) {
                        return "Feet and inches must be numbers";
                      }
                      if (feet < 0 || inches < 0 || inches >= 12) {
                        return "Feet must be ≥ 0, inches must be 0-11";
                      }
                      return null; // Valid (feet and inches)
                    }

                    // If neither format matches
                    return "Enter as 00 (feet only) or 00'00 (feet & inches)";
                  },
                ),
                CustomInput.text(
                  context: context,
                  label: "Age of Gestation",
                  textInputType: TextInputType.number,
                  controller: gestationAgeController,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "This is required!";
                    }

                    return null;
                  },
                ),
                CustomInput.text(
                  context: context,
                  label: "Blood Pressure",
                  textInputType: TextInputType.url,
                  controller: bloodPressureController,
                  suffixText: "mm Hg",
                  hint: "00/00",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This is required!";
                    }

                    // Check if input matches the "XX/XX" format (e.g., 120/80)
                    if (!RegExp(r'^\d{1,5}\/\d{1,5}$').hasMatch(value)) {
                      return "Enter in format 00/00 (e.g., 120/80)";
                    }

                    final parts = value.split('/');
                    if (parts.length != 2) {
                      return "Must contain one '/' (e.g., 120/80)";
                    }

                    // Parse systolic (first number) and diastolic (second number)
                    final systolic = int.tryParse(parts[0]);
                    final diastolic = int.tryParse(parts[1]);

                    if (systolic == null || diastolic == null) {
                      return "Both values must be numbers";
                    }
                    return null;
                  },
                ),
                NutritionStatusEnumDropdown(onChange: (NutritionalStatusEnum? n) {
                  setState(() {
                    nutritionStatus = n ?? NutritionalStatusEnum.normal;
                  });
                }),
                const SizedBox(
                  height: 8,
                ),
                CustomInput.text(
                  context: context,
                  label: "Birth Plan",
                  controller: birthPlanController,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "This is required!";
                    }

                    return null;
                  },
                ),
                CustomInput.text(
                  context: context,
                  label: "Teeth Findings",
                  controller: teetFindingsController,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "This is required!";
                    }

                    return null;
                  },
                ),
                MultiDataInput(
                  context: context,
                  controllers: laboratoryControllers,
                  title: "Laboratory Test(s) Done",
                  handleAddController: () {
                    setState(() {
                      laboratoryControllers.add({
                        "name": TextEditingController(),
                        "description": TextEditingController()
                      });
                    });
                  },
                  handleRemoveController: (i) {
                    setState(() {
                      laboratoryControllers.removeAt(i);
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomInput.text(
                  context: context,
                  label: "Hemoglobin Count",
                  controller: hemoglobinCountController,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "This is required!";
                    }

                    return null;
                  },
                ),
                CustomInput.text(
                  context: context,
                  label: "Urinalysis",
                  controller: urinalysisController,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "This is required!";
                    }

                    return null;
                  },
                ),
                CustomInput.text(
                  context: context,
                  label: "Complete Blood Count",
                  controller: completeBloodCountController,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "This is required!";
                    }

                    return null;
                  },
                ),
                MultiDataInput(
                  context: context,
                  title: "STI(s) Using the Syndromic Approach",
                  controllers: stiControllers,
                  handleAddController: () {
                    setState(() {
                      stiControllers.add({
                        "name": TextEditingController(),
                        "description": TextEditingController()
                      });
                    });
                  },
                  handleRemoveController: (i) {
                    setState(() {
                      laboratoryControllers.removeAt(i);
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomInput.text(
                  context: context,
                  label: "Stool Exam",
                  controller: stoolExaminationController,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "This is required!";
                    }

                    return null;
                  },
                ),
                CustomInput.text(
                  context: context,
                  label: "Acetic Acid Wash",
                  controller: aceticAcidWashController,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "This is required!";
                    }

                    return null;
                  },
                ),
                CustomCheckbox(
                  value: tetanusVaccine,
                  label: "Tetanus-containing Vaccine",
                  onChange: (bool? v) {
                    setState(() {
                      tetanusVaccine = v ?? false;
                    });
                  },
                ),
                if (tetanusVaccine)
                  CustomInput.datepicker(
                      context: context,
                      type: DatePickerEnum.text,
                      selectedDate: tetanusVaccineDate,
                      onChange: (DateTime v) {
                        setState(() {
                          tetanusVaccineDate = v;
                        });
                      }),
                MultiDataInput(
                  context: context,
                  title: "Treatments",
                  controllers: treatmentControllers,
                  handleAddController: () {
                    setState(() {
                      treatmentControllers.add({"name": TextEditingController()});
                    });
                  },
                  handleRemoveController: (i) {
                    setState(() {
                      treatmentControllers.removeAt(i);
                    });
                  },
                ),
                MultiDataInput(
                  context: context,
                  title: "Discussed Services Provided",
                  controllers: counselingControllers,
                  handleAddController: () {
                    setState(() {
                      counselingControllers.add({"name": TextEditingController()});
                    });
                  },
                  handleRemoveController: (i) {
                    setState(() {
                      counselingControllers.removeAt(i);
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomInput.datepicker(
                    context: context,
                    label: "Return Date",
                    onChange: (DateTime v) {
                      setState(() {
                        returnDate = v;
                      });
                    }),
                CustomInput.text(
                  context: context,
                  label: "Name of the Health Service Provider",
                  controller: nameHealthServiceProviderController,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "This is required!";
                    }

                    return null;
                  },
                ),
                CustomInput.text(
                  context: context,
                  label: "Hospital Referral",
                  controller: referralController,
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "This is required!";
                    }

                    return null;
                  },
                ),
                CustomInput.text(
                  context: context,
                  label: "Other Services",
                  controller: otherServicesController,
                ),
              ]),
            ),
          ),
        ));
  }
}
