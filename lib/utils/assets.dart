import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageAssets {
  // static const testwith = "assets/svgs/test_test.png";
}

class SvgAssets {
  static const appleIcon = "assets/svg/apple_icon.svg";
  static const macOSBg = "assets/svg/macOSBg.svg";
  static const msWindowsIcon = "assets/svg/microsoft_windows_icon.svg";
}

class Fonts {
  static const String macOsFont = 'MacOSFont';
}



List<Widget> items = [
  SvgPicture.asset(SvgAssets.appleIcon),
  SvgPicture.asset(SvgAssets.appleIcon),
  SvgPicture.asset(SvgAssets.appleIcon),
  SvgPicture.asset(SvgAssets.appleIcon),
  SvgPicture.asset(SvgAssets.appleIcon),
];
