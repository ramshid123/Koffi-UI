part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent {}

final class HomePageEventSetPaegOffset extends HomePageEvent {
  final double pageOffset;

  HomePageEventSetPaegOffset(this.pageOffset);
}

final class HomePageEventSetCoffeeName extends HomePageEvent {
  final String coffeeName;

  HomePageEventSetCoffeeName(this.coffeeName);
}
