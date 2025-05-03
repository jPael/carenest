import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartguide_app/components/alert/alert.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/form/custom_form.dart';
import 'package:smartguide_app/components/prenatal_records/form/after_care_form.dart';
import 'package:smartguide_app/components/prenatal_records/form/birth_plan_form.dart';
import 'package:smartguide_app/components/prenatal_records/form/care_and_tests_form.dart';
import 'package:smartguide_app/components/prenatal_records/form/counseling_form.dart';
import 'package:smartguide_app/components/prenatal_records/form/patient_information_form.dart';
import 'package:smartguide_app/models/clinic_visit.dart';
import 'package:smartguide_app/models/patient_information.dart';
import 'package:smartguide_app/models/person.dart';
import 'package:smartguide_app/models/prenatal.dart';
import 'package:smartguide_app/models/trimester.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/services/laravel/prenatal_services.dart';
import 'package:smartguide_app/services/user_services.dart';
import 'package:smartguide_app/utils/date_utils.dart';

class AddClinicVisitFormPage extends StatefulWidget {
  const AddClinicVisitFormPage({
    super.key,
    required this.prenatal,
  });

  final Prenatal prenatal;

  @override
  AddClinicVisitFormPageState createState() => AddClinicVisitFormPageState();
}

class AddClinicVisitFormPageState extends State<AddClinicVisitFormPage> {
  final PrenatalServices prenatalServices = PrenatalServices();

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

  List<TextEditingController> adviceControllers = List.generate(1, (i) => TextEditingController());
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

  bool isLoading = true;
  Map<String, dynamic>? prenatalData;
  Person? userData;

  Future<void> fetchPrenatalInformation() async {
    final User user = context.read<User>();

    final Map<String, dynamic>? patientInformationData = await prenatalServices
        .fetchLatestPatientInformationByToken(user.token!, widget.prenatal.laravelId!);

    final Person? userInformationData =
        await getUserByLaravelId(laravelId: widget.prenatal.laravelId!);

    setState(() {
      prenatalData = patientInformationData;
      userData = userInformationData;
      isLoading = false;
    });
  }

  void initData() {
    setState(() {
      final User user = context.read<User>();

      final PatientInformation? pi = prenatalData?['patientInformation'];

      birthday = DateTime.parse(user.dateOfBirth!).toLocal();
      fullnameController.text = userData?.name ?? "NA";
      ageController.text = calculateAge(userData!.birthday!).toString();
      obStatusController.text = pi?.obStatus ?? "";
      lmp = pi?.lmp;
      edc = pi?.edc;
      philhealth = pi?.philhealth ?? false;
      nhts = pi?.nhts ?? false;

      donorFullnameController.text = pi?.bloodDonor?.fullname ?? "";
      donorContactController.text = pi?.bloodDonor?.contactNumber ?? "";
      donorTyped = pi?.bloodDonor?.bloodTyped ?? false;
    });
  }

  bool isSubmitting = false;

  Future<void> handleSubmit() async {
    final User user = context.read<User>();

    setState(() {
      isSubmitting = true;
    });

    try {
      log(widget.prenatal.id!.toString());
      final ClinicVisit clinicVisit = ClinicVisit(
          userId: widget.prenatal.laravelId!,
          //just to fill it out it doesnt affect anything
          id: 0,
          birthplace: birthPlaceController.text,
          trimester: selectedTrimester,
          consulWht: consultWht,
          whtIntroducedBirthPlan: introducedBirthPlan,
          fundicHeigh: int.tryParse(fundicHeightController.text) ?? 0,
          patientInformationId: widget.prenatal.id!,
          assignedBy: Person(id: int.tryParse(assignedByController.text) ?? 0),
          accompanyBy: Person(id: int.tryParse(accompaniedByController.text) ?? 0),
          services: serviceControllers.first.text,
          advices: adviceControllers.first.text,
          ttImunizations: ttItems.first['term'],
          ironSupplementNoTabs: ironSuppItems.first['iron_supplement_no_tabs'],
          isBreastFeeding: questionaire[0]['value'],
          isFamilyPlanning: questionaire[1]['value'],
          isChildProperNutrition: questionaire[2]['value'],
          isSelfProperNutrition: questionaire[3]['value'],
          midwifeId: user.laravelId!);

      final res = await clinicVisit.storeRecord(token: user.token!);

      if (res['success'] == true) {
        Alert.showSuccessMessage(message: "Your prenatal has been updated successfully");
        Navigator.pop(context);
      } else {
        Alert.showErrorMessage(message: "Something went wrong. Please try again");
      }
    } catch (e, stackTrace) {
      Alert.showErrorMessage(message: "Something went wrong. Please try again");
      log(e.toString(), stackTrace: stackTrace);
    }
  }

  @override
  void initState() {
    super.initState();

    fetchPrenatalInformation().then(
      (value) {
        initData();
      },
    );
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Create clinic visit"),
      ),
      body: SingleChildScrollView(
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
                        isReadonly: true,
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
                        isReadonly: false,
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
                        isReadonly: false,
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
                      isReadonly: false,
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
                        isReadonly: false,
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
      ),
    );
  }
}
