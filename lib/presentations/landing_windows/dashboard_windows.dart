import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class WebDashboardWindowsOS extends ConsumerStatefulWidget {
  const WebDashboardWindowsOS({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WebDashboardWindowsOSState();
}

class _WebDashboardWindowsOSState extends ConsumerState<WebDashboardWindowsOS> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: 100.w,
      child: Center(
        child: Text(
          "You are running the web application on ${defaultTargetPlatform.name}",
          style: TextStyle(fontSize: 15.sp),
        ),
      ),
    );
  }
}