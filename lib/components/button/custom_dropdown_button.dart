import 'package:flutter/material.dart';
import 'package:smartguide_app/components/prenatal_records/form/prenatal_info_form.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({super.key, required this.value, required this.data, this.onChange});

  final TrimesterEnum value;
  final List<Map<String, dynamic>> data;
  final Function(Object?)? onChange;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
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
      items: data.map((b) => DropdownMenuItem(value: b["value"], child: Text(b["label"]))).toList(),
      validator: (value) {
        if (value == null) {
          return "Please select your barangay";
        }
        return null;
      },
    );
  }
}
