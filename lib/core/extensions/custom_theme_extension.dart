import 'package:flutter/material.dart';

/// Custom extension for implementing Dark Theme/Mode
extension CustomThemeExtension on BuildContext {
  Color? dynamicColor({Color? light, Color? dark}) {
    if ((Theme.of(this).brightness == Brightness.light)) {
      return light;
    } else {
      return dark;
    }
  }

  Color? get backgroundColor => dynamicColor(
        light: Colors.grey[200],
        dark: Colors.black87,
      );

  Color? get cardColor => dynamicColor(
        light: Colors.white,
        dark: Colors.blue[900],
      );

  Color? get tabColor => dynamicColor(
        light: Colors.white,
        dark: Colors.black87,
      );

  Color? get switchInactiveColor => dynamicColor(
        light: Colors.blue.shade500,
        dark: Colors.blue.shade800,
      );

  Color? get switchActiveColor => dynamicColor(
        light: Colors.blue.shade900,
        dark: Colors.blue.shade300,
      );

  Color? get textColor => dynamicColor(light: Colors.black, dark: Colors.white);

  Color? get borderColor => dynamicColor(
        light: Colors.grey,
        dark: Colors.white,
      );
}
