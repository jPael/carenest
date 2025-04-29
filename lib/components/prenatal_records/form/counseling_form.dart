import 'package:flutter/material.dart';
import 'package:smartguide_app/components/checklist/custom_checkbox.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/counseling.dart';

class CounselingForm extends StatelessWidget {
  const CounselingForm({
    super.key,
    this.data,
    required this.questionaire,
    // required this.questionaire,
    this.isReadonly = false,
    required this.onChange,
  });

  final Counseling? data;

  final bool isReadonly;

  final List<Map<String, dynamic>> questionaire;
  final Function(String, bool) onChange;

  // final TextEditingController forMyChildController;
  // final TextEditingController forMyselfController;

  @override
  Widget build(BuildContext context) {
    return CustomSection(
      title: "Counseling",
      headerSpacing: 4,
      children: [
        ...questionaire.take(2).map(
              (e) => CustomCheckbox(
                  readonly: isReadonly,
                  id: e["id"],
                  label: "${e["description"]}",
                  value: e["value"],
                  customOnChange: onChange),
            ),
        const Text("The counseling for proper nutrition has been completed"),
        ...questionaire.skip(2).map(
              (e) => CustomCheckbox(
                  readonly: isReadonly,
                  id: e["id"],
                  label: "${e["description"]} ",
                  value: e["value"],
                  customOnChange: onChange),
            ),
        // CustomInput.text(
        //     context: context, controller: forMyChildController, label: "For My Child", minLines: 3),
        // CustomInput.text(
        //     context: context, controller: forMyselfController, label: "For Myself", minLines: 3),
      ],
    );
  }
}
