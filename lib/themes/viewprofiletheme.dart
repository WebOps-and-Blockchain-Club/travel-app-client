import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String entry;

  const CustomTextFormField({
    Key? key,
    required this.label,
    required this.entry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Text(label),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              color: Colors.transparent,
              height: 20,
              width: 200,
              child: Text(entry),
            ),
          ),
        ],
      ),
    );
  }
}
