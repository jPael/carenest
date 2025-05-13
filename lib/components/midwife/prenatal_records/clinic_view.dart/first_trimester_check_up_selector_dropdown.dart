import 'package:flutter/material.dart';
import 'package:smartguide_app/models/revamp/clinic_history.dart';
import 'package:smartguide_app/models/revamp/first_trimester.dart';

class FirstTrimesterCheckUpSelectorDropdown extends StatefulWidget {
  const FirstTrimesterCheckUpSelectorDropdown({
    super.key,
    required this.onChange,
    this.defaultValue,
    required this.checkUps,
  });

  final Function(FirstTrimester? selected) onChange;
  final FirstTrimester? defaultValue;
  final List<FirstTrimester> checkUps;

  @override
  FirstTrimesterCheckUpSelectorDropdownState createState() =>
      FirstTrimesterCheckUpSelectorDropdownState();
}

class FirstTrimesterCheckUpSelectorDropdownState
    extends State<FirstTrimesterCheckUpSelectorDropdown> {
  FirstTrimester? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<FirstTrimester>(
      menuMaxHeight: MediaQuery.of(context).size.height * 0.6,
      decoration: InputDecoration(border: UnderlineInputBorder()),
      value: selectedValue,
      hint: const Text('Select a check-up'),
      onChanged: (FirstTrimester? value) {
        setState(() {
          selectedValue = value;
        });
        widget.onChange(value);
      },
      items: widget.checkUps.map((FirstTrimester checkUp) {
        return DropdownMenuItem<FirstTrimester>(
          value: checkUp,
          child: Text(
            '${checkUp.trimesterlabel} -- ${checkUp.checkUp.label}',
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
