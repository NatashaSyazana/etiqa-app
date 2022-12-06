import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  final FormFieldSetter<String>? onSaved;
  final Function()? onTap;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const DatePickerWidget({ 
    Key? key,
    this.onSaved,
    this.onTap,
    this.controller,
    this.validator
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return TextFormField(
        onSaved: onSaved,
        controller: controller,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        validator: validator,
        style: const TextStyle(fontSize: 12),
        decoration: const InputDecoration(
            hintText: ('Select a Date'), 
            border: OutlineInputBorder(),
        ),
        readOnly: true,
        onTap: onTap);
  }
}