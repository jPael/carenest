import 'package:flutter/material.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';

class Alert {
  // Global key for scaffold messenger
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorMessage({
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    return scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: AutoSizeText(
          message,
          style: const TextStyle(fontWeight: FontWeight.w500),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        duration: duration,
        action: SnackBarAction(
          label: "Close",
          onPressed: () => scaffoldMessengerKey.currentState!.hideCurrentSnackBar(),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccessMessage({
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    return scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: AutoSizeText(
          message,
          style: const TextStyle(fontWeight: FontWeight.w500),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        duration: duration,
        action: SnackBarAction(
          label: "Close",
          onPressed: () => scaffoldMessengerKey.currentState!.hideCurrentSnackBar(),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
