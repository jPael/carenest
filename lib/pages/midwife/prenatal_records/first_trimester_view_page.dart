import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/clinic_view.dart/first_trimester_check_up_selector_dropdown.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/clinic_view.dart/item_group.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/clinic_view.dart/test_item.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/revamp/clinic_history.dart';
import 'package:smartguide_app/models/revamp/first_trimester.dart';

class FirstTrimesterViewPage extends StatefulWidget {
  FirstTrimesterViewPage({
    super.key,
    required this.trimesters,
    required this.defaultSelected,
  });
  final List<FirstTrimester> trimesters;
  final int defaultSelected;
  @override
  State<FirstTrimesterViewPage> createState() => _FirstTrimesterViewPageState();
}

class _FirstTrimesterViewPageState extends State<FirstTrimesterViewPage> {
  late FirstTrimester selected;

  @override
  void initState() {
    super.initState();
    selected = widget.trimesters[widget.defaultSelected];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FirstTrimesterCheckUpSelectorDropdown(
                onChange: (FirstTrimester? value) {
                  setState(() {
                    selected = value ?? widget.trimesters[widget.defaultSelected];
                  });
                },
                defaultValue: selected,
                checkUps: widget.trimesters,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8 * 3),
            child: CustomSection(
              title: "Clinic Date: ${DateFormat("EEEE MMMM, dd yyyy").format(selected.createdAt)}",
              titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 4 * 5),
              children: [
                TestItem(label: "Weight", value: selected.weight.toString(), unit: "kg"),
                TestItem(label: "Height", value: selected.height.toString(), unit: "ft"),
                TestItem(
                    label: "Age of Gestation",
                    value: selected.ageGestation.toString(),
                    unit: "weeks"),
                TestItem(label: "Blood Pressure", value: selected.bloodPressure, unit: "mm Hg"),
                TestItem(
                  label: "Nutrition Status",
                  value: selected.nutritionalStatus.laravelValue,
                ),
                TestItem(
                  label: "Birth plan",
                  value: selected.birthPlan,
                ),
                TestItem(
                  label: "Teeth Findings",
                  value: selected.teethFindings,
                ),
                ItemGroup(
                    title: "Laboratory Test(s) Done",
                    data: selected.laboratories.map((l) => l.name).toList(),
                    description: selected.laboratories.map((l) => l.description).toList()),
                TestItem(
                  label: "Hemoglobin Count",
                  value: selected.hemoglobinCount,
                ),
                TestItem(
                  label: "Urinalysis",
                  value: selected.urinalysis,
                ),
                TestItem(
                  label: "Complete Blood Count (CBC)",
                  value: selected.completeBloodCount,
                ),
                ItemGroup(
                    title: "STI(s) Using the Syndromic Approach",
                    data: selected.stis.map((l) => l.name).toList(),
                    description: selected.stis.map((l) => l.description).toList()),
                TestItem(
                  label: "Stool Examination",
                  value: selected.stoolExam,
                ),
                TestItem(
                  label: "Acetic Acid Wash",
                  value: selected.aceticAcidWash,
                ),
                TestItem(
                    label: "Tetanus-Containing Vaccine",
                    value: selected.tetanusVaccine ? "Done" : "Not applied",
                    description:
                        "Date given: ${DateFormat("EEEE dd, MM yyyy").format(selected.tetanusVaccineGivenAt)}"),
                ItemGroup(
                    title: "Treatments",
                    data: selected.treatments
                        .map(
                          (l) => l.description,
                        )
                        .toList()),
                ItemGroup(
                    title: "Discussed Services Provided",
                    data: selected.counselings
                        .map(
                          (c) => c.description,
                        )
                        .toList()),
                const SizedBox(
                  height: 8,
                ),
                TestItem(
                  label: "Return Date",
                  value: DateFormat("EEEE dd, MM yyyy").format(selected.returnDate),
                ),
                TestItem(
                  label: "Health Service Provider",
                  value: selected.healthServiceProvider?.name ?? "",
                ),
                TestItem(
                  label: "Hospital Referral",
                  value: selected.hospitalReferral,
                ),
                TestItem(
                  label: "Other Services",
                  value: selected.otherServices ?? "None",
                ),

                // ItemGroup(
                //     title: "Treatments",
                //     data: selected.treatments
                //         .map(
                //           (l) => l.description,
                //         )
                //         .toList()),
              ],
            ),
          ),
        ));
  }
}
