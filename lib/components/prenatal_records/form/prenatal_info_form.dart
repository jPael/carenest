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
import 'package:smartguide_app/models/after_care.dart';
import 'package:smartguide_app/models/birth_plan.dart';
import 'package:smartguide_app/models/care_and_test.dart';
import 'package:smartguide_app/models/counseling.dart';
import 'package:smartguide_app/models/patient_information.dart';
import 'package:smartguide_app/models/prenatal.dart';
import 'package:smartguide_app/models/trimester.dart';
import 'package:smartguide_app/services/laravel/prenatal_services.dart';
import 'package:smartguide_app/utils/date_utils.dart';

import '../../../models/user.dart';

class PrenatalInfoForm extends StatefulWidget {
  const PrenatalInfoForm({super.key});

  @override
  State<PrenatalInfoForm> createState() => _PrenatalInfoFormState();
}

class _PrenatalInfoFormState extends State<PrenatalInfoForm> {
  final PrenatalServices prenatalServices = PrenatalServices();

  bool isLoading = true;
  Map<String, dynamic>? prenatalData;
  bool isSubmitting = false;

  Future<void> handleSubmit() async {
    setState(() {
      isSubmitting = true;
    });
    try {
      final User user = context.read<User>();

      final Prenatal prenatal = Prenatal(
          laravelId: user.laravelId!,
          selectedTrimester: selectedTrimester,
          consultWht: consultWht,
          introducedBirthPlan: introducedBirthPlan,
          fundicHeight: fundicHeightController.text,
          fundicNormal: isFundicNormal,
          bloodPressure: bloodPressureController.text,
          bloodPressureNormal: isBloodPressureNormal,
          advices: adviceControllers.map((a) => a.text).toList(),
          services: serviceControllers.map((a) => a.text).toList(),
          birthplace: birthPlaceController.text,
          ttItems: ttItems,
          ironSuppItems: ironSuppItems,
          barangay: barangayController.text,
          birthday: birthday!,
          patientInformation: PatientInformation(
              philhealth: philhealth,
              nhts: nhts,
              lmp: lmp!,
              edc: edc!,
              obStatus: obStatusController.text,
              assignById: int.parse(assignedByController.text),
              accompanyById: int.parse(accompaniedByController.text)),
          fullname: fullnameController.text,
          age: ageController.text,
          breastFeeding: questionaire[0]['value'],
          familyPlanning: questionaire[1]['value'],
          properNutrition: null,
          properNutritionForChild: questionaire[2]['value'],
          properNutritionForMyself: questionaire[3]['value'],
          donorFullname: donorFullnameController.text,
          donorContact: donorContactController.text,
          donorBloodTyped: donorTyped);

      final res = await prenatal.storeRecord();

      if (res['success'] == true) {
        showSuccessMessage(
            context: context, message: "Your prenatal has been updated successfully");
      } else {
        showErrorMessage(context: context, message: "Something went wrong. Please try again");
      }
    } catch (e, stackTrace) {
      showErrorMessage(context: context, message: "Something went wrong. Please try again");
      log(e.toString(), stackTrace: stackTrace);
    }

    setState(() {
      isSubmitting = false;
    });
  }

  // patient info
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController obStatusController = TextEditingController();
  final TextEditingController barangayController = TextEditingController();
  final TextEditingController donorFullnameController = TextEditingController();
  final TextEditingController donorContactController = TextEditingController();

  DateTime? birthday;
  DateTime? lmp;
  DateTime? edc;

  bool philhealth = false;
  bool nhts = false;
  bool donorTyped = false;
  // patient info

  // care and test info

  final TextEditingController fundicHeightController = TextEditingController();
  final TextEditingController bloodPressureController = TextEditingController();

  List<TextEditingController> adviceControllers = [];
  List<TextEditingController> serviceControllers = List.generate(1, (i) => TextEditingController());

  TrimesterEnum selectedTrimester = TrimesterEnum.first;

