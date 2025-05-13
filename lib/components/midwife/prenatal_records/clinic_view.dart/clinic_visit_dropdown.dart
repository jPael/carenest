import 'package:flutter/material.dart';
import 'package:smartguide_app/models/revamp/clinic_history.dart';

class ClinicHistoryEnumDropdown extends StatefulWidget {
  const ClinicHistoryEnumDropdown({
    super.key,
    required this.onChange,
    this.defaultValue,
  });

  final Function(ClinicHistoryEnum? selected) onChange;
  final ClinicHistoryEnum? defaultValue;

  @override
  ClinicHistoryEnumDropdownState createState() => ClinicHistoryEnumDropdownState();
}

class ClinicHistoryEnumDropdownState extends State<ClinicHistoryEnumDropdown> {
  ClinicHistoryEnum? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ClinicHistoryEnum>(
      menuMaxHeight: MediaQuery.of(context).size.height * 0.6,
      decoration: const InputDecoration(border: UnderlineInputBorder()),
      value: selectedValue,
      hint: const Text('Select a check-up'),
      onChanged: (ClinicHistoryEnum? value) {
        setState(() {
          selectedValue = value;
        });
        widget.onChange(value);
      },
      items: ClinicHistoryEnum.values.map((ClinicHistoryEnum enumValue) {
        return DropdownMenuItem<ClinicHistoryEnum>(
          value: enumValue,
          child: Text(
            enumValue.label,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      validator: (value) {
        if (value == null) {
          return "Please select a check-up";
        }
        return null;
      },
    );
  }
}
