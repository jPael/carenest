import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPress,
    required this.label,
    this.icon,
  });

  final VoidCallback onPress;
  final String label;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon: icon,
        style: ButtonStyle(
            iconColor: WidgetStateProperty.all(Colors.white),
            padding:
                WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 8 * 3, vertical: 8 * 2)),
            backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primary)),
        onPressed: onPress,
        label: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 8 * 2),
        ));
  }

  static Widget large(
      {required BuildContext context,
      key,
      required String label,
      required VoidCallback onPressed,
      Color? color,
      double? radius}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ElevatedButton(
              style: ButtonStyle(
                  padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 8 * 2)),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(radius != null ? 8 * radius : 8 * 1))),
                  backgroundColor:
                      WidgetStateProperty.all(color ?? Theme.of(context).colorScheme.primary)),
              onPressed: onPressed,
              child: Text(
                label,
                style: TextStyle(fontSize: 8 * 3, color: Colors.white),
              )),
        )
      ],
    );
  }

  static Widget link(
      {required BuildContext context,
      required String label,
      required VoidCallback onPressed,
      double fontSize = 8.0 * 2}) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        label,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary),
      ),
    );
  }

  static Widget image(
      {required BuildContext context,
      required Image content,
      required VoidCallback onPressed,
      String? label}) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: onPressed,
            clipBehavior: Clip.antiAlias,
            style: ElevatedButton.styleFrom(
                elevation: 3,
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8 * 2))),
                padding: EdgeInsets.zero),
            child: content),
        const SizedBox(
          height: 8 * 2,
        ),
        Text(
          label ?? "",
          style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
