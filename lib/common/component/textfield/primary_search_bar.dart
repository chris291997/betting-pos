import 'package:bet_pos/common/component/textfield/base_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PrimarySearchBar extends HookWidget {
  const PrimarySearchBar({
    super.key,
    required this.hintText,
    required this.onSearch,
    required this.searchController,
  });

  final String hintText;
  final void Function(String) onSearch;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: BaseTextfield(
              controller: searchController,
              hintText: hintText,
              onChanged: (_) => {},
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              onSearch(searchController.text);
            },
          ),
        ],
      ),
    );
  }
}
