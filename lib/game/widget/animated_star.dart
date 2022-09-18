import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedStars extends StatelessWidget {
  const AnimatedStars({Key? key, required this.animate}) : super(key: key);

  final bool animate;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (animate)
          for (int i = 0; i < 5; i++)
            const Icon(
              Icons.star_rate_rounded,
              color: Colors.amber,
              size: 48,
            )
                .animate()
                .scale(
                    duration: const Duration(milliseconds: 200),
                    begin: 0,
                    end: 2)
                .scale(
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 300),
                    begin: 1,
                    end: .5)
                .move(
                    delay: const Duration(milliseconds: 400),
                    duration: Duration(milliseconds: i * 200),
                    begin: Offset(0, 40.w),
                    end: Offset(-156.w, -28.w))
                .fade(
                    delay: Duration(milliseconds: i * 220),
                    duration: const Duration(milliseconds: 300),
                    begin: 1,
                    end: animate ? 0 : 1),
      ],
    );
  }
}
