import 'package:flutter/material.dart';

class TextFieldCustomWidget extends StatelessWidget {
  const TextFieldCustomWidget({
    super.key,
    required this.theme,
    required this.hintText,
    required this.label,
    required TextEditingController productNameController,
  }) : _productNameController = productNameController;

  final ThemeData theme;
  final String hintText;
  final String label;
  final TextEditingController _productNameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: _productNameController,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: theme.textTheme.titleMedium?.copyWith(
              color: Colors.grey[600],
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }
}
