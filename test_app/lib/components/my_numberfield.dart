import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

bool isNumeric(String? value) {
  if (value == null) {
    return false;
  }
  return double.tryParse(value) != null;
}

class MyNumberfield extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;

  const MyNumberfield(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: (value) {
              if (value!.isEmpty) {
                return '$hintText is required';
              }
              if (!isNumeric(value)) {
                return 'Please enter only digits'; // Validation error message for non-numeric input
              }
              return null;
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.lightBlue),
                borderRadius: BorderRadius.circular(10),
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[500]),
            ),
          ),
        ],
      ),
    );
  }
}


