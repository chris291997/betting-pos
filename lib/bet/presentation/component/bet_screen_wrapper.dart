import 'package:bet_pos/common/component/appbar/main_appbar.dart';
import 'package:bet_pos/common/theme/screen_size/screen_breakpoint.dart';
import 'package:bet_pos/common/theme/theme.dart';
import 'package:flutter/material.dart';

class BetScreenWrapper extends StatelessWidget {
  const BetScreenWrapper({
    super.key,
    this.appBarTitle = '',
    required this.content,
    required this.nextButtons,
    this.onAppbarBackButtonPressed,
    this.displayAppBar = true,
    this.contentVerticalAlignment = MainAxisAlignment.start,
  });

  final bool displayAppBar;
  final String appBarTitle;
  final List<Widget> content;
  final List<Widget> nextButtons;
  final MainAxisAlignment contentVerticalAlignment;
  final Function()? onAppbarBackButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: displayAppBar
          ? MainAppbar(
              title: appBarTitle,
              onBackButtonPressed: onAppbarBackButtonPressed,
            )
          : null,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: ScreenBreakpoint.tabletMaxWidth,
            ),
            padding: EdgeInsets.all(context.layout.mediumPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (contentVerticalAlignment == MainAxisAlignment.start) ...[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: content,
                      ),
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: contentVerticalAlignment,
                      children: [
                        Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: contentVerticalAlignment,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: content,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                ...nextButtons,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
