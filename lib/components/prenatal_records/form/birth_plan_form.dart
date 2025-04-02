import 'package:flutter/material.dart';
import 'package:smartguide_app/components/barangay/barangay_selector.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/prenatal_records/form/midwife_selector.dart';
import 'package:smartguide_app/components/section/custom_section.dart';

class BirthPlanForm extends StatelessWidget {
  const BirthPlanForm(
      {super.key,
      required this.birthplaceController,
      required this.assignedByController,
      required this.accompaniedByController});

  final TextEditingController birthplaceController;
  final TextEditingController assignedByController;
  final TextEditingController accompaniedByController;

  void handleBirthplaceChange(String? value) {
    birthplaceController.text = value ?? "";
  }

  void handleAssignedByChange(String? value) {
    assignedByController.text = value ?? "";
  }

  void handleAccompaniedByChange(String? value) {
    accompaniedByController.text = value ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return CustomSection(
      title: "Birth Plan",
      headerSpacing: 4,
      children: [
        CustomInput.inline(
            label: "Birth place will take at",
            customInput: BarangaySelector(
              onChange: handleBirthplaceChange,
            )),
        CustomInput.inline(
            label: "Assigned by",
            customInput: MidwifeSelector(
              onChange: handleAssignedByChange,
            )),
        CustomInput.inline(
            controller: accompaniedByController,
            label: "Accompanied",
            customInput: MidwifeSelector(
              onChange: handleAccompaniedByChange,
            )),
      ],
    );
  }
}
