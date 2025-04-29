import 'package:flutter/material.dart';
import 'package:smartguide_app/components/barangay/barangay_selector.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/prenatal_records/form/midwife_selector.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/birth_plan.dart';

class BirthPlanForm extends StatelessWidget {
  const BirthPlanForm(
      {super.key,
      required this.birthplaceController,
      required this.assignedByController,
      required this.accompaniedByController,
      required this.data,
      this.isReadonly = false});

  final BirthPlan? data;

  final bool isReadonly;

  final TextEditingController birthplaceController;
  final TextEditingController assignedByController;
  final TextEditingController accompaniedByController;

  void handleBirthplaceChange(String? barangayName, String? barangayId) {
    if (isReadonly) return;

    birthplaceController.text = barangayName ?? "";
  }

  void handleAssignedByChange(String? v) {
    if (isReadonly || v == null) return;

    assignedByController.text = v;
  }

  void handleAccompaniedByChange(String? v) {
    if (isReadonly || v == null) return;

    accompaniedByController.text = v;
  }

  @override
  Widget build(BuildContext context) {
    return CustomSection(
      title: "Birth Plan",
      headerSpacing: 4,
      children: [
        CustomInput.inline(
            readonly: isReadonly,
            label: "Birth place will take at",
            customInput: BarangaySelector(
              onChange: handleBirthplaceChange,
              readonly: isReadonly,
              barangayName: birthplaceController.text,
            )),
        CustomInput.inline(
            readonly: isReadonly,
            label: "Assigned by",
            customInput: MidwifeSelector(
              readonly: isReadonly,
              defaultValue: assignedByController.text,
              onChange: handleAssignedByChange,
            )),
        CustomInput.inline(
            readonly: isReadonly,
            controller: accompaniedByController,
            label: "Accompanied",
            customInput: MidwifeSelector(
              readonly: isReadonly,
              defaultValue: accompaniedByController.text,
              onChange: handleAccompaniedByChange,
            )),
      ],
    );
  }
}
