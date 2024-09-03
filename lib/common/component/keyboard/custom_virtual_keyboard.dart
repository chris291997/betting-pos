import 'package:flutter/material.dart';
import 'package:new_virtual_keyboard/virtual_keyboard.dart';

class CustomVirtualKeyboard extends StatelessWidget {
  const CustomVirtualKeyboard({
    super.key,
    required this.onKeyPress,
    this.type = VirtualKeyboardType.Numeric,
  });

  final VirtualKeyboardType type;
  final Function(dynamic) onKeyPress;

  @override
  Widget build(BuildContext context) {
    return VirtualKeyboard(
      // [0-9] + .
      fontSize: 20,
      height: 200,
      alwaysCaps: true,
      type: VirtualKeyboardType.Numeric,
      // Callback for key press event
      onKeyPress: onKeyPress,
    );
  }
}
