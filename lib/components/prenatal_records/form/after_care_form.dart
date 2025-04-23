import 'package:flutter/material.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/form/custom_form.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/prenatal_records/after_care/after_care_iron_supplement_item.dart';
import 'package:smartguide_app/components/prenatal_records/after_care/after_care_tt_immunization_item.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/after_care.dart';

class AfterCareForm extends StatefulWidget {
  final List<Map<String, dynamic>> ttItems;
  final List<Map<String, dynamic>> ironSuppItems;

  const AfterCareForm({
    super.key,
    this.data,
    required this.ttItems,
    required this.ironSuppItems,
  });

  final AfterCare? data;

  @override
  State<AfterCareForm> createState() => _AfterCareFormState();
}

class _AfterCareFormState extends State<AfterCareForm> {
  Future<void> showImmunzationFormDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // Map<String, dynamic> value = {"term": "", "datetime": DateTime.now()};
        final TextEditingController termController = TextEditingController();
        DateTime datetime = DateTime.now();

        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(4 * 4),
            child: CustomForm(
              label: "Add Immunization",
              actions: [
                CustomButton(
                  onPress: () {
                    setState(() {
                      widget.ttItems.add({
                        "term": termController.text,
                        "datetime": datetime,
                      });
                    });
                    Navigator.pop(context);
                  },
                  label: "Add",
                  icon: const Icon(Icons.add_rounded),
                )
              ],
              children: [
                Column(
                  children: [
                    CustomInput.text(
                      context: context,
                      controller: termController,
                      label: "TT Term",
                      hint: "Enter TT Term",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a valid term";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        CustomInput.datepicker(
                          context: context,
                          onChange: (dateValue) {
                            datetime = dateValue;
                          },
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showIronSupplementFormDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController tabsController = TextEditingController();
        DateTime datetime = DateTime.now();

        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(4 * 4),
            child: CustomForm(
              label: "Add Iron Supplement",
              actions: [
                CustomButton(
                  onPress: () {
                    setState(() {
                      widget.ironSuppItems.add({
                        "iron_supplement_no_tabs": int.tryParse(tabsController.text) ?? 1,
                        "datetime": datetime,
                      });
                    });
                    Navigator.pop(context);
                  },
                  label: "Add",
                  icon: const Icon(Icons.add_rounded),
                )
              ],
              children: [
                Column(
                  children: [
                    CustomInput.text(
                      context: context,
                      controller: tabsController,
                      label: "Number of Tabs",
                      hint: "Enter number of tabs",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a valid number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        CustomInput.datepicker(
                          context: context,
                          onChange: (dateValue) {
                            datetime = dateValue;
                          },
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
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
          titleStyle: const TextStyle(
            fontSize: 8 * 3,
          ),
          children: [
            const Row(
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
                AfterCareTtImmunizationItem(description: "Term ${e["term"]}", date: e["datetime"]))
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
          titleStyle: const TextStyle(
            fontSize: 8 * 3,
          ),
          children: [
            const Row(
              children: [
                Expanded(flex: 1, child: Text("Date")),
                Expanded(flex: 2, child: Text("Tabs")),
              ],
            ),
            ...widget.ironSuppItems.map((e) => AfterCareIronSupplementItem(
                date: e["datetime"], tabs: e["iron_supplement_no_tabs"]))
          ],
        )
      ],
    );
  }
}
