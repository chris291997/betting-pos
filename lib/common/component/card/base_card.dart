import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class BaseCard extends StatelessWidget {
  const BaseCard({
    super.key,
    required this.content,
    required this.onTap,
    this.enableGradientBorder = false,
  });

  final Widget content;
  final void Function() onTap;
  final bool enableGradientBorder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: enableGradientBorder
            ? const BoxDecoration(
                border: GradientBoxBorder(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.red],
                  ),
                  width: 4,
                ),
              )
            : null,
        child: Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: content,
          ),
        ),
      ),
    );
  }
}
