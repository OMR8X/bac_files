import 'package:flutter/material.dart';

class AppTransitions {
  ///
  static const Duration transitionDuration = Duration(milliseconds: 150);
  static const Duration reverseTransitionDuration = Duration(milliseconds: 100);

  ///
  static Widget commonTransition(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    final curve = CurvedAnimation(parent: animation, curve: Curves.decelerate);
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(curve),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.8, end: 1.0).animate(curve),
        child: child,
      ),
    );
  }

  ///
  static Widget noAnimationsTransition(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
