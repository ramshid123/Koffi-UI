import 'package:coffee_ui/core/constants/theme/palette.dart';
import 'package:coffee_ui/core/route/routes.dart';
import 'package:coffee_ui/core/widgets/common.dart';
import 'package:coffee_ui/features/presentation/home_page/bloc/home_page_bloc.dart';
import 'package:coffee_ui/features/presentation/home_page/view/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with RouteAware, SingleTickerProviderStateMixin {
  final pageController = PageController(viewportFraction: 0.5, initialPage: 1);
  // final pageOffset = ValueNotifier(0.0);

  late AnimationController _exitAnimationController;
  late Animation _exitAnimation;

  @override
  void initState() {
    _exitAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _exitAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _exitAnimationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    _exitAnimationController.value = 1;
    Future.delayed(const Duration(seconds: 1), () async {
      _exitAnimationController.reverse();
    });

    pageController.addListener(pageListener);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Subscribe this page to RouteObserver
    final ModalRoute? modalRoute = ModalRoute.of(context);
    if (modalRoute is PageRoute) {
      Routes.routeObserver.subscribe(this, modalRoute);
    }
  }

  @override
  void didPopNext() {
    Future.delayed(const Duration(milliseconds: 0),
        () async => await _exitAnimationController.reverse());
  }

  void pageListener() {
    context
        .read<HomePageBloc>()
        .add(HomePageEventSetPaegOffset(pageController.page ?? 0.0));
  }

  @override
  void dispose() {
    // Unsubscribe to avoid memory leaks
    Routes.routeObserver.unsubscribe(this);
    _exitAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _exitAnimation,
        builder: (context, _) {
          return Scaffold(
            backgroundColor: ColorConstants.backGroundColor,
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () async {
            //     _exitAnimationController.reset();
            //     await _exitAnimationController.forward();
            //     await Future.delayed(const Duration(seconds: 1));
            //     await _exitAnimationController.reverse();
            //   },
            // ),
            body: SafeArea(
              child: Container(
                clipBehavior: Clip.none,
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kHeight(20.h),
                    Row(
                      children: [
                        Transform.translate(
                          offset: Offset(_exitAnimation.value * -100.w, 0.0),
                          child: Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: const BoxDecoration(
                              color: ColorConstants.liteContainerColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.apps,
                              size: 30.r,
                              color: ColorConstants.iconColor,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Transform.translate(
                          offset: Offset(_exitAnimation.value * 100.w, 0.0),
                          child: Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: const BoxDecoration(
                              color: ColorConstants.liteContainerColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add,
                              size: 30.r,
                              color: ColorConstants.iconColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    kHeight(20.h),
                    Transform.translate(
                      offset: Offset(0.0, _exitAnimation.value * -300.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kText(
                            text: 'Good Morning',
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.liteTextColor,
                          ),
                          kText(
                            text: 'Ramshid 👋',
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                          kHeight(5.h),
                          kText(
                            text: 'What would you like to drink today?',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                    kHeight(60.h),
                    BlocBuilder<HomePageBloc, HomePageState>(
                      buildWhen: (prev, current) {
                        if (current is HomePageStatePageOffset) {
                          return true;
                        }
                        return false;
                      },
                      builder: (context, state) {
                        double pageOffset = 1.0;
                        if (state is HomePageStatePageOffset) {
                          pageOffset = state.pageOffset;
                        }
                        return HomePageWidgets.coffeeSelectionContainer(
                          pageController: pageController,
                          pageOffset: pageOffset,
                          animation: _exitAnimation,
                        );
                      },
                    ),
                    kHeight(70.h),
                    Transform.translate(
                      offset: Offset(0.0, _exitAnimation.value * 150.h),
                      child: HomePageWidgets.continueButton(
                          context: context,
                          animController: _exitAnimationController),
                    ),
                    kHeight(70.h),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
