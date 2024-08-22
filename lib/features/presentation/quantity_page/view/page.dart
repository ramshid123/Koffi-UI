import 'dart:math' as math;

import 'package:coffee_ui/core/constants/theme/palette.dart';
import 'package:coffee_ui/core/widgets/common.dart';
import 'package:coffee_ui/features/presentation/quantity_page/bloc/quantity_page_bloc.dart';
import 'package:coffee_ui/features/presentation/quantity_page/view/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class QuantityPage extends StatefulWidget {
  final String coffeeName;
  const QuantityPage({super.key, required this.coffeeName});

  @override
  State<QuantityPage> createState() => _QuantityPageState();
}

class _QuantityPageState extends State<QuantityPage>
    with TickerProviderStateMixin {
  double quantity = 0.5;
  double size = 0.5;

  late AnimationController _exitAnimationController;
  final List<Animation> _exitAnimation = [];

  late AnimationController _sizeAnimationController;
  late Animation _sizeAnimation;

  late AnimationController _beansAnimationController;
  final List<Animation> _beansAnimation = [];

  @override
  void initState() {
    _sizeAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _sizeAnimation = Tween(begin: 0.6, end: 0.9).animate(CurvedAnimation(
        parent: _sizeAnimationController, curve: Curves.easeInOut));

    _exitAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

    _exitAnimation.add(
      Tween(begin: 2, end: 0.0).animate(
        CurvedAnimation(
          parent: _exitAnimationController,
          curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
        ),
      ),
    );
    _exitAnimation.add(
      Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _exitAnimationController,
          curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
        ),
      ),
    );

    _sizeAnimationController.value = 0.5;

    _beansAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _beansAnimation.add(
      Tween(begin: -0.5, end: 1.0).animate(
        CurvedAnimation(
          parent: _beansAnimationController,
          curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
        ),
      ),
    );

    _beansAnimation.add(
      Tween(begin: -0.5, end: 1.0).animate(
        CurvedAnimation(
          parent: _beansAnimationController,
          curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
        ),
      ),
    );

    Future.delayed(const Duration(milliseconds: 200), () async {
      await _exitAnimationController.animateTo(0.5,
          curve: Curves.easeOutBack, duration: const Duration(seconds: 2));

      await _beansAnimationController.animateTo(0.5,
          curve: Curves.easeInOut, duration: const Duration(seconds: 1));
    });

    super.initState();
  }

  void updateSizeAnimation(double size) {
    if (size == 0.0) {
      _sizeAnimationController.animateBack(0.0,
          curve: Curves.easeInOut, duration: const Duration(milliseconds: 400));
    } else if (size == 0.5) {
      _sizeAnimationController.isCompleted
          ? _sizeAnimationController.animateBack(0.5,
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 400))
          : _sizeAnimationController.animateTo(0.5,
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 400));
    } else if (size == 1.0) {
      _sizeAnimationController.animateTo(1.0,
          curve: Curves.easeInOut, duration: const Duration(milliseconds: 400));
    }
  }

  void updateBeansAnimation(double quantity) {
    if (quantity == 0.0) {
      _beansAnimationController.animateBack(0.0,
          curve: Curves.linear, duration: const Duration(milliseconds: 1000));
    } else if (quantity == 0.5) {
      _beansAnimationController.isCompleted
          ? _beansAnimationController.animateBack(0.5,
              curve: Curves.linear,
              duration: const Duration(milliseconds: 1000))
          : _beansAnimationController.animateTo(0.5,
              curve: Curves.linear,
              duration: const Duration(milliseconds: 1000));
    } else if (quantity == 1.0) {
      _beansAnimationController.animateTo(1.0,
          curve: Curves.linear, duration: const Duration(milliseconds: 1000));
    }
  }

  @override
  void dispose() {
    _exitAnimationController.dispose();
    _sizeAnimationController.dispose();
    _beansAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuantityPageBloc, QuantityPageState>(
      listener: (context, state) {
        if (state is QuantityPageStateSize) {
          updateSizeAnimation(state.size);
        } else if (state is QuantityPageStateQuantity) {
          updateBeansAnimation(state.quantity);
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.backGroundColor,
        body: SafeArea(
          child: AnimatedBuilder(
              animation: _exitAnimation[0],
              builder: (context, _) {
                return AnimatedBuilder(
                    animation: _exitAnimation[1],
                    builder: (context, _) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        clipBehavior: Clip.none,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 200.h,
                              // color: Colors.red.withOpacity(0.2),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Column(
                                    children: [
                                      kHeight(20.h),
                                      Transform.translate(
                                        offset: Offset(0.0,
                                            -100.h * _exitAnimation[1].value),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () => context.pop(context),
                                              child: Transform.translate(
                                                offset: Offset(
                                                    -100.w *
                                                        _exitAnimation[0].value,
                                                    0.0),
                                                child: Container(
                                                  padding: EdgeInsets.all(10.r),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: ColorConstants
                                                        .liteContainerColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    Icons.arrow_back,
                                                    size: 30.r,
                                                    color: ColorConstants
                                                        .iconColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Transform.translate(
                                              offset: Offset(
                                                  0.0,
                                                  _exitAnimation[0].value *
                                                      -50.h),
                                              child: kText(
                                                // text: 'Machiatto',
                                                text: widget.coffeeName,
                                                fontSize: 26,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Opacity(
                                              opacity: 0,
                                              child: Container(
                                                padding: EdgeInsets.all(10.r),
                                                decoration: const BoxDecoration(
                                                  color: ColorConstants
                                                      .liteContainerColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.arrow_back,
                                                  size: 30.r,
                                                  color:
                                                      ColorConstants.iconColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  IgnorePointer(
                                    child: Container(
                                      height: 200.h,
                                      clipBehavior: Clip.hardEdge,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                          // color: Colors.blue.withOpacity(0.3),
                                          ),
                                      child: SizedBox(
                                        child: Stack(
                                          alignment: Alignment.topCenter,
                                          children: [
                                            AnimatedBuilder(
                                                animation: _beansAnimation[0],
                                                builder: (context, _) {
                                                  return Transform.translate(
                                                    offset: Offset(
                                                        0.0,
                                                        200.h *
                                                            _beansAnimation[0]
                                                                .value),
                                                    child: Transform.rotate(
                                                      angle: math.pi,
                                                      child: Image.asset(
                                                        'assets/images/coffee/coffee grain.png',
                                                        height: 100.r,
                                                        width: 100.r,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  );
                                                }),
                                            AnimatedBuilder(
                                                animation: _beansAnimation[1],
                                                builder: (context, _) {
                                                  return Transform.translate(
                                                    offset: Offset(
                                                        0.0,
                                                        200.h *
                                                            _beansAnimation[1]
                                                                .value),
                                                    child: Image.asset(
                                                      'assets/images/coffee/coffee grain.png',
                                                      height: 100.r,
                                                      width: 100.r,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedBuilder(
                                animation: _sizeAnimation,
                                builder: (context, _) {
                                  final amountInMl = _sizeAnimation.value == 0.6
                                      ? '100ml'
                                      : (_sizeAnimation.value <= 0.75
                                          ? '150ml'
                                          : '250ml');

                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Transform.translate(
                                        offset: Offset(
                                            -100.w * _exitAnimation[1].value,
                                            0.0),
                                        child: Transform.translate(
                                          offset: Offset(
                                              _exitAnimation[0].value * -100.w,
                                              0.0),
                                          child: kText(
                                            text: amountInMl,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      Transform.scale(
                                        alignment: Alignment.topCenter,
                                        // scale: 0.9,
                                        scale: _sizeAnimation.value,
                                        child: Hero(
                                          tag: 'mug',
                                          child: Transform.translate(
                                            offset: Offset(
                                                0.0,
                                                _exitAnimation[0].value *
                                                    700.h),
                                            child: Image.asset(
                                              'assets/images/coffee/mug.png',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Opacity(
                                        opacity: 0,
                                        child: kText(
                                          text: amountInMl,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                            const Spacer(),
                            Transform.translate(
                              offset:
                                  Offset(0.0, _exitAnimation[1].value * 350.h),
                              child: Column(
                                children: [
                                  BlocBuilder<QuantityPageBloc,
                                      QuantityPageState>(
                                    buildWhen: (previous, current) {
                                      if (current is QuantityPageStateSize) {
                                        return true;
                                      }
                                      return false;
                                    },
                                    builder: (context, state) {
                                      if (state is QuantityPageStateSize) {
                                        size = state.size;
                                      }
                                      return Transform.translate(
                                        offset: Offset(0.0,
                                            _exitAnimation[0].value * 300.h),
                                        child: QuantityPageWidgets.sizeSelector(
                                            size: size, context: context),
                                      );
                                    },
                                  ),
                                  kHeight(30.h),
                                  BlocBuilder<QuantityPageBloc,
                                      QuantityPageState>(
                                    buildWhen: (previous, current) {
                                      if (current
                                          is QuantityPageStateQuantity) {
                                        return true;
                                      }
                                      return false;
                                    },
                                    builder: (context, state) {
                                      if (state is QuantityPageStateQuantity) {
                                        quantity = state.quantity;
                                      }
                                      return Transform.translate(
                                        offset: Offset(0.0,
                                            _exitAnimation[0].value * 200.h),
                                        child: QuantityPageWidgets
                                            .quantitySelector(
                                                quantity: quantity,
                                                context: context),
                                      );
                                    },
                                  ),
                                  kHeight(50.h),
                                  Transform.translate(
                                    offset: Offset(
                                        0.0, _exitAnimation[0].value * 50.h),
                                    child: QuantityPageWidgets.continueButton(
                                        context: context,
                                        animController:
                                            _exitAnimationController),
                                  ),
                                  kHeight(50.h),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              }),
        ),
      ),
    );
  }
}
