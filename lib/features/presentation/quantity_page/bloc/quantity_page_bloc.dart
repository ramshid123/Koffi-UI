import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quantity_page_event.dart';
part 'quantity_page_state.dart';

class QuantityPageBloc extends Bloc<QuantityPageEvent, QuantityPageState> {
  QuantityPageBloc() : super(QuantityPageInitial()) {
    on<QuantityPageEventChangeQuantity>(
        (event, emit) => _onQuantityPageEventChangeQuantity(event, emit));

    on<QuantityPageEventChangeSize>(
        (event, emit) => _onQuantityPageEventChangeSize(event, emit));
  }

  void _onQuantityPageEventChangeQuantity(
      QuantityPageEventChangeQuantity event, Emitter<QuantityPageState> emit) {
    log('QuantityPageEventChangeQuantity');
    emit(QuantityPageStateQuantity(event.quantity));
  }

  void _onQuantityPageEventChangeSize(
      QuantityPageEventChangeSize event, Emitter<QuantityPageState> emit) {
    emit(QuantityPageStateSize(event.size));
  }

  @override
  void onChange(Change<QuantityPageState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
