import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartguide_app/components/button/custom_button.dart';

class RemindersCard extends StatefulWidget {
  const RemindersCard(
      {super.key,
      required this.title,
      required this.datetime,
      required this.iconSrc,
      this.markAsDone});

  final String title;
  final String iconSrc;
  final DateTime datetime;
  final Function? markAsDone;

  @override
  State<RemindersCard> createState() => _RemindersCardState();
}

class _RemindersCardState extends State<RemindersCard> with TickerProviderStateMixin {
  bool done = false;

  Future markAsDone() async {
    setState(() {
      done = true;
    });

    if (widget.markAsDone == null) return;
    await widget.markAsDone!();
  }

  @override
  Widget build(BuildContext context) {
    final String date = DateFormat("MMMM d, y").format(widget.datetime);
    final String time = DateFormat("hh:mm a").format(widget.datetime);

    return Card(
      // color: done
      //     ? HSLColor.fromColor(Colors.green).withSaturation(0.3).withLightness(.9).toColor()
      //     : Colors.white,
      elevation: done ? 0 : 2,
      child: SizedBox(
        width: 150,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8 * 3, horizontal: 8.0 * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 8 * 8,
                child: Image.asset(
                  widget.iconSrc,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 8 * 1.5,
              ),
              Text(
                widget.title,
                style: const TextStyle(fontSize: 8 * 2, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(date),
              Text(time),
              const SizedBox(
                height: 4 * 6,
              ),

              // CustomCheckbox(customOnChange: (p0, p1) {}, label: "Done", value: done)
              CustomButton(
                onPress: markAsDone,
                label: "Done",
                icon: done ? const Icon(Icons.check) : null,
                horizontalPadding: 3,
                type: done ? CustomButtonType.success : CustomButtonType.ghost,
                verticalPadding: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
