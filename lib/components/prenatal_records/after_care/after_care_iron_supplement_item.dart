import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AfterCareIronSupplementItem extends StatelessWidget {
  const AfterCareIronSupplementItem({super.key, this.date, required this.tabs});

  final DateTime? date;
  final int tabs;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            date != null ? DateFormat("MMMM dd, yyyy").format(date!) : "NA",
            style: const TextStyle(fontSize: 4 * 4, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
            flex: 2,
            child: Text(
              tabs.toString(),
              style: const TextStyle(fontSize: 4 * 4),
            ))
      ],
    );
  }

  static Widget header(
      {required BuildContext context, required String description, required String value}) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(description)),
        Expanded(flex: 2, child: Text(value))
      ],
    );
  }
}
