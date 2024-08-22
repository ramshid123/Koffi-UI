import 'dart:math';

import 'package:coffee_ui/core/constants/theme/palette.dart';
import 'package:coffee_ui/core/route/route_names.dart';
import 'package:coffee_ui/core/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MixingPageWidgets {
  static Widget wave(double width) {
    return _WaveWidget(
      width: width,
    );
  }

  static Widget thanksButton(
      {required BuildContext context,
      required AnimationController animController}) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () async {
          await animController.forward();
          if (context.mounted) {
            context.goNamed(RouteName.homePage);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            color: ColorConstants.blackContainerColor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              kText(
                text: 'Thanks',
                color: ColorConstants.backGroundColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              kWidth(10.w),
              Icon(
                Icons.arrow_right_alt_rounded,
                size: 30.r,
                color: ColorConstants.backGroundColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WaveWidget extends StatefulWidget {
  final double width;
  const _WaveWidget({required this.width});

  @override
  State<_WaveWidget> createState() => __WaveWidgetState();
}

class __WaveWidgetState extends State<_WaveWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveAnimationController;
  late Animation _waveAnimation;

  @override
  void initState() {
    
    _waveAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    _waveAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_waveAnimationController);

    _waveAnimationController.repeat();

    super.initState();
  }

  @override
  void dispose() {
    
    _waveAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _waveAnimation,
        builder: (context, _) {
          return Transform.translate(
            offset: Offset(widget.width * -_waveAnimation.value, 0.0),
            child: Transform.scale(
              alignment: Alignment.centerLeft,
              scale: 2,
              child: Row(
                children: [
                  for (int i = 0; i < 2; i++)
                    CustomPaint(
                      size: Size(widget.width / 2, 50.h),
                      painter: _WavePainter(),
                    ),
                ],
              ),
            ),
          );
        });
  }
}

// Wave Painter

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Path path = Path();

    double waveHeight = 8.0.h; // Height of the wave
    double waveLength = size.width / 3; // Length of one wave cycle

    path.moveTo(0, size.height / 2); // Start from the middle of the left edge

    for (double i = 0; i <= size.width; i += 1) {
      path.lineTo(
          i, size.height / 2 + waveHeight * sin(2 * pi * i / waveLength));
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
