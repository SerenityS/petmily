import 'package:flutter/material.dart';

class SettingTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const SettingTextField({
    super.key,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(1.0, 2.0),
              blurRadius: 6.0,
            ),
          ],
          color: Colors.white),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          isDense: true,
          hintText: hint,
        ),
      ),
    );
  }
}
