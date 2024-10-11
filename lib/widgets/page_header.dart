import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../util.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.child,
    this.isStatusBarTextDark = true,
    this.appbar,
    //this.bottomNavigationBar,
    //this.floatingActionButton,
    //this.floatingActionButtonLocation,
    this.useCustomPadding = false,
    this.padding = 0,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = false,
  });

  final Widget child;
  final bool isStatusBarTextDark;
  final PreferredSizeWidget? appbar;
  //final Widget? bottomNavigationBar;
  //final Widget? floatingActionButton;
  //final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool useCustomPadding;
  final double padding;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    //AreaInfo.bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isStatusBarTextDark
          ? SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: Colors.black.withOpacity(0.002),
              systemNavigationBarDividerColor: Colors.black.withOpacity(0.002),
              //systemNavigationBarColor: Color(0x00FFFFFF),
              //systemNavigationBarDividerColor: Color(0x00FFFFFF),
              systemNavigationBarContrastEnforced: true,
              systemNavigationBarIconBrightness: Brightness.dark,
            )
          : SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: const Color(0x00FFFFFF),
              systemNavigationBarDividerColor: const Color(0x00FFFFFF),
              systemNavigationBarContrastEnforced: true,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
      child: Scaffold(
        appBar: appbar,
        backgroundColor: backgroundColor ?? Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: useCustomPadding ? padding : getSize(20),
                vertical: 0),
            child: child,
          ),
        ),
        //bottomNavigationBar: bottomNavigationBar,
        //floatingActionButton: floatingActionButton,
        //floatingActionButtonLocation: floatingActionButtonLocation,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      ),
    );
  }
}
