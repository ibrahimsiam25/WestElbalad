import 'package:flutter/material.dart';


class CustomNumberField extends StatelessWidget {
  final String? hintText;
  final String? initialValue;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  final bool obscureText;
  final bool readOnly;

  const CustomNumberField({
    super.key,
    this.hintText,
    this.initialValue,
    this.onSaved,
    this.onTap,
    this.obscureText = false,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      onSaved: onSaved,
      onTap: onTap,
      readOnly: readOnly,
      initialValue: initialValue,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        final number = int.tryParse(value);
        if (number == null) {
          return 'ادخل رقم صحيح';
        }
        return null;
      },
      decoration: InputDecoration(
      
        hintText: hintText,
        filled: true,
        fillColor: Colors.white, // Replace with your color
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0), // Replace with your radius
      borderSide: BorderSide(
        width: 1,
        color: Color(0xFFE6E9E9),
      ),
    );
  }
}