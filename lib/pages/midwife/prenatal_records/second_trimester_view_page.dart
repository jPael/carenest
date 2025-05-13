import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/clinic_view.dart/item_group.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/clinic_view.dart/second_trimester_check_up_selector_dropdown.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/clinic_view.dart/test_item.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/revamp/clinic_history.dart';
import 'package:smartguide_app/models/revamp/second_trimester.dart';

class SecondTrimesterViewPage extends StatefulWidget {
  const SecondTrimesterViewPage(
      {super.key, required this.trimesters, required this.defaultSelected});

  final List<SecondTrimester> trimesters;
  final int defaultSelected;

  @override
  State<SecondTrimesterViewPage> createState() => _SecondTrimesterViewPageState();
}

class _SecondTrimesterViewPageState extends State<SecondTrimesterViewPage> {
  late SecondTrimester selected;

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
            SecondTrimesterCheckUpSelectorDropdown(
              onChange: (SecondTrimester? value) {
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
              alignment: CrossAxisAlignment.start,
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
                  label: "Assessment",
                  value: selected.assessment,
                ),
                ItemGroup(title: "Advices", data: selected.advices.map((a) => a.content).toList()),
                TestItem(
                  label: "Changes in Birth Plan",
                  value: selected.birthPlanChanges,
                ),
                TestItem(
                  label: "Teeth Findings",
                  value: selected.teethFindings,
                ),
                ItemGroup(
                    title: "Laboratory Test(s) Done",
                    data: selected.laboratories.map((a) => a.name).toList(),
                    description: selected.laboratories.map((a) => a.description).toList()),
                TestItem(
                  label: "Urinalysis",
                  value: selected.urinalysis,
                ),
                TestItem(
                  label: "Etiological Tests (Optional)",
                  value: selected.stiEtiologicTest,
                ),
                TestItem(
                  label: "Pap Smear (Optional)",
                  value: selected.papSmear,
                ),
                TestItem(
                  label: "Gestational Diabetes (Oral Glucose Challenge Test) (Optional)",
                  value: selected.oralGlucoseTest,
                ),
                TestItem(
                  label: "Bacteriur (Optional)",
                  value: selected.bacteriuria,
                ),
                ItemGroup(
                    title: "Treatments",
                    data: selected.treatments.map((t) => t.description).toList()),
                ItemGroup(
                    title: "Discussed Services Provided",
                    data: selected.counselings.map((c) => c.description).toList()),
                const SizedBox(
                  height: 8,
                ),
                TestItem(
                  label: "Return Date",
                  value: DateFormat("EEEE dd, MM yyyy").format(selected.returnDate),
                ),
                TestItem(
                  label: "Health Service Provider",
                  value: selected.healthServiceProvider!.name ?? "",
                ),
                TestItem(
                  label: "Hospital Referral",
                  value: selected.hospitalReferral,
                ),
                TestItem(
                  label: "Other Services",
                  value: selected.notes ?? "None",
                ),
              ]),
        ),
      ),
    );
  }
}
