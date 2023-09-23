// ignore_for_file: prefer_const_constructors
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gideon_ogbonna_portfolio/utils/app_colors.dart';
import 'package:gideon_ogbonna_portfolio/utils/assets.dart';
import 'package:gideon_ogbonna_portfolio/utils/shared_widgets/date_widget.dart';
import 'package:gideon_ogbonna_portfolio/utils/shared_widgets/time_widget.dart';
import 'package:gideon_ogbonna_portfolio/utils/spacers.dart';
import 'package:gideon_ogbonna_portfolio/utils/text_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WebDashboardMacOs extends ConsumerStatefulWidget {
  const WebDashboardMacOs({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WebDashboardMacOsState();
}

class _WebDashboardMacOsState extends ConsumerState<WebDashboardMacOs> {
  late int? hoveredIndex;
  late double baseItemHeight;
  late double baseTranslationY;
  late double verticlItemsPadding;

  double getScaledSize(int index) {
    return getPropertyValue(
      index: index,
      baseValue: baseItemHeight,
      maxValue: 70,
      nonHoveredMaxValue: 50,
    );
  }

  double getTranslationY(int index) {
    return getPropertyValue(
      index: index,
      baseValue: baseTranslationY,
      maxValue: -22,
      nonHoveredMaxValue: -14,
    );
  }

  double getPropertyValue({
    required int index,
    required double baseValue,
    required double maxValue,
    required double nonHoveredMaxValue,
  }) {
    late final double propertyValue;

    // 1.
    if (hoveredIndex == null) {
      return baseValue;
    }

    // 2.
    final difference = (hoveredIndex! - index).abs();

    // 3.
    final itemsAffected = items.length;

    // 4.
    if (difference == 0) {
      propertyValue = maxValue;

      // 5.
    } else if (difference <= itemsAffected) {
      final ratio = (itemsAffected - difference) / itemsAffected;

      propertyValue = lerpDouble(baseValue, nonHoveredMaxValue, ratio)!;

      // 6.
    } else {
      propertyValue = baseValue;
    }

    return propertyValue;
  }

  @override
  void initState() {
    super.initState();
    hoveredIndex = null;
    baseItemHeight = 40;

    verticlItemsPadding = 10;
    baseTranslationY = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(100.w, 100.h / 50),
        child: Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
            child: Padding(
              padding: EdgeInsets.only(left: 0.1.w, right: 1.0.w),
              child: Center(
                child: Row(
                  children: [
                    AppSpacer.W05,
                    SizedBox(
                      height: 14.5,
                      width: 14.5,
                      child: SvgPicture.asset(
                        SvgAssets.appleIcon,
                      ),
                    ),
                    AppSpacer.W1,
                    CustomTextView(text: "Finder"),
                    AppSpacer.W1,
                    CustomTextView(text: "About Me"),
                    AppSpacer.W1,
                    CustomTextView(text: "Contact"),
                    AppSpacer.W1,
                    CustomTextView(text: "My Projects"),
                    Spacer(),
                    DateWidget(),
                    AppSpacer.W1,
                    TimeWidget(),
                    // CustomTextView(text: "My Projects"),
                  ],
                ),
              ),
            )),
      ),
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Stack(alignment: Alignment.bottomCenter, children: [
        SizedBox(
          height: 100.h,
          width: 100.w,
          child: SvgPicture.asset(
            SvgAssets.macOSBg,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 0.2.h),
          child: SizedBox(
            height: 5.h,
            // width: 30.w,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    height: 55,
                    left: 0,
                    right: 0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(verticlItemsPadding),
                    // 1.
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        items.length,
                        (index) {
                          // 2.
                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: ((event) {
                              setState(() {
                                hoveredIndex = index;
                              });
                            }),
                            onExit: (event) {
                              setState(() {
                                hoveredIndex = null;
                              });
                            },
                            // 3.
                            child: AnimatedContainer(
                              duration: const Duration(
                                milliseconds: 300,
                              ),
                              transform: Matrix4.identity()
                                ..translate(
                                  0.0,
                                  getTranslationY(index),
                                  0.0,
                                ),
                              height: getScaledSize(index),
                              width: getScaledSize(index),

                              alignment: AlignmentDirectional.bottomCenter,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              // 4.
                              child: FittedBox(
                                fit: BoxFit.contain,
                                // 5.
                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(
                                    milliseconds: 300,
                                  ),
                                  style: TextStyle(
                                    fontSize: getScaledSize(index),
                                  ),
                                  child: Container(
                                    child: items[index],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
