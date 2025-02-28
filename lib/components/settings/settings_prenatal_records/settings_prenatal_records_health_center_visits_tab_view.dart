import 'package:flutter/material.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/section/custom_section.dart';

class SettingsPrenatalRecordsHealthCenterVisitsTabView extends StatelessWidget {
  SettingsPrenatalRecordsHealthCenterVisitsTabView({super.key});

  final DateTime dateOfFirstVisit = DateTime.now();
  final DateTime dateOfLastDelivery = DateTime.now();
  final List<DateTime> dateOfVisits = [DateTime.now(), DateTime.now()];

  @override
  Widget build(BuildContext context) {
    return CustomSection(
      title: "Health Center Visits",
      children: [
        CustomInput.datepicker(
            context: context,
            onChange: (e) {},
            label: "First Visit",
            selectedDate: dateOfFirstVisit),
        CustomInput.datepicker(
            context: context,
            onChange: (e) {},
            label: "Last Delivery",
            selectedDate: dateOfLastDelivery),
        CustomSection(
          title: "Visits",
          titleStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 8 * 3),
          children: [
            ...dateOfVisits.map((d) => CustomInput.datepicker(
                  context: context,
                  selectedDate: d,
                  onChange: (p0) {},
                ))
          ],
        )
      ],
    );
  }
}
