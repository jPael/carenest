import 'package:flutter/material.dart';
import 'package:smartguide_app/components/barangay/barangay_selector.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/prenatal_records/form/midwife_selector.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/birth_plan.dart';

class BirthPlanForm extends StatelessWidget {
  const BirthPlanForm({
    super.key,
    required this.birthplaceController,
    required this.assignedByController,
    required this.accompaniedByController,
    required this.data,
  });

  final BirthPlan? data;

  final TextEditingController birthplaceController;
  final TextEditingController assignedByController;
  final TextEditingController accompaniedByController;

  void handleBirthplaceChange(String? barangayName, String? barangayId) {
    birthplaceController.text = barangayName ?? "";
  }

  void handleAssignedByChange(String? v) {
    if (v == null) return;

    assignedByController.text = v;
  }

  void handleAccompaniedByChange(String? v) {
    if (v == null) return;

    accompaniedByController.text = v;
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
              barangayName: birthplaceController.text,
            )),
        CustomInput.inline(
            label: "Assigned by",
            customInput: MidwifeSelector(
              defaultValue: assignedByController.text,
              onChange: handleAssignedByChange,
            )),
        CustomInput.inline(
            controller: accompaniedByController,
            label: "Accompanied",
            customInput: MidwifeSelector(
              defaultValue: accompaniedByController.text,
              onChange: handleAccompaniedByChange,
            )),
      ],
    );
  }
}
