import 'package:flutter/material.dart';

part 'color/colors.dart';
part 'layout/layout.dart';
part 'screen_size/screen_size.dart';
part 'typography/text_style.dart';

extension AppTheme on BuildContext {
  AppColors get colors => AppColors.dark();
  AppLayout get layout => AppLayout.defaultLayout();
  ScreenSize get screenSize => ScreenSize();
  AppTextStyle get textStyle => AppTextStyle.defaultTextStyle();
}
