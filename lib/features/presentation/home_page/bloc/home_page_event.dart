part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent {}

final class HomePageEventSetPaegOffset extends HomePageEvent {
  final double pageOffset;

  HomePageEventSetPaegOffset(this.pageOffset);
}
