import 'package:flutter/material.dart';

class CareAndTestsFindingsItem extends StatelessWidget {
  const CareAndTestsFindingsItem(
      {super.key,
      required this.description,
      required this.value,
      required this.remarksDescription,
      required this.remarksValue,
      required this.unit});

  final String description;
  final String value;
  final String unit;
  final String remarksDescription;
  final String remarksValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Text(
              "$description: ",
              style: TextStyle(fontSize: 4 * 4, fontWeight: FontWeight.w500),
            )),
        Expanded(flex: 1, child: Text("$value $unit")),
        Expanded(
            flex: 1,
            child: Row(
              spacing: 4,
              children: [
                Text(
                  "$remarksDescription: ",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(remarksValue),
              ],
            )),
      ],
    );
  }
}
