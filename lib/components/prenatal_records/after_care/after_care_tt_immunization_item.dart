import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AfterCareTtImmunizationItem extends StatelessWidget {
  const AfterCareTtImmunizationItem({super.key, required this.description, required this.date});

  final String description;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              "$description: ",
              style: TextStyle(fontSize: 4 * 4, fontWeight: FontWeight.bold),
            )),
        Expanded(flex: 3, child: Text(DateFormat("MMMM dd, yyyy").format(date)))
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
