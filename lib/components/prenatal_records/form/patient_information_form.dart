import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/barangay/barangay_selector.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/checklist/custom_checkbox.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/patient_information.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/services/laravel/prenatal_services.dart';

class PatientInformationForm extends StatefulWidget {
  // const PatientInformationForm({super.key});

  const PatientInformationForm({
    super.key,
    required this.fullnameController,
    required this.ageController,
    required this.obStatusController,
    required this.barangay,
    required this.philHealth,
    required this.nhts,
    required this.expectedDateOfConfinement,
    required this.birthday,
    required this.lastMenstrualPeriod,
    required this.onBarangayChange,
    required this.birthdayOnChange,
    required this.lmpOnChange,
    required this.edcOnChange,
    required this.philHealthOnChange,
    required this.nhtsOnChange,
    required this.donorFullnameController,
    required this.donorContactController,
    required this.donorBloodTyped,
    required this.bloodTypeOnChange,
  });

  final TextEditingController fullnameController;
  final TextEditingController ageController;
  final TextEditingController obStatusController;
  final TextEditingController donorFullnameController;
  final TextEditingController donorContactController;
  final bool donorBloodTyped;
  final Function(bool?) bloodTypeOnChange;
  final String barangay;
  final bool philHealth;
  final bool nhts;
  final DateTime expectedDateOfConfinement;
  final DateTime birthday;
  final DateTime lastMenstrualPeriod;
  final Function(String?) onBarangayChange;
  final Function(DateTime?) birthdayOnChange;
  final Function(DateTime?) lmpOnChange;
  final Function(DateTime?) edcOnChange;
  final Function(bool?) philHealthOnChange;
  final Function(bool?) nhtsOnChange;

  @override
  State<PatientInformationForm> createState() => _PatientInformationFormState();
}

class _PatientInformationFormState extends State<PatientInformationForm> {
  bool isExpanded = false;
  late User user;
  late DateTime userBirthday;
  String? userToken;

  Future<void> fetchPatientInformation() async {
    if (userToken == null) return;

    PrenatalServices prenatalServices = PrenatalServices();

    final PatientInformation pi = await prenatalServices.fetchPatientInformationByToken(userToken!);

    widget.obStatusController.text = pi.obStatus;
    log(DateFormat('MM dd, yyyy').format(pi.lmp));
    widget.lmpOnChange(pi.lmp);
    widget.edcOnChange(pi.edc);
    widget.philHealthOnChange(pi.philhealth);
    widget.nhtsOnChange(pi.nhts);
  }

  @override
  void initState() {
    super.initState();
    user = context.read<User>();
    userToken = user.token;
    userBirthday = DateTime.now();

    fetchPatientInformation();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.fullnameController.text = "${user.firstname!} ${user.lastname!}";
      userBirthday = user.dateOfBirth != null ? DateTime.parse(user.dateOfBirth!) : widget.birthday;
      widget.ageController.text =
          ((DateTime.now().difference(DateTime.tryParse(user.dateOfBirth!)!).inDays / 365.2425))
              .floor()
              .toString();
      widget.onBarangayChange(user.address);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomSection(
      title: "My Information",
      action: CustomButton(
          horizontalPadding: 1,
          verticalPadding: 1,
          icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
          onPress: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          label: isExpanded ? "Collapse" : "Expand"),
      children: [
        AnimatedCrossFade(
          firstChild: Column(
            spacing: 8 * 2,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(),
              CustomInput.text(
                  context: context, controller: widget.fullnameController, label: "Fullname"),
              CustomInput.text(context: context, controller: widget.ageController, label: "Age"),
              CustomInput.text(
                  context: context, controller: widget.obStatusController, label: "OB Status"),
              BarangaySelector(
                onChange: widget.onBarangayChange,
              ),
              CustomInput.datepicker(
                context: context,
                label: "Date of birth",
                selectedDate: userBirthday,
                onChange: widget.birthdayOnChange,
              ),
              CustomInput.datepicker(
                  context: context,
                  label: "My Last Menstrual Period (LMP)",
                  onChange: widget.lmpOnChange,
                  selectedDate: widget.lastMenstrualPeriod),
              CustomInput.datepicker(
                  context: context,
                  label: "I am expected to Give Birth to my Child (EDC) on",
                  onChange: widget.edcOnChange,
                  selectedDate: widget.expectedDateOfConfinement),
              CustomCheckbox(
                label: "PhilHealth",
                value: widget.philHealth,
                onChange: widget.philHealthOnChange,
              ),
              CustomCheckbox(
                label: "NHTS",
                value: widget.nhts,
                onChange: widget.nhtsOnChange,
              ),
              CustomSection(
                title: "Blood Donor",
                titleStyle: const TextStyle(
                  fontSize: 8 * 3,
                ),
                // headerSpacing: 1,
                childrenSpacing: 1,
                children: [
                  CustomInput.text(
                      context: context,
                      controller: widget.donorFullnameController,
                      label: "Full name"),
                  CustomInput.text(
                      context: context,
                      controller: widget.donorContactController,
                      label: "Contact number"),
                  CustomCheckbox(
                      label: "Blood type verified",
                      value: widget.donorBloodTyped,
                      onChange: widget.bloodTypeOnChange),
                  // CustomInput.text(
                  //     context: context, controller: widget.donorBloodTyped, label: "Blood type"),
                ],
              )
            ],
          ),
          secondChild: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  "Expand to fill out your personal information",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          ),
          crossFadeState: isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 300),
        )
      ],
    );
  }
}
