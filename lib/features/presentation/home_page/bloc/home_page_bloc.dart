import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageEventSetPaegOffset>(_onHomePageEventSetPaegOffset);
  }

  void _onHomePageEventSetPaegOffset(
      HomePageEventSetPaegOffset event, Emitter<HomePageState> emit) {
    emit(HomePageStatePageOffset(event.pageOffset));
  }
}
