import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class BaseDropDown extends StatelessWidget {
  const BaseDropDown({
    super.key,
    required this.status,
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
  });

  final BaseDropdownStatus status;
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(header),
        const SizedBox(height: 10),
        if (status.isLoading || status.isDisabled)
          _DisableOrLoadingDropdown(
            buttonHeight: buttonHeight,
            buttonWidth: buttonWidth,
            buttonPadding: buttonPadding,
            buttonDecoration: buttonDecoration,
            status: status,
            hintAlignment: hintAlignment,
            hint: hint,
            iconSize: iconSize,
            iconDisabledColor: iconDisabledColor,
          )
        else
          EnabledDropdown(
            hintAlignment: hintAlignment,
            hint: hint,
            value: value,
            dropdownItems: dropdownItems,
            valueAlignment: valueAlignment,
            onChanged: onChanged,
            selectedItemBuilder: selectedItemBuilder,
            buttonHeight: buttonHeight,
            buttonWidth: buttonWidth,
            buttonPadding: buttonPadding,
            buttonDecoration: buttonDecoration,
            buttonElevation: buttonElevation,
            icon: icon,
            iconSize: iconSize,
            iconEnabledColor: iconEnabledColor,
            iconDisabledColor: iconDisabledColor,
            dropdownHeight: dropdownHeight,
            dropdownWidth: dropdownWidth,
            dropdownPadding: dropdownPadding,
            dropdownDecoration: dropdownDecoration,
            dropdownElevation: dropdownElevation,
            offset: offset,
            itemHeight: itemHeight,
            itemPadding: itemPadding,
          ),
      ],
    );
  }
}

class EnabledDropdown extends StatelessWidget {
  const EnabledDropdown({
    super.key,
    required this.hintAlignment,
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.valueAlignment,
    required this.onChanged,
    required this.selectedItemBuilder,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.buttonPadding,
    required this.buttonDecoration,
    required this.buttonElevation,
    required this.icon,
    required this.iconSize,
    required this.iconEnabledColor,
    required this.iconDisabledColor,
    required this.dropdownHeight,
    required this.dropdownWidth,
    required this.dropdownPadding,
    required this.dropdownDecoration,
    required this.dropdownElevation,
    required this.offset,
    required this.itemHeight,
    required this.itemPadding,
  });

  final Alignment? hintAlignment;
  final String hint;
  final String? value;
  final List<String> dropdownItems;
  final Alignment? valueAlignment;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final double? buttonHeight;
  final double? buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? dropdownHeight;
  final double? dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Offset offset;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
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
        padding: buttonPadding ?? const EdgeInsets.only(left: 14, right: 14),
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
    );
  }
}

class _DisableOrLoadingDropdown extends StatelessWidget {
  const _DisableOrLoadingDropdown({
    required this.buttonHeight,
    required this.buttonWidth,
    required this.buttonPadding,
    required this.buttonDecoration,
    required this.status,
    required this.hintAlignment,
    required this.hint,
    required this.iconSize,
    required this.iconDisabledColor,
  });

  final double? buttonHeight;
  final double? buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final BaseDropdownStatus status;
  final Alignment? hintAlignment;
  final String hint;
  final double? iconSize;
  final Color? iconDisabledColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight ?? 40,
      width: buttonWidth ?? double.infinity,
      padding: buttonPadding ?? const EdgeInsets.only(left: 14, right: 14),
      decoration: buttonDecoration ??
          BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black45,
            ),
          ),
      child: status.isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
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
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: iconSize ?? 12,
                  color: iconDisabledColor ?? Colors.grey,
                ),
              ],
            ),
    );
  }
}

enum BaseDropdownStatus {
  enabled,
  disabled,
  loading;

  bool get isDisabled => this == disabled;
  bool get isLoading => this == loading;
  bool get isEnabled => this == enabled;
}
