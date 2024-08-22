import 'package:coffee_ui/core/constants/dummy%20datas/coffees.dart';
import 'package:coffee_ui/core/constants/theme/palette.dart';
import 'package:coffee_ui/core/route/route_names.dart';
import 'package:coffee_ui/core/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomePageWidgets {
  static Widget coffeeSelectionContainer(
      {required PageController pageController,
      required double pageOffset,
      required Animation animation}) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Transform.scale(
                scale: 2,
                child: Transform.translate(
                  offset: Offset(0.0, constraints.maxHeight / 2),
                  child: Transform.translate(
                    offset: Offset(0.0, constraints.maxHeight),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: ColorConstants.liteTextColor,
                          width: 1.r,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
              Opacity(
                opacity: (1 - animation.value).toDouble(),
                child: Transform.translate(
                  offset: Offset(constraints.maxWidth * animation.value, 0.0),
                  child: PageView(
                    physics: const BouncingScrollPhysics(),
                    clipBehavior: Clip.none,
                    controller: pageController,
                    children: [
                      for (int i = 0; i < dummyCoffeeData.length; i++)
                        _cupItem(
                          index: i,
                          pageOffset: pageOffset,
                          pageViewHeight: constraints.maxHeight,
                          image: dummyCoffeeData[i]['image']!,
                          name: dummyCoffeeData[i]['name']!,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  static Widget continueButton(
      {required BuildContext context,
      required AnimationController animController}) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () async {
          await animController.forward();
          if (context.mounted) {
            context.goNamed(RouteName.quantityPage);
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
                text: 'Continue',
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

  static Widget _cupItem({
    required int index,
    required double pageOffset,
    required double pageViewHeight,
    required String name,
    required String image,
  }) {
    return _CupItem(
      index: index,
      pageOffset: pageOffset,
      pageViewHeight: pageViewHeight,
      image: image,
      name: name,
    );
  }
}

class _CupItem extends StatefulWidget {
  final int index;
  final double pageViewHeight;
  final double pageOffset;
  final String name;
  final String image;
  const _CupItem({
    required this.index,
    required this.pageOffset,
    required this.pageViewHeight,
    required this.name,
    required this.image,
  });

  @override
  State<_CupItem> createState() => __CupItemState();
}

class __CupItemState extends State<_CupItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation _animation;

  @override
  void initState() {
    
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _animation = ColorTween(
            begin: ColorConstants.liteTextColor, end: ColorConstants.textColor)
        .animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animationValue = 1 / (1 + (widget.index - widget.pageOffset).abs());
    _animationController.value = 2 * (animationValue - 0.5);

    return Transform.translate(
      offset: Offset(0.0, (widget.pageViewHeight / 2) * (1 - animationValue)),
      child: Transform.scale(
        scale: animationValue,
        child: Column(
          children: [
            Image.asset(
              widget.image,
              // height: double.infinity,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            kHeight(30.h),
            AnimatedBuilder(
                animation: _animation,
                builder: (context, _) {
                  return kText(
                      text: widget.name,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: _animation.value);
                }),
          ],
        ),
      ),
    );
  }
}
