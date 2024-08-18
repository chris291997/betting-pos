part of '../theme.dart';

class ScreenSize {
  ScreenSize(this.context);
  final BuildContext context;

  Size get deviceSize => MediaQuery.of(context).size;

  double get deviceHeight => deviceSize.height;

  double get deviceWidth => deviceSize.width;

  bool get isMobileDevice => deviceWidth < ScreenBreakpoint.mobileMaxWidth;

  bool get isTabletDevice =>
      !isMobileDevice && deviceWidth < ScreenBreakpoint.tabletMaxWidth;

  bool get isDesktopDevice => deviceWidth >= ScreenBreakpoint.desktopMinWidth;

  bool get isDesktopDeviceMaxWidth =>
      deviceWidth >= ScreenBreakpoint.desktopMaxWidth;

  bool get isLargeDesktopDevice =>
      deviceWidth >= ScreenBreakpoint.largeDesktopMaxWidth;
}
