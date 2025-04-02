import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/form/custom_form.dart';
import 'package:smartguide_app/components/prenatal_records/after_care/after_care_iron_supplement_item.dart';
import 'package:smartguide_app/components/prenatal_records/after_care/after_care_tt_immunization_item.dart';
import 'package:smartguide_app/components/section/custom_section.dart';

class AfterCareForm extends StatefulWidget {
  final List<Map<String, dynamic>> ttItems;
  final List<Map<String, dynamic>> ironSuppItems;

  const AfterCareForm({
    super.key,
    this.ttItems = const [],
    this.ironSuppItems = const [],
  });

  @override
  State<AfterCareForm> createState() => _AfterCareFormState();
}

class _AfterCareFormState extends State<AfterCareForm> {
  Future<void> showImmunzationFormDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(4 * 4),
          child: CustomForm(
            label: "Add Immunization",
            actions: [
              CustomButton(
                onPress: () {
                  setState(() {
                    widget.ttItems.add({
                      "description": "TT${widget.ttItems.length + 1}",
                      "datetime": DateTime.now()
                    });
                  });
                  Navigator.pop(context);
                },
                label: "Add",
                icon: Icon(Icons.add_rounded),
              )
            ],
            children: [Text("It will auto generate data")],
          ),
        ),
      ),
    );
  }

  Future<void> showIronSupplementFormDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(4 * 4),
          child: CustomForm(
            label: "Add Iron Supplement",
            actions: [
              CustomButton(
                onPress: () {
                  setState(() {
                    widget.ironSuppItems
                        .add({"tabs": Random().nextInt(10) + 1, "datetime": DateTime.now()});
                  });
                  Navigator.pop(context);
                },
                label: "Add",
                icon: Icon(Icons.add_rounded),
              )
            ],
            children: [Text("It will auto generate data")],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomSection(
      title: "After Care",
      childrenSpacing: 3,
      children: [
        CustomSection(
          title: "TT Immunization",
          headerSpacing: 1,
          childrenSpacing: 1,
          action: IconButton(
              onPressed: showImmunzationFormDialog,
              icon: Icon(
                Icons.add_circle_outline,
                color: Theme.of(context).colorScheme.primary,
              )),
          titleStyle: TextStyle(
            fontSize: 8 * 3,
          ),
          children: [
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      "TT Term",
                    )),
                Expanded(flex: 3, child: Text("Date"))
              ],
            ),
            ...widget.ttItems.map((e) =>
                AfterCareTtImmunizationItem(description: e["description"], date: e["datetime"]))
          ],
        ),
        CustomSection(
          title: "Iron Supplement",
          headerSpacing: 1,
          childrenSpacing: 1,
          action: IconButton(
              onPressed: showIronSupplementFormDialog,
              icon: Icon(
                Icons.add_circle_outline,
                color: Theme.of(context).colorScheme.primary,
              )),
          titleStyle: TextStyle(
            fontSize: 8 * 3,
          ),
          children: [
            Row(
              children: [
                Expanded(flex: 1, child: Text("Tabs")),
                Expanded(flex: 2, child: Text("Date"))
              ],
            ),
            ...widget.ironSuppItems
                .map((e) => AfterCareIronSupplementItem(date: e["datetime"], tabs: e["tabs"]))
          ],
        )
      ],
    );
  }
}
