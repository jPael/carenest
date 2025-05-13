import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartguide_app/utils/date_utils.dart';

enum DatePickerEnum { input, text }

class DatePicker extends StatefulWidget {
  const DatePicker(
      {super.key,
      this.selectedDate,
      required this.firstDate,
      required this.lastDate,
      this.label = "",
      this.hint = "",
      required this.onChange,
      this.validator,
      this.type = DatePickerEnum.input,
      required this.readonly});

  final DateTime? selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final String label;
  final String hint;
  final void Function(DateTime) onChange;
  final String? Function(String?)? validator;
  final bool readonly;
  final DatePickerEnum type;

  @override
  DatePickerState createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  late TextEditingController dateController;

  final FocusNode fn = FocusNode();

  @override
  void initState() {
    super.initState();
    fn.addListener(() {
      if (fn.hasFocus) {
        _selectDate(context);
      }
      fn.unfocus();
    });
    dateController = TextEditingController(
      text:
          widget.selectedDate != null ? DateFormat("MMMM d, y").format(widget.selectedDate!) : null,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    if (widget.readonly) return;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    );

    if (picked != null && picked != widget.selectedDate) {
      setState(() {
        dateController.text = DateFormat("MMMM d, y").format(picked);
      });

      // log(picked.toString());

      widget.onChange(picked);
    }
  }

  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == DatePickerEnum.input) {
      return input(context);
    } else {
      return GestureDetector(
        onTap: () => _selectDate(context),
        child: Text(
          "Given at ${DateFormat("d'${getOrdinalSuffix(widget.selectedDate!.day)}' of MMMM yyyy").format(widget.selectedDate!)}",
          style: const TextStyle(fontSize: 4 * 4),
        ),
      );
    }
  }

  Flexible input(BuildContext context) {
    return Flexible(
      child: TextFormField(
        readOnly: true,
        onTap: () => _selectDate(context),
        validator: widget.validator,
        controller: dateController,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          // floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: widget.label,
          hintText: widget.hint,
          prefixIcon: Icon(Icons.date_range_outlined, color: Theme.of(context).colorScheme.primary),
          suffixIcon: IconButton(
            onPressed: () => _selectDate(context),
            icon: Icon(Icons.edit_outlined, color: Theme.of(context).colorScheme.primary),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
