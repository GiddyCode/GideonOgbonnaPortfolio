import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gideon_ogbonna_portfolio/presentations/landing_macOS/dashboard_macos.dart';
import 'package:gideon_ogbonna_portfolio/presentations/landing_windows/dashboard_windows.dart';
import 'package:gideon_ogbonna_portfolio/utils/app_colors.dart';
import 'package:gideon_ogbonna_portfolio/utils/app_strings.dart';
import 'package:gideon_ogbonna_portfolio/utils/assets.dart';
import 'package:gideon_ogbonna_portfolio/utils/context_extension.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/foundation.dart';

class Splashscreen extends ConsumerStatefulWidget {
  const Splashscreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashscreenState();
}

class _SplashscreenState extends ConsumerState<Splashscreen> {
  @override
  void didChangeDependencies() {
    init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        color: black,
        child: Center(
            child: SizedBox(
                height: 5.w,
                width: 5.w,
                child: SvgPicture.asset(
                    defaultTargetPlatform.name == AppStrings.mac
                        ? SvgAssets.appleIcon
                        : SvgAssets.msWindowsIcon))
            // Text(
            //   "placeholder for image",
            //   style: TextStyle(fontSize: 15.sp),
            // ),
            ),
      ),
    );
  }

  void init() {
    Timer(const Duration(seconds: 3), () {
      defaultTargetPlatform.name == AppStrings.mac
          ? context.animPush(
              const ProviderScope(child: WebDashboardMacOs()),
            )
          : context.animPush(
              const WebDashboardWindowsOS(),
            );
    });
  }
}
