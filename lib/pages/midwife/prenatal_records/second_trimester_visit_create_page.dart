import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/form/custom_form.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/clinic_view.dart/clinic_visit_dropdown.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/clinic_view.dart/multiDataInput.dart';
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
      List.generate(0, (i) => {"name": TextEditingController()});

  final List<Map<String, TextEditingController>> laboratoryControllers = List.generate(
      0, (i) => {"name": TextEditingController(), "description": TextEditingController()});
  final List<Map<String, TextEditingController>> treatmentControllers =
      List.generate(0, (i) => {"name": TextEditingController()});
  final List<Map<String, TextEditingController>> counselingControllers =
      List.generate(0, (i) => {"name": TextEditingController()});

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
    final User user = context.read<User>();

    setState(() {
      isLoading = true;
    });

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
      treatments: treatmentControllers.map((m) => Treatment(description: m['name']!.text)).toList(),
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

    setState(() {
      isLoading = false;
    });
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
              textInputType: TextInputType.number,
              controller: heightController,
              suffixText: "ft",
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return "This is required!";
                }

                return null;
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
              textInputType: TextInputType.number,
              controller: bloodPressureController,
              suffixText: "mm Hg",
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return "This is required!";
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
