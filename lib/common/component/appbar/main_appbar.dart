import 'package:bet_pos/common/theme/theme.dart';
import 'package:flutter/material.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppbar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.onBackButtonPressed,
  });
  final String title;
  final bool showBackButton;
  final Function()? onBackButtonPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_sharp,
              ),
              onPressed: () {
                if (onBackButtonPressed != null) {
                  onBackButtonPressed!();
                } else {
                  Navigator.of(context).pop();
                }
              },
            )
          : null,
      title: Text(title, style: context.textStyle.headline6),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
