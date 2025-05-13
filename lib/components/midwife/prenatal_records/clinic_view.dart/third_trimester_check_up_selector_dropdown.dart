import 'package:flutter/material.dart';
import 'package:smartguide_app/models/revamp/clinic_history.dart';
import 'package:smartguide_app/models/revamp/third_trimester.dart';

class ThirdTrimesterCheckUpSelectorDropdown extends StatefulWidget {
  const ThirdTrimesterCheckUpSelectorDropdown({
    super.key,
    required this.onChange,
    this.defaultValue,
    required this.checkUps,
  });

  final Function(ThirdTrimester? selected) onChange;
  final ThirdTrimester? defaultValue;
  final List<ThirdTrimester> checkUps;

  @override
  ThirdTrimesterCheckUpSelectorDropdownState createState() =>
      ThirdTrimesterCheckUpSelectorDropdownState();
}

class ThirdTrimesterCheckUpSelectorDropdownState
    extends State<ThirdTrimesterCheckUpSelectorDropdown> {
  ThirdTrimester? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ThirdTrimester>(
      menuMaxHeight: MediaQuery.of(context).size.height * 0.6,
      decoration: const InputDecoration(border: UnderlineInputBorder()),
      value: selectedValue,
      hint: const Text('Select a check-up'),
      onChanged: (ThirdTrimester? value) {
        setState(() {
          selectedValue = value;
        });
        widget.onChange(value);
      },
      items: widget.checkUps.map((ThirdTrimester checkUp) {
        return DropdownMenuItem<ThirdTrimester>(
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
