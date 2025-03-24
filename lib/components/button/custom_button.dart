import 'package:flutter/material.dart';
import 'package:smartguide_app/utils/utils.dart';

enum SocialButtonType { google }

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onPress,
      required this.label,
      this.icon,
      this.radius = 1,
      this.horizontalPadding = 3,
      this.verticalPadding = 2,
      this.isLoading = false});

  final VoidCallback onPress;
  final String label;
  final Icon? icon;
  final int radius;

  final int horizontalPadding;
  final int verticalPadding;

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon: isLoading ? loadingIndicator() : icon,
        style: ButtonStyle(
            elevation: WidgetStateProperty.all(isLoading ? 0 : null),
            iconColor: WidgetStateProperty.all(Colors.white),
            shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0 * radius))),
            padding: WidgetStateProperty.all(EdgeInsets.symmetric(
                horizontal: 8.0 * horizontalPadding, vertical: 8.0 * verticalPadding)),
            backgroundColor: WidgetStateProperty.all(
                Theme.of(context).colorScheme.primary.withValues(alpha: isLoading ? 0.5 : 1.0))),
        onPressed: onPress,
        label: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 8 * 2),
        ));
  }

  Widget loadingIndicator() {
    return SizedBox(
      height: 8 * 2,
      width: 8 * 2,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }

  static Widget ghost(
      {required BuildContext context,
      Icon? icon,
      required String label,
      required VoidCallback onPressed,
      Color? color,
      double radius = 1,
      horizontalPadding = 3,
      verticalPadding = 2}) {
    return ElevatedButton.icon(
        icon: icon,
        style: ButtonStyle(
            shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0 * radius))),
            padding: WidgetStateProperty.all(EdgeInsets.symmetric(
                horizontal: 8.0 * horizontalPadding, vertical: 4.0 * verticalPadding)),
            backgroundColor: WidgetStateProperty.all(Colors.white)),
        onPressed: onPressed,
        label: Text(
          label,
          style: TextStyle(fontSize: 8 * 2),
        ));
  }

  static Widget large(
      {required BuildContext context,
      required String label,
      required VoidCallback onPressed,
      Color? color,
      bool isLoading = false,
      double? radius}) {
    final padding = EdgeInsets.symmetric(vertical: 8 * 2, horizontal: 4 * 16);
    final borderRadius = BorderRadius.circular(radius != null ? 8 * radius : 8 * 1);
    final bgColor = isLoading
        ? muteColor(Theme.of(context).colorScheme.primary)
        : color ?? Theme.of(context).colorScheme.primary;

    return ElevatedButton(
        style: ButtonStyle(
            padding: WidgetStateProperty.all(padding),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: borderRadius)),
            backgroundColor: WidgetStateProperty.all(bgColor)),
        onPressed: isLoading ? () {} : onPressed,
        child: Row(
          spacing: 4 * 2,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? SizedBox.square(
                    dimension: 4 * 7,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    label,
                    style: TextStyle(fontSize: 8 * 3, color: Colors.white),
                  ),
          ],
        ));
  }

  static Widget social(
      {required BuildContext context,
      required String label,
      required VoidCallback onPressed,
      SocialButtonType buttonType = SocialButtonType.google}) {
    late ButtonStyle buttonStyle;
    late TextStyle textStyle;
    late Image img;

    bool isHidden = true;

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
          style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500, color: Colors.white),
        )
      ],
    );
  }
}
