import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  final bool readOnly;
  final String hintText;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    this.hintText = '',
    this.initialValue = '',
    this.readOnly = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextFormField(
            onChanged: onChanged,
            initialValue: initialValue,
            readOnly: readOnly,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Field tidak boleh kosong';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
