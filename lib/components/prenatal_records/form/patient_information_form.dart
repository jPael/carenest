import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/barangay/barangay_selector.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
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
    required this.philhealthController,
    required this.nhtsController,
    required this.birthday,
    required this.lmp,
    required this.edc,
    required this.isReadonly,
    this.formKey,
    this.isSubmitting = false,
    this.handleSave,
  });
  final bool isReadonly;

  final PatientInformation? data;
  final TextEditingController fullnameController;
  final TextEditingController ageController;
  final TextEditingController obStatusController;
  final TextEditingController philhealthController;
  final TextEditingController nhtsController;
  final Function(String?, String?) onBarangayChange;
  final Function(DateTime) onBirthdayChange;
  final Function(DateTime) onLmpChange;
  final Function(DateTime) onEdcChange;
  final Function()? handleSave;
  final DateTime? birthday;
  final DateTime? lmp;
  final DateTime? edc;
  final GlobalKey<FormState>? formKey;
  final bool isSubmitting;

  @override
  State<PatientInformationForm> createState() => _PatientInformationFormState();
}

class _PatientInformationFormState extends State<PatientInformationForm> {
  bool isExpanded = true;

  void handleBirthdayValue(DateTime d) {
    if (widget.isReadonly) return;
    widget.onBirthdayChange(d);
  }

  @override
  Widget build(BuildContext context) {
    final User user = context.read<User>();

    // log((widget.edc == null).toString());

    return Form(
      key: widget.formKey,
      child: CustomSection(
        headerSpacing: 0,
        children: [
          Column(
            spacing: 8 * 2,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(),
              CustomInput.text(
                  readonly: widget.isReadonly,
                  context: context,
                  controller: widget.fullnameController,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Please enter your first name";
                    }

                    return null;
                  },
                  label: "Fullname"),
              CustomInput.text(
                  textInputType: const TextInputType.numberWithOptions(),
                  readonly: widget.isReadonly,
                  context: context,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Please enter your first name";
                    }

                    return null;
                  },
                  controller: widget.ageController,
                  label: "Age"),
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
                validator: (v) {
                  if (v == null || v.isEmpty || widget.birthday == null) {
                    return "Please enter your birthday";
                  }
                  return null;
                },
              ),
              CustomSection(
                  title: "Patient Information",
                  action: CustomButton(
                    isLoading: widget.isSubmitting,
                    onPress: widget.handleSave ?? () {},
                    label: "Update",
                    horizontalPadding: 2,
                    verticalPadding: 1,
                  ),
                  children: [
                    CustomInput.text(
                        readonly: widget.isReadonly,
                        context: context,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Please enter your first name";
                          }

                          return null;
                        },
                        controller: widget.obStatusController,
                        label: "OB Status"),
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
                    CustomInput.text(
                        readonly: widget.isReadonly,
                        context: context,
                        controller: widget.philhealthController,
                        label: "PhilHealth ID"),
                    CustomInput.text(
                        readonly: widget.isReadonly,
                        context: context,
                        controller: widget.nhtsController,
                        label: "NHTS ID"),
                  ])
            ],
          )
        ],
      ),
    );
  }
}
