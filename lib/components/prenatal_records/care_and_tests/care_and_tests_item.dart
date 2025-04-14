import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class CareAndTestItem extends StatelessWidget {
  CareAndTestItem(
      {super.key,
      required this.description,
      this.isTrue = false,
      this.type = CareTestItemEnum.checklist,
      DateTime? date})
      : date = date ?? DateTime.now();

  final String description;
  final bool isTrue;
  final DateTime date;
  final CareTestItemEnum type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case CareTestItemEnum.checklist:
        return checklist(context: context, description: description, isTrue: isTrue);
      case CareTestItemEnum.careItemDates:
        return careItemDates(context: context, description: description, date: DateTime.now());
    }
  }

  Widget checklist(
      {required BuildContext context, required String description, required bool isTrue}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: 40,
                child: isTrue
                    ? const Icon(
                        Ionicons.checkmark_circle,
                        color: Colors.green,
                      )
                    : const Icon(
                        Ionicons.close_circle,
                        color: Colors.red,
                      )),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    softWrap: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget careItemDates(
      {required BuildContext context, required String description, required DateTime date}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$description: ",
              softWrap: true,
              style: const TextStyle(fontSize: 4 * 4, fontWeight: FontWeight.w500),
            ),
            Text(
              DateFormat("MMMM dd, yyyy").format(date),
              softWrap: true,
              style: const TextStyle(fontSize: 4 * 4),
            ),
          ],
        ),
      ],
    );
  }
}

enum CareTestItemEnum { checklist, careItemDates }
