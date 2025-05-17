import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/alert/alert.dart';
import 'package:smartguide_app/components/barangay/barangay_selector.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/form/custom_form.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/models/revamp/person_history.dart';
import 'package:smartguide_app/services/laravel/prenatal_services.dart';
import 'package:smartguide_app/services/laravel/revamp/prenatal_service.dart';
import 'package:smartguide_app/utils/utils.dart';

import '../../../models/user.dart';

class CreateNewPrenatalPage extends StatefulWidget {
  const CreateNewPrenatalPage({super.key, required this.person});

  final PersonHistory person;
  @override
  CreateNewPrenatalPageState createState() => CreateNewPrenatalPageState();
}

class CreateNewPrenatalPageState extends State<CreateNewPrenatalPage> {
  final PrenatalServices prenatalServices = PrenatalServices();

  bool isLoading = false;
  Map<String, dynamic>? prenatalData;
  bool isSubmitting = false;

  Future<void> handleSubmit() async {
    if (birthday == null) {
      Alert.showErrorMessage(message: "Please enter your birthday");
      return;
    }

    final User user = context.read<User>();
    setState(() {
      isSubmitting = true;
    });
    try {
      await createClinicHistory(
          philhealh: philhealthController.text,
          nhts: nhtsController.text,
          obStatus: obStatusController.text,
          dateOfBirth: birthday!,
          lmp: lmp!,
          barangay: barangayController.text,
          edc: edc!,
          userId: widget.person.userId,
          token: user.token!);
    } catch (e, stackTrace) {
      Alert.showErrorMessage(message: "Something went wrong. Please try again");
      log(e.toString(), stackTrace: stackTrace);
    }

    setState(() {
      isSubmitting = false;
    });
  }

  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController obStatusController = TextEditingController();
  final TextEditingController barangayController = TextEditingController();

  DateTime? birthday;
  DateTime? lmp;
  DateTime? edc;

  final TextEditingController philhealthController = TextEditingController();
  final TextEditingController nhtsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    fullnameController.text = widget.person.user?.name ?? "";
    ageController.text = widget.person.user?.birthday != null
        ? calculateAge(widget.person.user!.birthday!).toString()
        : "";
    obStatusController.text = widget.person.obStatus;
    log("${widget.person.user?.birthday}");
    // log("${widget.person.user?.barangay?.name}");
    barangayController.text = widget.person.user?.barangay?.name ?? "";
    birthday = widget.person.user?.birthday;
    lmp = widget.person.lmp;
    edc = widget.person.edc;

    philhealthController.text = widget.person.philHealth;
    nhtsController.text = widget.person.nhts;
  }

  @override
  void dispose() {
    super.dispose();
    fullnameController.dispose();
    ageController.dispose();
    obStatusController.dispose();
    barangayController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Prenatal Record"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4 * 4),
          child: isLoading
              ? const Center(
                  child: SizedBox.square(
                    dimension: 8 * 4,
                    child: CircularProgressIndicator(),
                  ),
                )
              : CustomForm(
                  headerSpacing: 0.5,
                  childrenSpacing: 8 * 2,
                  label: "Patient Information",
                  actions: [
                      CustomButton(
                        onPress: handleSubmit,
                        label: "Submit",
                        isLoading: isSubmitting,
                        verticalPadding: 1,
                        horizontalPadding: 3,
                      )
                    ],
                  children: [
                      CustomInput.text(
                        context: context,
                        label: "Fullname",
                        controller: fullnameController,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "This is required!";
                          }

                          return null;
                        },
                      ),
                      CustomInput.text(
                        context: context,
                        label: "Age",
                        controller: ageController,
                        textInputType: TextInputType.number,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "This is required!";
                          }

                          return null;
                        },
                      ),
                      BarangaySelector(
                          barangayName: barangayController.text,
                          onChange: (String? barangayName, String? barangayId) {
                            barangayController.text = barangayName ?? "";
                          }),
                      // CustomInput.text(
                      //   context: context,
                      //   label: "Barangay",
                      //   controller: barangayController,
                      //   validator: (p0) {
                      //     if (p0 == null || p0.isEmpty) {
                      //       return "This is required!";
                      //     }

                      //     return null;
                      //   },
                      // ),
                      CustomInput.datepicker(
                          context: context,
                          label: "Date of Birth",
                          selectedDate: birthday,
                          onChange: (DateTime v) {
                            setState(() {
                              birthday = v;
                            });
                          }),
                      CustomInput.datepicker(
                          context: context,
                          label: "Last Menstrual Period (LMP)",
                          selectedDate: lmp,
                          onChange: (DateTime v) {
                            setState(() {
                              lmp = v;
                            });
                          }),
                      CustomInput.datepicker(
                          context: context,
                          label: "I am expecting to give birth to my child: (EDC)",
                          selectedDate: edc,
                          onChange: (DateTime v) {
                            setState(() {
                              edc = v;
                            });
                          }),
                      CustomInput.text(
                        context: context,
                        label: "PhilHealth",
                        controller: philhealthController,
                      ),
                      CustomInput.text(
                        context: context,
                        label: "NHTS",
                        controller: nhtsController,
                      ),
                    ]),
        ),
      ),
    );
  }
}
