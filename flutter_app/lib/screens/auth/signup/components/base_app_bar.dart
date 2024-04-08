import 'package:flutter/material.dart';
import 'package:flutter_app/components/preffered_divider.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_app/constants/global_constant.dart';
import 'package:flutter_app/extensions/context_ext.dart';
import 'package:flutter_app/extensions/style_ext.dart';

enum AppBarType { onlyLogo, onlyBack, step, other, close, withImage, homePage }

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Background app bar
  final Color? backgroundColor;

  // Widget for appbar content
  final Widget? title;

  /// Pass [AppBar] only to get size
  /// of appbar
  final AppBar appBar;

  // If need to display step, pass this
  final int? currentStep;

  /// List of actions widget as like [OptionsMenu]
  final List<Widget>? actions;

  /// Display appbar base on [AppBarType]
  final AppBarType type;

  /// Display leading action
  final Widget? leading;

  /// Length of step
  final int? lengthStep;

  /// On tap back
  final Function? onTapBack;

  /// Center title
  final bool? centerTitle;

  /// [AppBarType.withImage] options
  final AppBarImageOptions? options;

  // Constructor
  const BaseAppBar(
      {super.key,
      this.title,
      this.actions,
      required this.appBar,
      this.currentStep,
      this.lengthStep,
      this.onTapBack,
      this.backgroundColor = Colors.white,
      required this.type,
      this.options,
      this.centerTitle = false,
      this.leading});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AppBarType.step:
        return _appBarStep(context);
      case AppBarType.onlyBack:
        return _appBarDefault(context);
      case AppBarType.onlyLogo:
        return _appBarLogo(context);
      case AppBarType.close:
        return _appBarClose(context);
      case AppBarType.withImage:
        return _appBarImage(context);
      case AppBarType.homePage:
        return _appBarHomePage(context);
      default:
        return _appBarOther(context);
    }
  }

  // AppBar with default leading
  _appBarDefault(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: backgroundColor,
      elevation: 0,
      title: title,
      actions: actions,
      centerTitle: centerTitle ?? false,
      bottom: PreferredDivider(),
      automaticallyImplyLeading: true,
      leading: IconButton(
          onPressed: () {
            if (onTapBack != null) {
              onTapBack!();
            }
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xff2D2D2D),
          )),
    );
  }

  // Build app bar
  _appBarImage(BuildContext context) {
    return PreferredSize(
      preferredSize: AppBar().preferredSize,
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        height: double.infinity,
        width: double.infinity,
        color: backgroundColor ?? const Color(0xffDE008D),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                    onPressed: () => kPop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              height: AppBar().preferredSize.height,
              child: Align(
                alignment: Alignment.center,
                child: Text(context.translate(options?.title ?? Constant.empty),
                    textAlign: TextAlign.center, style: context.size14White400),
              ),
            ),
            Visibility(
              visible: options != null,
              replacement: const SizedBox(),
              child: Positioned(
                bottom: 0,
                right: 0,
                child: Transform.rotate(
                  angle: 0.1,
                  child: Transform.scale(
                    scale: 1.1,
                    child: Opacity(
                      opacity: 0.2,
                      child: Image.asset(
                        'assets/icons/${options?.imageTrailing}',
                        width: 52,
                        height: 52,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // AppBar with default leading
  _appBarClose(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: backgroundColor,
      elevation: 0,
      title: title,
      actions: actions,
      bottom: PreferredDivider(),
      centerTitle: centerTitle ?? false,
      automaticallyImplyLeading: true,
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.close,
            color: Color(0xff2D2D2D),
          )),
    );
  }

  // AppBar with default leading
  _appBarLogo(BuildContext context) {
    return AppBar(
      title: _displayLogo(context),
      titleSpacing: 0,
      backgroundColor: backgroundColor,
      elevation: 0,
      actions: actions,
      bottom: PreferredDivider(),
      automaticallyImplyLeading: true,
      leading: leading,
    );
  }

  // AppBar with step view
  _appBarStep(BuildContext context) {
    return AppBar(
      title: _buildStepView(context),
      titleSpacing: 0,
      backgroundColor: backgroundColor,
      elevation: 0,
      actions: actions,
      bottom: PreferredDivider(),
      automaticallyImplyLeading: true,
      leading: IconButton(
          onPressed: () {
            if (onTapBack != null) {
              onTapBack!();
            } else {
              Navigator.pop(context);
            }
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xff2D2D2D),
          )),
    );
  }

  // AppBar with customize
  _appBarOther(BuildContext context) {
    return AppBar(
      title: title,
      titleSpacing: 0,
      backgroundColor: backgroundColor,
      elevation: 0,
      actions: actions,
      bottom: PreferredDivider(),
      automaticallyImplyLeading: true,
      leading: leading,
    );
  }

  // Logo
  Widget _displayLogo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.scale(
            scale: 0.5,
            child: Image.asset(
              'assets/icons/ic_logo.png',
              fit: BoxFit.cover,
            ))
      ],
    );
  }

  // Step view
  Widget _buildStepView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text.rich(TextSpan(children: [
            TextSpan(
              text: 'Step ',
              style: context.size14G8Bw400,
            ),
            TextSpan(
              text: '$currentStep',
              style: context.size14Black400,
            ),
            TextSpan(
              text: ' of ${lengthStep ?? 4} ',
              style: context.size14G8Bw400,
            ),
          ]))
        ],
      ),
    );
  }

  // Create appBar home page
  Widget _appBarHomePage(BuildContext context) {
    return AppBar(
      title: _displayLogo(context),
      titleSpacing: 0,
      backgroundColor: backgroundColor,
      centerTitle: true,
      elevation: 0,
      actions: actions,
      bottom: PreferredDivider(),
      automaticallyImplyLeading: true,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

class AppBarImageOptions {
  final String imageTrailing;
  final String title;

  AppBarImageOptions({required this.imageTrailing, required this.title});
}
