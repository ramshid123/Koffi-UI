import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageEventSetPaegOffset>(_onHomePageEventSetPaegOffset);

    on<HomePageEventSetCoffeeName>(_onHomePageEventSetCoffeeName);
  }

  void _onHomePageEventSetPaegOffset(
      HomePageEventSetPaegOffset event, Emitter<HomePageState> emit) {
    emit(HomePageStatePageOffset(event.pageOffset));
  }

  void _onHomePageEventSetCoffeeName(
      HomePageEventSetCoffeeName event, Emitter<HomePageState> emit) {
    emit(HomePageStateCoffeeName(event.coffeeName));
  }
}
