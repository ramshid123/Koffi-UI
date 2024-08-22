import 'package:coffee_ui/core/route/routes.dart';
import 'package:coffee_ui/features/presentation/home_page/bloc/home_page_bloc.dart';
import 'package:coffee_ui/features/presentation/quantity_page/bloc/quantity_page_bloc.dart';
import 'package:coffee_ui/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QuantityPageBloc>(create: (context) => serviceLocator()),
        BlocProvider<HomePageBloc>(create: (context) => serviceLocator()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(392.72727272727275, 803.6363636363636),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: Routes.goRoutes,
        ),
      ),
    );
  }
}
