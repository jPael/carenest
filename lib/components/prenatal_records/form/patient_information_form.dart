import 'package:flutter/material.dart';
import 'package:smartguide_app/components/barangay/barangay_selector.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/checklist/custom_checkbox.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/section/custom_section.dart';

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
    required this.donorBloodTypeController,
  });

  final TextEditingController fullnameController;
  final TextEditingController ageController;
  final TextEditingController obStatusController;
  final TextEditingController donorFullnameController;
  final TextEditingController donorContactController;
  final TextEditingController donorBloodTypeController;
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
              BarangaySelector(onChange: widget.onBarangayChange, value: widget.barangay),
              CustomInput.datepicker(
                context: context,
                label: "Date of birth",
                onChange: widget.birthdayOnChange,
              ),
              CustomInput.datepicker(
                context: context,
                label: "My Last Menstrual Period (LMP)",
                onChange: widget.lmpOnChange,
              ),
              CustomInput.datepicker(
                context: context,
                label: "I am expected to Give Birth to my Child (EDC) on",
                onChange: widget.edcOnChange,
              ),
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
                titleStyle: TextStyle(
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
                  CustomInput.text(
                      context: context,
                      controller: widget.donorBloodTypeController,
                      label: "Blood type"),
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
          duration: Duration(milliseconds: 300),
        )
      ],
    );
  }
}
