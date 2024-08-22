import 'package:coffee_ui/core/constants/theme/palette.dart';
import 'package:coffee_ui/core/route/route_names.dart';
import 'package:coffee_ui/core/widgets/common.dart';
import 'package:coffee_ui/features/presentation/mixing%20page/view/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MixingPage extends StatefulWidget {
  const MixingPage({super.key});

  @override
  State<MixingPage> createState() => _MixingPageState();
}

class _MixingPageState extends State<MixingPage> with TickerProviderStateMixin {
  late AnimationController _pourAnimationController;
  final List<Animation> _pourAnimation = [];

  late AnimationController _exitAnimationController;
  late Animation _exitAnimation;

  @override
  void initState() {
    _pourAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));

    _pourAnimation.add(Tween(begin: 1.0, end: -1.0).animate(
      CurvedAnimation(
        parent: _pourAnimationController,
        curve: const Interval(0.1, 0.8, curve: Curves.linear),
      ),
    ));

    _pourAnimation.add(Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _pourAnimationController,
        curve: const Interval(0.8, 0.9, curve: Curves.easeInOut),
      ),
    ));

    _pourAnimation.add(Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _pourAnimationController,
        curve: const Interval(0.9, 1.0, curve: Curves.easeInOut),
      ),
    ));

    _pourAnimation.add(Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _pourAnimationController,
        curve: const Interval(0.0, 0.1, curve: Curves.easeInOut),
      ),
    ));

    _exitAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _exitAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _exitAnimationController, curve: Curves.easeInOut));

    _pourAnimationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _pourAnimationController.dispose();
    _exitAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        await _exitAnimationController.forward();
        if (context.mounted) {
          context.goNamed(RouteName.homePage);
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.backGroundColor,
        body: AnimatedBuilder(
            animation: _exitAnimation,
            builder: (context, _) {
              return AnimatedBuilder(
                  animation: _pourAnimation[2],
                  builder: (context, _) {
                    return SafeArea(
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Column(
                            children: [
                              kHeight(40.h),
                              Row(
                                children: [
                                  kWidth(30.w),
                                  Transform.translate(
                                    offset: Offset(
                                        -100.w * _exitAnimation.value, 0.0),
                                    child: Transform.translate(
                                      offset: Offset(
                                          -100.w *
                                              (1 - _pourAnimation[2].value),
                                          0.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          await _exitAnimationController
                                              .forward();
                                          if (context.mounted) {
                                            context.goNamed(RouteName.homePage);
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10.r),
                                          decoration: const BoxDecoration(
                                            color: ColorConstants
                                                .liteContainerColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.close_rounded,
                                            size: 30.r,
                                            color: ColorConstants.iconColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  kHeight(40.h),
                                ],
                              ),
                              Transform.translate(
                                offset:
                                    Offset(0.0, -300.h * _exitAnimation.value),
                                child: Transform.translate(
                                  offset: Offset(0.0,
                                      -300.h * (1 - _pourAnimation[2].value)),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 60.r,
                                        width:60.r,
                                        decoration: BoxDecoration(
                                          color: ColorConstants.brownColor,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorConstants.brownColor
                                                  .withOpacity(0.9),
                                              offset: const Offset(0, 13),
                                              blurRadius: 25,
                                              spreadRadius: 4,
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          color: ColorConstants.backGroundColor,
                                          size: 40.r,
                                        ),
                                      ),
                                      kHeight(15.h),
                                      kText(
                                        text: 'Your coffee is ready,\nEnjoy!',
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 28,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Transform.translate(
                                offset:
                                    Offset(0.0, 150.h * _exitAnimation.value),
                                child: Transform.translate(
                                  offset: Offset(0.0,
                                      150.h * (1 - _pourAnimation[2].value)),
                                  child: MixingPageWidgets.thanksButton(
                                      context: context,
                                      animController: _exitAnimationController),
                                ),
                              ),
                              kHeight(60.h),
                            ],
                          ),
                          Transform.translate(
                            offset: Offset(0.0, _exitAnimation.value * 500.h),
                            child: Column(
                              children: [
                                // Coffee Section
                                Transform.translate(
                                  offset: Offset(
                                      0.0, _pourAnimation[2].value * 100.h),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 250.h,
                                        width: double.infinity,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: const BoxDecoration(),
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            AnimatedBuilder(
                                              animation: _pourAnimation[0],
                                              builder: (context, _) {
                                                return Transform.scale(
                                                  scaleX: 0.8,
                                                  scaleY: 1.3,
                                                  child: Transform.scale(
                                                    scale: 4,
                                                    child: Transform.translate(
                                                      offset: Offset(
                                                          0.0,
                                                          250.h *
                                                              -_pourAnimation[0]
                                                                  .value),
                                                      child: Image.asset(
                                                        'assets/images/coffee/coffee spill.png',
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            AnimatedBuilder(
                                                animation: _pourAnimation[1],
                                                builder: (context, _) {
                                                  return Transform.translate(
                                                    offset: Offset(
                                                        0.0,
                                                        300.h *
                                                            -_pourAnimation[1]
                                                                .value),
                                                    child: Transform.scale(
                                                      scale: 1.1,
                                                      child: Image.asset(
                                                        'assets/images/coffee/cap.png',
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: Offset(0.0, 0.h),
                                        child: Hero(
                                          tag: 'mug',
                                          child: Image.asset(
                                            'assets/images/coffee/mug.png',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Loading Section
                                AnimatedBuilder(
                                    animation: _pourAnimation[3],
                                    builder: (context, _) {
                                      return Transform.translate(
                                        offset: Offset(0.0,
                                            300.h * _pourAnimation[3].value),
                                        child: Transform.translate(
                                          offset: Offset(0.0,
                                              300.h * _pourAnimation[2].value),
                                          child: Column(
                                            children: [
                                              kHeight(50.h),
                                              MixingPageWidgets.wave(
                                                  size.width),
                                              kHeight(50.h),
                                              kText(
                                                text: 'Almost done!',
                                                fontSize: 25,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              kText(
                                                text:
                                                    'Coffee is being ground now...',
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
