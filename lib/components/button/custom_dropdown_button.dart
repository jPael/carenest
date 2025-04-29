import 'package:flutter/material.dart';
import 'package:smartguide_app/models/trimester.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton(
      {super.key, required this.value, required this.data, this.onChange, this.readonly = false});

  final bool readonly;

  final TrimesterEnum value;
  final List<Map<String, dynamic>> data;
  final Function(Object?)? onChange;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: readonly,
      child: DropdownButtonFormField(
        menuMaxHeight: MediaQuery.of(context).size.height * 0.6,
        decoration: InputDecoration(
          labelText: "Trimester",
          hintText: "Select your current trimester",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8 * 2),
          ),
        ),
        value: value,
        onChanged: onChange,
        // onChanged: (value) {
        //   setState(() {
        //     selectedTrimester = value! as int;
        //   });
        // },
        items:
            data.map((b) => DropdownMenuItem(value: b["value"], child: Text(b["label"]))).toList(),
        validator: (value) {
          if (value == null) {
            return "Please select your trimester";
          }
          return null;
        },
      ),
    );
  }
}
