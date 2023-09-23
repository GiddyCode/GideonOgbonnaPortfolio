import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gideon_ogbonna_portfolio/utils/app_colors.dart';
import 'package:gideon_ogbonna_portfolio/utils/assets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextView extends StatelessWidget {
  final String text;
  final int maxLines;
  final double textSize;
  final Color foreground;
  final bool? overflowText;
  final TextAlign textAlign;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final String? fontFamily;
  const CustomTextView({
    Key? key,
    required this.text,
    this.textSize = 14,
    this.maxLines = 3,
    this.foreground = primaryColor,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.textAlign = TextAlign.left,
    this.fontFamily = Fonts.macOsFont,
    this.overflowText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        maxLines: maxLines,
        style: TextStyle(
          overflow: overflowText == true ? TextOverflow.ellipsis : null,
          fontFamily: fontFamily,
          color: foreground,
          fontSize: textSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
        ));
  }
}

class OnHoverTextView extends StatelessWidget {
  final String text;
  final int maxLines;
  final double textSize;
  final Color foreground;
  final bool? overflowText;
  final TextAlign textAlign;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final String? fontFamily;
  const OnHoverTextView({
    Key? key,
    required this.text,
    this.textSize = 12,
    this.maxLines = 3,
    this.foreground = primaryColor,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.textAlign = TextAlign.left,
    this.fontFamily = Fonts.macOsFont,
    this.overflowText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        maxLines: maxLines,
        style: TextStyle(
          overflow: overflowText == true ? TextOverflow.ellipsis : null,
          fontFamily: fontFamily,
          color: foreground,
          fontSize: textSize.sp,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
        ));
  }
}
