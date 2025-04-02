import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartguide_app/models/midwife.dart';
import 'package:smartguide_app/services/laravel/midwife_services.dart';

class MidwifeSelector extends StatefulWidget {
  const MidwifeSelector({super.key, required this.onChange});

  final Function(String?)? onChange;

  @override
  MidwifeSelectorState createState() => MidwifeSelectorState();
}

class MidwifeSelectorState extends State<MidwifeSelector> {
  String defaultValue = "";
  List<Midwife> midwives = [];
  bool fetchingMidwife = false;
  final MidwifeServices midwifeServices = MidwifeServices();

  Future<void> _fetchMidwife() async {
    try {
      final List<Midwife> _midwives = await midwifeServices.fetchAllMidwife();

      setState(() {
        defaultValue = _midwives.first.id!.toString();
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
        ? Row(
            spacing: 4 * 2,
            children: [
              SizedBox.square(
                dimension: 4 * 6,
                child: CircularProgressIndicator(),
              ),
              Text("Fetching midwives..."),
            ],
          )
        : Flexible(
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
              items: midwives
                  .map((b) => DropdownMenuItem(value: b.id.toString(), child: Text(b.name!)))
                  .toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select your midwife";
                }
                return null;
              },
            ),
          );
  }
}
