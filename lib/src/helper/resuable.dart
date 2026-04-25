import 'package:flutter/material.dart';

Widget confirmNotification(BuildContext context, String title, String message) {
  return AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text("Cancel"),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text("OK"),
      ),
    ],
  );
}

Widget showConfirmDialog(
  BuildContext context,
  String title,
  String message,
  Function() onConfirm,
) {
  return AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text("Cancel"),
      ),
      TextButton(onPressed: onConfirm, child: const Text("OK")),
    ],
  );
}

Widget showSuccessDialog(
  BuildContext context,
  String title,
  String message,
  Function() onConfirm,
) {
  return AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text("OK"),
      ),
    ],
  );
}

Widget showWarningDialog(
  BuildContext context,
  String title,
  String message,
  Function() onConfirm,
) {
  return AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text("Cancel"),
      ),
      TextButton(onPressed: onConfirm, child: const Text("OK")),
    ],
  );
}

Widget showInformationDialog(
  BuildContext context,
  String title,
  String message,
  Function() onConfirm,
) {
  return AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text("OK"),
      ),
    ],
  );
}
