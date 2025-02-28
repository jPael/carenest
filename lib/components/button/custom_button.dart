import 'package:flutter/material.dart';

enum SocialButtonType { google }

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onPress,
      required this.label,
      this.icon,
      this.radius = 1,
      this.horizontalPadding = 3,
      this.verticalPadding = 2});

  final VoidCallback onPress;
  final String label;
  final Icon? icon;
  final int radius;

  final int horizontalPadding;
  final int verticalPadding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon: icon,
        style: ButtonStyle(
            iconColor: WidgetStateProperty.all(Colors.white),
            shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0 * radius))),
            padding: WidgetStateProperty.all(EdgeInsets.symmetric(
                horizontal: 8.0 * horizontalPadding, vertical: 8.0 * verticalPadding)),
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

  static Widget social(
      {required BuildContext context,
      required String label,
      required VoidCallback onPressed,
      SocialButtonType buttonType = SocialButtonType.google}) {
    late ButtonStyle buttonStyle;
    late TextStyle textStyle;
    late Image img;

    switch (buttonType) {
      case SocialButtonType.google:
        buttonStyle = ButtonStyle(
            elevation: WidgetStateProperty.all(1),
            padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 8 * 2)),
            shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8 * 4))),
            backgroundColor: WidgetStateProperty.all(Colors.white));

        textStyle = TextStyle(fontSize: 8 * 3, color: Colors.black.withValues(alpha: 0.6));

        img = Image.asset(
          "lib/assets/images/google_logo.png",
          scale: 25,
          fit: BoxFit.cover,
        );
        break;
    }

    return ElevatedButton(
        style: buttonStyle,
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            img,
            const SizedBox(
              width: 8 * 2,
            ),
            Text(
              label,
              style: textStyle,
            )
          ],
        ));
  }

  static Widget link(
      {required BuildContext context,
      required String label,
      required VoidCallback onPressed,
      Widget? icon,
      double fontSize = 8.0 * 2}) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        spacing: 4,
        children: [
          icon ?? Container(),
          Text(
            label,
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary),
          ),
        ],
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
