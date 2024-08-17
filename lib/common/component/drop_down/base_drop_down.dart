import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class BaseDropDown extends StatelessWidget {
  const BaseDropDown({
    required this.header,
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = Offset.zero,
    super.key,
  });

  final String header;
  final String hint;
  final String? value;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(header),
        const SizedBox(height: 10),
        DropdownButtonFormField2<String>(
          isExpanded: true,
          hint: Container(
            alignment: hintAlignment,
            child: Text(
              hint,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
          ),
          value: value,
          items: dropdownItems
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Container(
                      alignment: valueAlignment,
                      child: Text(
                        item,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
          selectedItemBuilder: selectedItemBuilder,
          buttonStyleData: ButtonStyleData(
            height: buttonHeight ?? 40,
            width: buttonWidth ?? 140,
            padding:
                buttonPadding ?? const EdgeInsets.only(left: 14, right: 14),
            decoration: buttonDecoration ??
                BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.black45,
                  ),
                ),
            elevation: buttonElevation,
          ),
          iconStyleData: IconStyleData(
            icon: icon ?? const Icon(Icons.arrow_forward_ios_outlined),
            iconSize: iconSize ?? 12,
            iconEnabledColor: iconEnabledColor,
            iconDisabledColor: iconDisabledColor,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: dropdownHeight ?? 200,
            width: dropdownWidth ?? 140,
            padding: dropdownPadding,
            decoration: dropdownDecoration ??
                BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                ),
            elevation: dropdownElevation ?? 8,
            offset: offset,
          ),
          menuItemStyleData: MenuItemStyleData(
            height: itemHeight ?? 40,
            padding: itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ],
    );
  }
}
