import 'package:flutter/material.dart';

class TextFieldPlaceholder extends StatelessWidget {
  const TextFieldPlaceholder({
    this.labelText = '',
    super.key,
  });

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white, // Default background color
        borderRadius: BorderRadius.circular(8.0), // Default border radius
        border: Border.all(
          color: Colors.grey, // Default border color
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          labelText,
          style: const TextStyle(
            color: Colors.black, // Default label text color
          ),
        ),
      ),
    );
  }
}
