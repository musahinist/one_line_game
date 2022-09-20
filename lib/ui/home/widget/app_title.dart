import 'package:flutter/material.dart';

import '../../../config/const/app_const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTitleWidget extends StatelessWidget {
  const AppTitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Transform.rotate(
          angle: -.2,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                App.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 56.sp,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 8
                    ..isAntiAlias = true
                    ..strokeJoin = StrokeJoin.round
                    ..color = Colors.white,
                ),
              ),
              Text(
                App.name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 56.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
