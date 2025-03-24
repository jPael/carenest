import 'package:flutter/material.dart';
import 'package:smartguide_app/components/checklist/custom_checklist.dart';

class PatientsInfoBloodDonorsItem extends StatelessWidget {
  const PatientsInfoBloodDonorsItem(
      {super.key, required this.fullname, required this.phoneNumber, required this.verified});

  final String fullname;
  final String phoneNumber;
  final bool verified;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fullname,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 4 * 6),
        ),
        Text(
          phoneNumber,
          style: TextStyle(fontSize: 4 * 5),
        ),
        const SizedBox(
          height: 4 * 1,
        ),
        CustomChecklist(
          label: "Blood type verified",
          labelStyle: TextStyle(fontSize: 4 * 4, fontWeight: FontWeight.w500),
          checked: verified,
          iconSize: 4 * 5,
        )
      ],
    );
  }
}
