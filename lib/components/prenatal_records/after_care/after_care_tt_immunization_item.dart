import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AfterCareTtImmunizationItem extends StatelessWidget {
  const AfterCareTtImmunizationItem({super.key, required this.description, this.date});

  final String description;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              "$description: ",
              style: const TextStyle(fontSize: 4 * 4, fontWeight: FontWeight.bold),
            )),
        Expanded(
            flex: 3, child: Text(date != null ? DateFormat("MMMM dd, yyyy").format(date!) : "NA"))
      ],
    );
  }

  static Widget header(
      {required BuildContext context, required String description, required String value}) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              description,
            )),
        Expanded(flex: 3, child: Text(value))
      ],
    );
  }
}
