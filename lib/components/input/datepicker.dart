import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    required this.selectedDate,
    required this.firstDate,
    required this.lastDate,
    this.label = "",
    this.hint = "",
    required this.onChange,
  });

  final DateTime selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final String label;
  final String hint;
  final void Function(DateTime) onChange;

  @override
  DatePickerState createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController(
      text: DateFormat("MMMM d, y").format(widget.selectedDate),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
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
      widget.onChange(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        readOnly: true,
        controller: dateController,
        decoration: InputDecoration(
          label: Text(widget.label),
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
