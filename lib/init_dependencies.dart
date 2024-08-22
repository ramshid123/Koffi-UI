import 'package:coffee_ui/features/presentation/home_page/bloc/home_page_bloc.dart';
import 'package:coffee_ui/features/presentation/quantity_page/bloc/quantity_page_bloc.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future initDependencies() async {
  serviceLocator
    ..registerLazySingleton<QuantityPageBloc>(() => QuantityPageBloc())
    ..registerLazySingleton<HomePageBloc>(() => HomePageBloc());
}
