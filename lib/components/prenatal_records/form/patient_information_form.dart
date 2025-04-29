import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/barangay/barangay_selector.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/checklist/custom_checkbox.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/patient_information.dart';
import 'package:smartguide_app/models/user.dart';

class PatientInformationForm extends StatefulWidget {
  // const PatientInformationForm({super.key});

  const PatientInformationForm({
    super.key,
    required this.data,
    required this.fullnameController,
    required this.ageController,
    required this.obStatusController,
    required this.onBarangayChange,
    required this.onBirthdayChange,
    required this.onLmpChange,
    required this.onEdcChange,
    required this.onPhilhealthChange,
    required this.onNhtsChange,
    required this.philhealth,
    required this.nhts,
    required this.donorFullnameController,
    required this.donorContactController,
    required this.donorBloodTyped,
    required this.onDonorBloodTypeChange,
    required this.birthday,
    required this.lmp,
    required this.edc,
    required this.isReadonly,
  });
  final bool isReadonly;

  final PatientInformation? data;
  final TextEditingController fullnameController;
  final TextEditingController ageController;
  final TextEditingController obStatusController;
  final TextEditingController donorFullnameController;
  final TextEditingController donorContactController;
  final Function(String?, String?) onBarangayChange;
  final Function(DateTime) onBirthdayChange;
  final Function(DateTime) onLmpChange;
  final Function(DateTime) onEdcChange;
  final bool philhealth;
  final bool nhts;
  final bool donorBloodTyped;
  final Function(bool) onPhilhealthChange;
  final Function(bool) onNhtsChange;
  final Function(bool) onDonorBloodTypeChange;
  final DateTime? birthday;
  final DateTime? lmp;
  final DateTime? edc;

  @override
  State<PatientInformationForm> createState() => _PatientInformationFormState();
}

class _PatientInformationFormState extends State<PatientInformationForm> {
  bool isExpanded = true;

  void handleBirthdayValue(DateTime d) {
    if (widget.isReadonly) return;
    widget.onBirthdayChange(d);
  }

  void handlePhilhealthValue(bool? v) {
    if (widget.isReadonly || v == null) return;
    widget.onPhilhealthChange(v);
  }

  void handleNhtsValue(bool? v) {
    if (widget.isReadonly || v == null) return;
    widget.onNhtsChange(v);
  }

  void handleBloodTypeValue(bool? v) {
    if (widget.isReadonly || v == null) return;
    widget.onDonorBloodTypeChange(v);
  }

  @override
  Widget build(BuildContext context) {
    final User user = context.read<User>();

    // handleBirthdayValue(DateTime.parse(user.dateOfBirth!));

    return CustomSection(
      title: "My Information",
      // action: CustomButton(
      //     horizontalPadding: 1,
      //     verticalPadding: 1,
      //     icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
      //     onPress: () {
      //       setState(() {
      //         isExpanded = !isExpanded;
      //       });
      //     },
      //     label: isExpanded ? "Collapse" : "Expand"),
      children: [
        AnimatedCrossFade(
          firstChild: Column(
            spacing: 8 * 2,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(),
              CustomInput.text(
                  readonly: widget.isReadonly,
                  context: context,
                  controller: widget.fullnameController,
                  label: "Fullname"),
              CustomInput.text(
                  textInputType: const TextInputType.numberWithOptions(),
                  readonly: widget.isReadonly,
                  context: context,
                  controller: widget.ageController,
                  label: "Age"),
              CustomInput.text(
                  readonly: widget.isReadonly,
                  context: context,
                  controller: widget.obStatusController,
                  label: "OB Status"),
              BarangaySelector(
                readonly: widget.isReadonly,
                onChange: widget.onBarangayChange,
                barangayName: user.address,
              ),
              CustomInput.datepicker(
                readonly: widget.isReadonly,
                context: context,
                label: "Date of birth",
                selectedDate: widget.birthday,
                onChange: handleBirthdayValue,
              ),
              CustomInput.datepicker(
                  context: context,
                  readonly: widget.isReadonly,
                  label: "My Last Menstrual Period (LMP)",
                  onChange: widget.onLmpChange,
                  selectedDate: widget.data?.lmp),
              CustomInput.datepicker(
                  context: context,
                  readonly: widget.isReadonly,
                  label: "I am expected to Give Birth to my Child (EDC) on",
                  onChange: widget.onEdcChange,
                  selectedDate: widget.data?.edc),
              CustomCheckbox(
                label: "PhilHealth",
                value: widget.philhealth,
                onChange: handlePhilhealthValue,
              ),
              CustomCheckbox(
                label: "NHTS",
                value: widget.nhts,
                onChange: handleNhtsValue,
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
                      readonly: widget.isReadonly,
                      context: context,
                      controller: widget.donorFullnameController,
                      label: "Full name"),
                  CustomInput.text(
                      context: context,
                      readonly: widget.isReadonly,
                      controller: widget.donorContactController,
                      label: "Contact number"),
                  CustomCheckbox(
                      label: "Blood type verified",
                      value: widget.donorBloodTyped,
                      onChange: handleBloodTypeValue),
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
