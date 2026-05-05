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

Widget textFieldCustomWidget({
  required BuildContext context,
  bool? readOnly,
  required TextEditingController controller,
  String? label,
  String? hintText,
  Icon? suffixIcon,
  bool? obscureText = false,
  TextInputType? keyboardType,
  VoidCallback? suffixIconPressed,
  String? Function(String?)? validator,
}) {
  final theme = Theme.of(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label ?? "", style: theme.textTheme.labelLarge),
      const SizedBox(height: 5),
      Column(
        children: [
          TextFormField(
            controller: controller,
            obscureText: obscureText!,
            keyboardType: keyboardType,
            readOnly: readOnly ?? false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(16),
              suffixIcon: suffixIcon != null
                  ? IconButton(onPressed: suffixIconPressed, icon: suffixIcon)
                  : null,
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              hintStyle: TextStyle(color: Colors.grey[500]),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your email";
              }
              return null;
            },
          ),
        ],
      ),
    ],
  );
}
