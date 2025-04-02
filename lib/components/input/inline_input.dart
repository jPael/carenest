import 'package:flutter/material.dart';
import 'package:smartguide_app/components/input/custom_input.dart';

class InlineInput extends StatelessWidget {
  const InlineInput(
      {super.key, this.label, required this.controller, this.suffixText, this.hint, this.isNormal});

  final String? label;
  final TextEditingController controller;
  final String? suffixText;
  final String? hint;
  final bool? isNormal;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        spacing: 4 * 2,
        children: [
          if (label != null)
            Expanded(
                flex: 1,
                child: Text(
                  "$label: ",
                  style: TextStyle(fontSize: 4 * 4, fontWeight: FontWeight.w500),
                )),
          Flexible(
              // flex: 2,
              child: CustomInput.text(
            context: context,
            controller: controller,
            suffixText: suffixText,
            hint: hint ?? "",
            label: hint ?? "",
          )),
          if (isNormal != null)
            Expanded(
                flex: 1,
                child: Row(
                  spacing: 4,
                  children: [
                    Text(
                      "Normal: ",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(isNormal! ? "Yes" : "No"),
                  ],
                )),
        ],
      ),
    );
  }
}
