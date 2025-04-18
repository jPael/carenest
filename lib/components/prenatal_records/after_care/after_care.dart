import 'package:flutter/material.dart';
import 'package:smartguide_app/components/prenatal_records/after_care/after_care_iron_supplement_item.dart';
import 'package:smartguide_app/components/prenatal_records/after_care/after_care_tt_immunization_item.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/after_care.dart' as model;

class AfterCare extends StatelessWidget {
  const AfterCare({super.key, required this.afterCare});

  final model.AfterCare afterCare;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2 * 8),
      child: CustomSection(
        title: "After Care",
        // action: IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Icons.edit,
        //       size: 4 * 5,
        //     )),
        children: [
          CustomSection(
            title: "TT Immunization",
            titleStyle: const TextStyle(fontSize: 4 * 5, fontWeight: FontWeight.w500),
            children: [
              AfterCareTtImmunizationItem.header(
                  context: context, description: "TT term", value: "Date"),
              ...afterCare.immunzation.map(
                (e) => AfterCareTtImmunizationItem(
                  description: "TT${e.term}",
                ),
              )
              // AfterCareTtImmunizationItem(
              //   description: "TT1",
              //   date: DateTime.now(),
              // ),
              // AfterCareTtImmunizationItem(
              //   description: "TT2",
              //   date: DateTime.now(),
              // ),
              // AfterCareTtImmunizationItem(
              //   description: "TT3",
              //   date: DateTime.now(),
              // ),
            ],
          ),
          const SizedBox(
            height: 4 * 2,
          ),
          CustomSection(
            title: "Iron Supplement",
            titleStyle: const TextStyle(fontSize: 4 * 5, fontWeight: FontWeight.w500),
            children: [
              AfterCareIronSupplementItem.header(
                  context: context, description: "Date", value: "Tabs"),
              ...afterCare.ironSupplement.map(
                (e) => AfterCareIronSupplementItem(tabs: e.tabs),
              )
              // AfterCareIronSupplementItem(date: DateTime.now(), tabs: 3),
              // AfterCareIronSupplementItem(date: DateTime.now(), tabs: 1),
              // AfterCareIronSupplementItem(date: DateTime.now(), tabs: 3),
            ],
          )
        ],
      ),
    );
  }
}
