import 'package:bet_pos/common/component/drop_down/base_drop_down.dart';
import 'package:flutter/material.dart';

class FighterDropdown extends StatelessWidget {
  const FighterDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseDropDown(
      header: 'Fighter',
      hint: 'Select Fighter',
      value: null,
      dropdownItems: [],
      onChanged: (_) {},
    );
  }
}