  bool consultWht = false;
  bool introducedBirthPlan = false;
  bool isFundicNormal = false;
  bool isBloodPressureNormal = false;

  // care and test info

  // birth plan

  final TextEditingController birthPlaceController = TextEditingController();
  final TextEditingController assignedByController = TextEditingController();
  final TextEditingController accompaniedByController = TextEditingController();

  // birth plan
  // after care

  List<Map<String, dynamic>> ttItems = [];
  List<Map<String, dynamic>> ironSuppItems = [];

  // after care
  // counseling

  final List<Map<String, dynamic>> questionaire = [
    {"id": "breastfeeding", "description": "Breastfeeding", "value": false},
    {"id": "familyplanning", "description": "Family Planning", "value": false},
    {
      "id": "childProperNutrition",
      "description": "Child is having proper nutrition",
      "value": false
    },
    {"id": "selfProperNutrition", "description": "I am having proper nutrition", "value": false},
  ];

  // counseling

  Future<void> fetchPrenatalInformation() async {
    final User user = context.read<User>();

    final Map<String, dynamic>? data =
        await prenatalServices.fetchLatestPatientInformationByToken(user.token!, user.laravelId!);

    setState(() {
      prenatalData = data;
      isLoading = false;
    });
  }

  void initData() {
    setState(() {
      final User user = context.read<User>();

      final PatientInformation? pi = prenatalData?['patientInformation'];

      birthday = DateTime.parse(user.dateOfBirth!);
      fullnameController.text = "${user.firstname} ${user.lastname}";
      ageController.text = calculateAge(DateTime.parse(user.dateOfBirth!)).toString();
      obStatusController.text = pi?.obStatus ?? "";
      lmp = pi?.lmp;
      edc = pi?.edc;
      philhealth = pi?.philhealth ?? false;
      nhts = pi?.nhts ?? false;

      donorFullnameController.text = pi?.bloodDonor?.fullname ?? "";
      donorContactController.text = pi?.bloodDonor?.contactNumber ?? "";
      donorTyped = pi?.bloodDonor?.bloodTyped ?? false;

      final CareAndTest? cat = prenatalData?['careAndTest'];

      selectedTrimester = cat?.trimester ?? TrimesterEnum.first;
      consultWht = cat?.consultWht ?? false;
      introducedBirthPlan = cat?.introducedBirthPlann ?? false;
      fundicHeightController.text = cat?.fundicHeight ?? "";
      bloodPressureController.text = cat?.bloodPressure ?? "";
      isFundicNormal = cat?.isFundicNormal ?? false;
      isBloodPressureNormal = cat?.isBloodPressureNormal ?? false;

      adviceControllers = cat?.advices
              .map(
                (e) => TextEditingController(text: e),
              )
              .toList() ??
          List.generate(1, (i) => TextEditingController());
      serviceControllers = cat?.services
              .map(
                (e) => TextEditingController(text: e),
              )
              .toList() ??
          List.generate(1, (i) => TextEditingController());

      final BirthPlan? bp = prenatalData?['birthPlan'];

      birthPlaceController.text = bp?.birthplace ?? "";
      assignedByController.text = bp?.assignedBy.id.toString() ?? "";
      accompaniedByController.text = bp?.accompaniedBy.id.toString() ?? "";

      final AfterCare? af = prenatalData?['afterCare'];

      af?.immunzation.forEach((d) => ttItems.add({
            "term": d.term,
            "datetime": d.date,
          }));

      af?.ironSupplement.forEach(
          (d) => ironSuppItems.add({"iron_supplement_no_tabs": d.tabs, "datetime": d.date}));
    });

    final Counseling? c = prenatalData?['counseling'];

    questionaire[0]['value'] = c?.breastFeeding ?? false;
    questionaire[1]['value'] = c?.familyPlanning ?? false;
    questionaire[2]['value'] = c?.childProperNutrition ?? false;
    questionaire[3]['value'] = c?.selfProperNutrition ?? false;
  }

