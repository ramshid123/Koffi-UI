part of 'home_page_bloc.dart';

@immutable
sealed class HomePageState {}

final class HomePageInitial extends HomePageState {}

final class HomePageStatePageOffset extends HomePageState {
  final double pageOffset;

  HomePageStatePageOffset(this.pageOffset);
}


final class HomePageStateCoffeeName extends HomePageState {
  final String coffeeName;

  HomePageStateCoffeeName(this.coffeeName);
}
