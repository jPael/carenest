import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smartguide_app/models/person.dart';
import 'package:smartguide_app/services/laravel/midwife_services.dart';

class MidwifeSelector extends StatefulWidget {
  const MidwifeSelector(
      {super.key, required this.onChange, this.defaultValue, this.readonly = false});

  final Function(String?)? onChange;
  final String? defaultValue;
  final bool readonly;

  @override
  MidwifeSelectorState createState() => MidwifeSelectorState();
}

class MidwifeSelectorState extends State<MidwifeSelector> {
  String defaultValue = "";
  List<Person> midwives = [];
  bool fetchingMidwife = false;
  final MidwifeServices midwifeServices = MidwifeServices();

  Future<void> _fetchMidwife() async {
    try {
      final List<Person> _midwives = await midwifeServices.fetchAllMidwife();

      // _midwives.forEach((m) => log(m.toJson().toString()));

      // log(widget.defaultValue?.length.toString() ?? (-1).toString());
      setState(() {
        if (widget.defaultValue == null || widget.defaultValue!.isEmpty) {
          // log("Default value is not set: ${widget.defaultValue.toString()}");
          defaultValue = _midwives.first.id!.toString();
        } else {
          // log("Default value is  set: ${widget.defaultValue.toString()}");

          for (var m in _midwives) {
            if (m.id?.toString() == widget.defaultValue) {
              defaultValue = m.id.toString();
            }
          }
        }

        widget.onChange!(defaultValue);
        midwives = _midwives;
      });
    } catch (e, stackTrace) {
      log("There was an error on laravel service: $e", stackTrace: stackTrace);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMidwife();
  }

  @override
  Widget build(BuildContext context) {
    return fetchingMidwife
        ? const Row(
            spacing: 4 * 2,
            children: [
              SizedBox.square(
                dimension: 4 * 6,
                child: CircularProgressIndicator(),
              ),
              Text("Fetching midwives..."),
            ],
          )
        : Row(
            children: [
              Flexible(
                child: AbsorbPointer(
                  absorbing: widget.readonly,
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    menuMaxHeight: MediaQuery.of(context).size.height * 0.6,
                    decoration: InputDecoration(
                      labelText: "Midwife",
                      hintText: "Choose your midwife",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8 * 2),
                      ),
                    ),
                    value: defaultValue,
                    onChanged: (value) {
                      widget.onChange!(value);
                      setState(() {
                        defaultValue = value!;
                      });
                    },
                    items: midwives.map((b) {
                      // log("value: ${b.id.toString()} name: ${b.name.toString()} value:$defaultValue");
                      return DropdownMenuItem(value: b.id.toString(), child: Text(b.name!));
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select your midwife";
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ],
          );
  }
}