  @override
  void initState() {
    super.initState();
    fetchPrenatalInformation().then(
      (value) {
        initData();
      },
    );

    // log(prenatalData?['careAndTest'].toString() ?? "");

    // handleBirthplaceChange(data?.birthplace, null);
    // handleAssignedByChange(data?.assignedBy.id.toString());
    // handleAccompaniedByChange(data?.accompaniedBy.id.toString());
  }

  @override
  void dispose() {
    super.dispose();
    fullnameController.dispose();
    ageController.dispose();
    obStatusController.dispose();
    barangayController.dispose();
    donorFullnameController.dispose();
    donorContactController.dispose();
    fundicHeightController.dispose();
    bloodPressureController.dispose();
    birthPlaceController.dispose();
    assignedByController.dispose();
    accompaniedByController.dispose();

    for (var a in adviceControllers) {
      a.dispose();
    }
    for (var a in serviceControllers) {
      a.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(4 * 2),
        child: isLoading
            ? const Center(
                child: SizedBox.square(
                  dimension: 8 * 4,
                  child: CircularProgressIndicator(),
                ),
              )
            : CustomForm(actions: [
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
                      birthday: birthday,
                      edc: edc,
                      lmp: lmp,
                      data: prenatalData?['patientInformation'],
                      ageController: ageController,
                      fullnameController: fullnameController,
                      obStatusController: obStatusController,
                      onBarangayChange: (String? address, String? id) {
                        barangayController.text = address!;
                      },
                      onBirthdayChange: (DateTime d) {
                        setState(() {
                          birthday = d;
                        });
                      },
                      onLmpChange: (DateTime d) {
                        setState(() {
                          lmp = d;
                        });
                      },
                      onEdcChange: (DateTime d) {
                        setState(() {
                          edc = d;
                        });
                      },
                      philhealth: philhealth,
                      onPhilhealthChange: (bool v) {
                        setState(() {
                          philhealth = v;
                        });
                      },
                      nhts: nhts,
                      onNhtsChange: (bool v) {
                        setState(() {
                          nhts = v;
                        });
                      },
                      donorFullnameController: donorFullnameController,
                      donorContactController: donorContactController,
                      donorBloodTyped: donorTyped,
                      onDonorBloodTypeChange: (bool v) {
                        setState(() {
                          donorTyped = v;
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
                      data: prenatalData?['careAndTest'],
                      trimesterOnChange: (trimester) {
                        if (trimester == null) return;

                        setState(() {
                          selectedTrimester = (trimester as TrimesterEnum);
                        });
                      },
                      selectedTrimester: selectedTrimester,
                      consultWht: consultWht,
                      consultWhtOnChange: (bool v) {
                        setState(() {
                          consultWht = v;
                        });
                      },
                      introducedBirthPlan: introducedBirthPlan,
                      introducedBirthPlanOnChange: (bool v) {
                        setState(() {
                          introducedBirthPlan = v;
                        });
                      },
                      bloodPressureController: bloodPressureController,
                      fundicHeightController: fundicHeightController,
                      isFundicNormal: isFundicNormal,
                      isBloodPressureNormal: isBloodPressureNormal,
                      advicesControllers: adviceControllers,
                      servicesControllers: serviceControllers,
                    ),
                  ),
                ),
                const SizedBox(height: 4 * 2),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0 * 2),
                    child: BirthPlanForm(
                      data: prenatalData?['birthPlan'],
                      birthplaceController: birthPlaceController,
                      assignedByController: assignedByController,
                      accompaniedByController: accompaniedByController,
                    ),
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
                      questionaire: questionaire,
                      onChange: (String id, bool value) {
                        setState(() {
                          questionaire.firstWhere(
                            (item) => item['id'] == id,
                            orElse: () => throw Exception('Question ID not found'),
                          )['value'] = value;
                        });
                      },
                    ),
                  ),
                )
              ]),
      ),
    );
  }
}
