import 'package:flutter/material.dart';
import 'package:smartguide_app/models/revamp/clinic_history.dart';

class NutritionStatusEnumDropdown extends StatefulWidget {
  const NutritionStatusEnumDropdown({
    super.key,
    required this.onChange,
    this.defaultValue,
  });

  final Function(NutritionalStatusEnum? selected) onChange;
  final NutritionalStatusEnum? defaultValue;

  @override
  NutritionStatusEnumDropdownState createState() => NutritionStatusEnumDropdownState();
}

class NutritionStatusEnumDropdownState extends State<NutritionStatusEnumDropdown> {
  NutritionalStatusEnum? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<NutritionalStatusEnum>(
      menuMaxHeight: MediaQuery.of(context).size.height * 0.6,
      decoration: const InputDecoration(border: UnderlineInputBorder()),
      value: selectedValue,
      hint: const Text('Select a nutrition status'),
      onChanged: (NutritionalStatusEnum? value) {
        setState(() {
          selectedValue = value;
        });
        widget.onChange(value);
      },
      items: NutritionalStatusEnum.values.map((NutritionalStatusEnum enumValue) {
        return DropdownMenuItem<NutritionalStatusEnum>(
          value: enumValue,
          child: Text(
            enumValue.laravelValue,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      validator: (value) {
        if (value == null) {
          return "Please select a nutrition status";
        }
        return null;
      },
    );
  }
}
