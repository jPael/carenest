import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/form/custom_form.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/clinic_view.dart/clinic_visit_dropdown.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/clinic_view.dart/multi_data_input.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/clinic_view.dart/nutrition_status_dropdown.dart';
import 'package:smartguide_app/models/revamp/advice.dart';
import 'package:smartguide_app/models/revamp/clinic_history.dart';
import 'package:smartguide_app/models/revamp/laboratory.dart';
import 'package:smartguide_app/models/revamp/second_trimester.dart';
import 'package:smartguide_app/models/revamp/treatments.dart';
import 'package:smartguide_app/models/revamp/counseling.dart';
import 'package:smartguide_app/models/user.dart';

class SecondTrimesterVisitCreatePage extends StatefulWidget {
  const SecondTrimesterVisitCreatePage({super.key, required this.clinicHistory});

  final ClinicHistory clinicHistory;

  @override
  SecondTrimesterVisitCreatePageState createState() => SecondTrimesterVisitCreatePageState();
}

class SecondTrimesterVisitCreatePageState extends State<SecondTrimesterVisitCreatePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ClinicHistoryEnum checkup = ClinicHistoryEnum.first;

  final DateTime date = DateTime.now();
  DateTime returnDate = DateTime.now();

  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController gestationAgeController = TextEditingController();
  final TextEditingController bloodPressureController = TextEditingController();
  final TextEditingController assessmentController = TextEditingController();
  final TextEditingController birthPlanChangesController = TextEditingController();
  final TextEditingController teethFindingsController = TextEditingController();
  final TextEditingController urinalysisController = TextEditingController();
  final TextEditingController completeBloodCountController = TextEditingController();
  final TextEditingController etiologicalTestController = TextEditingController();
  final TextEditingController papSmearController = TextEditingController();
  final TextEditingController gestationalDiabetesController = TextEditingController();
  final TextEditingController bacteriurController = TextEditingController();
  final TextEditingController nameHealthServiceProviderController = TextEditingController();
  final TextEditingController referralController = TextEditingController();
  final TextEditingController otherServicesController = TextEditingController();

  final List<Map<String, TextEditingController>> adviceController =
      List.generate(1, (i) => {"name": TextEditingController()});

  final List<Map<String, TextEditingController>> laboratoryControllers = List.generate(
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
    assessmentController.dispose();
    birthPlanChangesController.dispose();
    teethFindingsController.dispose();
    urinalysisController.dispose();
    completeBloodCountController.dispose();
    etiologicalTestController.dispose();
    papSmearController.dispose();
    gestationalDiabetesController.dispose();
    bacteriurController.dispose();
    nameHealthServiceProviderController.dispose();
    referralController.dispose();
    otherServicesController.dispose();

    for (var a in adviceController) {
      a['name']!.dispose();
    }
    for (var l in laboratoryControllers) {
      l['name']!.dispose();
      l['description']!.dispose();
    }

    for (var t in treatmentControllers) {
      t['name']!.dispose();
    }
    for (var c in counselingControllers) {
      c['name']!.dispose();
    }
  }

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
      final SecondTrimester st = SecondTrimester(
        clinicVisitId: widget.clinicHistory.id,
        checkUp: checkup,
        weight: double.parse(weightController.text),
        height: double.parse(heightController.text),
        ageGestation: int.parse(gestationAgeController.text),
        bloodPressure: bloodPressureController.text,
        nutritionalStatus: nutritionStatus,
        assessment: assessmentController.text,
        birthPlanChanges: birthPlanChangesController.text,
        teethFindings: teethFindingsController.text,
        urinalysis: urinalysisController.text,
        completeBloodCount: completeBloodCountController.text,
        stiEtiologicTest: etiologicalTestController.text,
        oralGlucoseTest: gestationAgeController.text,
        papSmear: papSmearController.text,
        returnDate: returnDate,
        healthServiceProviderId: user.laravelId!,
        hospitalReferral: referralController.text,
        notes: otherServicesController.text,
        advices: adviceController.map((a) => Advice(content: a['name']!.text)).toList(),
        laboratories: laboratoryControllers
            .map((l) => Laboratory(name: l['name']!.text, description: l['description']!.text))
            .toList(),
        treatments:
            treatmentControllers.map((m) => Treatment(description: m['name']!.text)).toList(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        bacteriuria: bacteriurController.text,
        counselings:
            counselingControllers.map((c) => Counseling(description: c['name']!.text)).toList(),
      );

      await st.store(token: user.token!);

      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
    } finally {
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
        title: Text("Second Trimester | ${checkup.label}"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0 * 2),
          child: Form(
              child: CustomForm(childrenSpacing: 8, actions: [
            CustomButton(
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
              hint: "00'00",
              suffixText: "ft",
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
              hint: "00/00",
              suffixText: "mm Hg",
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
              label: "Asseessment",
              controller: assessmentController,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return "This is required!";
                }

                return null;
              },
            ),
            MultiDataInput(
                context: context,
                title: "Advices",
                controllers: adviceController,
                handleAddController: () => {
                      setState(() {
                        adviceController.add({"name": TextEditingController()});
                      })
                    },
                handleRemoveController: (int i) {
                  setState(() {
                    adviceController.removeAt(i);
                  });
                }),
            CustomInput.text(
              context: context,
              label: "Changes in Birth Plan",
              controller: birthPlanChangesController,
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
              controller: teethFindingsController,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return "This is required!";
                }

                return null;
              },
            ),
            MultiDataInput(
                context: context,
                title: "Laboratory Test(s) Done",
                controllers: laboratoryControllers,
                handleAddController: () {
                  setState(() {
                    laboratoryControllers.add(
                        {'name': TextEditingController(), 'description': TextEditingController()});
                  });
                },
                handleRemoveController: (int i) {
                  setState(() {
                    laboratoryControllers.removeAt(i);
                  });
                }),
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
              label: "Complete Blood Count (CBC)",
              controller: completeBloodCountController,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return "This is required!";
                }

                return null;
              },
            ),
            CustomInput.text(
              context: context,
              label: "Etiological Tests (Optional)",
              controller: etiologicalTestController,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return "This is required!";
                }

                return null;
              },
            ),
            CustomInput.text(
              context: context,
              label: "Pap Smear (Optional)",
              controller: papSmearController,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return "This is required!";
                }

                return null;
              },
            ),
            CustomInput.text(
              context: context,
              label: "Gestational Diabetes (Oral Glucose Challenge Test) (Optional)",
              controller: gestationalDiabetesController,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return "This is required!";
                }

                return null;
              },
            ),
            CustomInput.text(
              context: context,
              label: "Bacteriur (Optional)",
              controller: bacteriurController,
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return "This is required!";
                }

                return null;
              },
            ),
            MultiDataInput(
                context: context,
                title: "Treatments",
                controllers: treatmentControllers,
                handleAddController: () {
                  setState(() {
                    treatmentControllers.add({"name": TextEditingController()});
                  });
                },
                handleRemoveController: (int i) {
                  setState(() {
                    treatmentControllers.removeAt(i);
                  });
                }),
            MultiDataInput(
                context: context,
                title: "Discussed Services Provided",
                controllers: counselingControllers,
                handleAddController: () {
                  setState(() {
                    counselingControllers.add({"name": TextEditingController()});
                  });
                },
                handleRemoveController: (int i) {
                  setState(() {
                    counselingControllers.removeAt(i);
                  });
                }),
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
          ])),
        ),
      ),
    );
  }
}
