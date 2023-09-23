// ignore_for_file: camel_case_extensions

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

extension ContextExtension on BuildContext {
  //todo add pushnamed function.

  Future<T?>? push<T>(widget) {
    return Navigator.of(this).push(FadeRouteAnim(builder: (context) => widget));
    // .push(MaterialPageRoute<T>(builder: (context) => widget));
  }

  Future<T?>? animPush<T>(widget) {
    return Navigator.of(this).push(PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondarvAnimation) {
        return widget;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return Align(
          child: SizeTransition(
            sizeFactor: animation,
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(seconds: 1),
    ));
  }

  // Future<T?>? animPushTT<T>(widget) {
  //   return Navigator.of(this).push(
  //     SizeTransitionRoute
  //   );
  // }

  Future<T?>? pushNamed<T>(String route) {
    return Navigator.of(this).pushNamed(route);
  }

  void closeKeyboard(BuildContext context) {
    FocusScopeNode currentFocus =
        FocusScope.of(context); // SHOULD BE builderContext
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  setToClipboard(
      {required BuildContext context,
      required String copyValue,
      required String snackBarMessage}) {
    return Clipboard.setData(ClipboardData(text: copyValue)).then((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(snackBarMessage)));
    });
  }

  Future<T?>? pushReplacement<T>(Widget widget) {
    return Navigator.of(this)
        .pushReplacement(MaterialPageRoute<T>(builder: (context) => widget));
  }

  Future<dynamic> navigateToAndCleanUntil(
      String routeName, String lastRouteName,
      {dynamic arguments}) async {
    try {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      return Navigator.of(this).pushNamedAndRemoveUntil(
          routeName, ModalRoute.withName(lastRouteName),
          arguments: arguments);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> replaceTo(String routeName, {dynamic arguments}) {
    return Navigator.of(this).pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: arguments);
  }

  void popToHome() => Navigator.of(this).popUntil((route) => route.isFirst);
  void pop() => Navigator.of(this).pop();

  Future<bool> maybePop<T>([T? data]) => Navigator.maybePop(this, data);

  // void showSnackBar(SnackBar snackbar) =>
  //     Scaffold.of(this).showSnackBar(snackbar);

  void requestFocus(FocusNode nextFocus) =>
      FocusScope.of(this).requestFocus(nextFocus);
}

final currencyFormat = NumberFormat("#,##0.00", "en_US");

extension customIntExtension on int? {
  formatCurrency() {
    return this == null ? '-' : (currencyFormat.format(this));
  }
}

extension customDoubleExtension on double? {
  formatCurrency({String? currencySymbol = '₦'}) {
    return this == null
        ? '-'
        : ((currencySymbol != null ? ('$currencySymbol ') : '') +
            currencyFormat.format(this));
  }
}

//This extension below adds a FadeOut animation to navigation
extension FadePageRouteExtension<T> on Widget {
  FadePageRoute<T> fadePageRoute() {
    return FadePageRoute<T>(page: this);
  }
}

class FadePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadePageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: Tween<double>(begin: 1.0, end: 0.0).animate(animation),
              child: child,
            );
          },
        );
}

//This extension below adds a easeIn-Out animation to navigation
extension EaseInOutAnimationExtension on Widget {
  Route<dynamic> dissolvePageRoute() {
    return PageRouteBuilder<dynamic>(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return this;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}

//This extension below adds a move up and dissolve animation to navigation
extension DissolveAnimationExtension on Widget {
  Route<dynamic> moveUpAndDissolvePageRoute() {
    return PageRouteBuilder<dynamic>(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return this;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        const Offset startOffset = Offset(0.0, 1.0);
        const Offset endOffset = Offset.zero;
        const Curve curve = Curves.easeInOut;

        final Animation<Offset> slideAnimation = Tween<Offset>(
          begin: startOffset,
          end: endOffset,
        ).animate(CurvedAnimation(parent: animation, curve: curve));

        final Animation<double> fadeAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(parent: animation, curve: curve));

        return Stack(
          children: [
            SlideTransition(
              position: slideAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: child,
              ),
            ),
            IgnorePointer(
              ignoring: animation.status == AnimationStatus.reverse ||
                  animation.status == AnimationStatus.dismissed,
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 0.4).animate(animation),
                child: const ModalBarrier(
                    dismissible: false, color: Colors.black87),
              ),
            ),
          ],
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}

extension SmartAnimateExtension on Widget {
  Route<dynamic> smartAnimatePageRoute() {
    return PageRouteBuilder<dynamic>(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return this;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        const Curve curve = Curves.easeInOut;
        final Animation<double> fadeAnimation =
            Tween<double>(begin: 0.0, end: 1.0)
                .animate(CurvedAnimation(parent: animation, curve: curve));

        return FadeTransition(opacity: fadeAnimation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}

class FadeRouteAnim<T> extends MaterialPageRoute<T> {
  FadeRouteAnim({required WidgetBuilder builder}) : super(builder: builder);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
