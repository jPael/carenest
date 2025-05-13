import 'package:flutter/material.dart';
import 'package:smartguide_app/models/revamp/clinic_history.dart';
import 'package:smartguide_app/models/revamp/second_trimester.dart';

class SecondTrimesterCheckUpSelectorDropdown extends StatefulWidget {
  const SecondTrimesterCheckUpSelectorDropdown({
    super.key,
    required this.onChange,
    this.defaultValue,
    required this.checkUps,
  });

  final Function(SecondTrimester? selected) onChange;
  final SecondTrimester? defaultValue;
  final List<SecondTrimester> checkUps;

  @override
  SecondTrimesterCheckUpSelectorDropdownState createState() =>
      SecondTrimesterCheckUpSelectorDropdownState();
}

class SecondTrimesterCheckUpSelectorDropdownState
    extends State<SecondTrimesterCheckUpSelectorDropdown> {
  SecondTrimester? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<SecondTrimester>(
      menuMaxHeight: MediaQuery.of(context).size.height * 0.6,
      decoration: const InputDecoration(border: UnderlineInputBorder()),
      value: selectedValue,
      hint: const Text('Select a check-up'),
      onChanged: (SecondTrimester? value) {
        setState(() {
          selectedValue = value;
        });
        widget.onChange(value);
      },
      items: widget.checkUps.map((SecondTrimester checkUp) {
        return DropdownMenuItem<SecondTrimester>(
          value: checkUp,
          child: Text(
            '${checkUp.trimesterLabel} -- ${checkUp.checkUp.label}',
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
