import 'package:flutter/material.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';
import 'package:smartguide_app/components/input/custom_input.dart';

class InlineInput extends StatelessWidget {
  const InlineInput(
      {super.key,
      this.label,
      this.controller,
      this.suffixText,
      this.hint,
      this.isNormal,
      this.customInput,
      this.readonly = false});

  final String? label;
  final TextEditingController? controller;
  final String? suffixText;
  final String? hint;
  final bool? isNormal;
  final Widget? customInput;
  final bool readonly;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        spacing: 4 * 2,
        children: [
          if (label != null)
            Flexible(
                flex: 2,
                child: AutoSizeText(
                  "$label: ",
                  style: const TextStyle(
                    fontSize: 4 * 3,
                  ),
                )),
          Flexible(
              flex: 3,
              child: customInput ??
                  CustomInput.text(
                    readonly: readonly,
                    context: context,
                    controller: controller,
                    suffixText: suffixText,
                    hint: hint ?? "",
                    label: hint ?? "",
                  )),
          if (isNormal != null)
            Expanded(
                flex: 2,
                child: Row(
                  spacing: 4,
                  children: [
                    const Text(
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
