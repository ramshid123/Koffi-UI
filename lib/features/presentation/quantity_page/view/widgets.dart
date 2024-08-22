import 'dart:developer';

import 'package:coffee_ui/core/route/route_names.dart';
import 'package:coffee_ui/core/widgets/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coffee_ui/core/constants/theme/palette.dart';
import 'package:coffee_ui/features/presentation/quantity_page/bloc/quantity_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class QuantityPageWidgets {
  static Widget quantitySelector({
    required double quantity,
    required BuildContext context,
  }) {
    final buttonSize = 60.r;
    return Container(
      clipBehavior: Clip.none,
      width: (buttonSize * 3) + 40.r,
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.none,
            // width: (buttonSize * 3) + 40.r,
            padding: EdgeInsets.symmetric(horizontal: 5.r, vertical: 10.h),
            decoration: BoxDecoration(
              color: ColorConstants.liteContainerColor,
              borderRadius: BorderRadius.circular(200.r),
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  alignment: quantity == 0.0
                      ? Alignment.centerLeft
                      : (quantity == 1.0
                          ? Alignment.centerRight
                          : Alignment.center),
                  child: _quantitySelectorSwitch(
                    isVisible: true,
                    buttonSize: buttonSize,
                    quantity: 0.0,
                    context: context,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _quantitySelectorSwitch(
                      buttonSize: buttonSize,
                      quantity: 0.0,
                      context: context,
                    ),
                    _quantitySelectorSwitch(
                      buttonSize: buttonSize,
                      quantity: 0.5,
                      context: context,
                    ),
                    _quantitySelectorSwitch(
                      buttonSize: buttonSize,
                      quantity: 1.0,
                      context: context,
                    ),
                  ],
                ),
              ],
            ),
          ),
          kHeight(5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              kText(
                text: 'Low',
                fontSize: 13,
                color: quantity == 0.0
                    ? ColorConstants.brownColor
                    : ColorConstants.textColor.withOpacity(0.7),
              ),
              kText(
                text: 'Medium',
                fontSize: 13,
                color: quantity == 0.5
                    ? ColorConstants.brownColor
                    : ColorConstants.textColor.withOpacity(0.7),
              ),
              kText(
                text: 'High',
                fontSize: 13,
                color: quantity == 1.0
                    ? ColorConstants.brownColor
                    : ColorConstants.textColor.withOpacity(0.7),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _quantitySelectorSwitch({
    bool isVisible = false,
    required double buttonSize,
    required double quantity,
    required BuildContext context,
  }) {
    return Opacity(
      opacity: isVisible ? 1 : 0,
      child: GestureDetector(
        onTap: isVisible
            ? null
            : () => context
                .read<QuantityPageBloc>()
                .add(QuantityPageEventChangeQuantity(quantity)),
        onHorizontalDragUpdate: isVisible
            ? null
            : (data) {
                log(data.delta.dx.toString());
                if (data.delta.dx.isNegative) {
                  context
                      .read<QuantityPageBloc>()
                      .add(QuantityPageEventChangeQuantity(0.0));
                } else {
                  context
                      .read<QuantityPageBloc>()
                      .add(QuantityPageEventChangeQuantity(1.0));
                }
              },
        child: Container(
          padding: EdgeInsets.all(10.r),
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          height: buttonSize,
          width: buttonSize,
          decoration: BoxDecoration(
            color: ColorConstants.brownColor,
            shape: isVisible ? BoxShape.circle : BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: ColorConstants.brownColor.withOpacity(0.9),
                offset: const Offset(0, 13),
                blurRadius: 25,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Image.asset('assets/images/coffee/bean icon.png'),
        ),
      ),
    );
  }

  static Widget sizeSelector({
    required double size,
    required BuildContext context,
  }) {
    final buttonSize = 40.r;
    return Container(
      width: (buttonSize * 3) + 40.r,
      padding: EdgeInsets.symmetric(horizontal: 5.r, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorConstants.liteContainerColor,
        borderRadius: BorderRadius.circular(200.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _sizeSelectorSwitch(
            buttonSize: buttonSize,
            size: 0.0,
            text: 'S',
            context: context,
            isSelected: size == 0.0,
          ),
          _sizeSelectorSwitch(
            buttonSize: buttonSize,
            size: 0.5,
            text: 'M',
            context: context,
            isSelected: size == 0.5,
          ),
          _sizeSelectorSwitch(
            buttonSize: buttonSize,
            size: 1.0,
            text: 'L',
            context: context,
            isSelected: size == 1.0,
          ),
        ],
      ),
    );
  }

  static Widget _sizeSelectorSwitch({
    bool isSelected = false,
    required double buttonSize,
    required double size,
    required String text,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () => context
          .read<QuantityPageBloc>()
          .add(QuantityPageEventChangeSize(size)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        height: buttonSize,
        width: buttonSize,
        decoration: BoxDecoration(
          color: isSelected ? ColorConstants.brownColor : Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: [
                  BoxShadow(
                    color: ColorConstants.brownColor.withOpacity(isSelected?0.9:0.0),
                    offset: const Offset(0, 13),
                    blurRadius: 25,
                    spreadRadius: 4,
                  ),
                ]
            ,
        ),
        child: Center(
          child: kText(
            text: text,
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: isSelected
                ? ColorConstants.backGroundColor
                : ColorConstants.textColor.withOpacity(0.7),
          ),
        ),
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
            context.goNamed(RouteName.mixingPage);
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
}
