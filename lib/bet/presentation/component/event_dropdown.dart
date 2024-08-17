import 'package:bet_pos/common/component/drop_down/base_drop_down.dart';
import 'package:flutter/material.dart';

class EventDropdown extends StatelessWidget {
  const EventDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseDropDown(
      header: 'Event',
      hint: 'Select Event',
      value: null,
      dropdownItems: [],
      onChanged: (_) {},
    );
  }
}
