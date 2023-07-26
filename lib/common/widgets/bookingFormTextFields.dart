import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookingFormTextFields extends StatelessWidget {
  final String hint;
  final int? maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final Widget? suffixIcon;
  final bool labelView;
  final int? maxLength;
  final IconData iconData;
  final TextEditingController? controller;
  final Function(String)? onChanged ;
   BookingFormTextFields(
      {Key? key,
      required this.iconData,
        required this.hint,
        this.maxLines,
        this.keyboardType,
        this.labelView= true,
        this.inputFormatters,
        this.suffixIcon,
        this.maxLength,
        this.onChanged,
        this.readOnly = false,
        this.controller,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      cursorColor: Colors.pink.shade900,
      decoration: new InputDecoration(
        border: new OutlineInputBorder(
          borderSide:
              new BorderSide(color: Colors.pink.shade900),
        ),
        focusedBorder: new OutlineInputBorder(
          borderSide:
              new BorderSide(color: Colors.pink.shade900),
        ),
        labelText: hint,
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        prefixIcon:  Icon(
       iconData ,
          color: Colors.pink.shade900,
        ),
      ),
    );

  }
}