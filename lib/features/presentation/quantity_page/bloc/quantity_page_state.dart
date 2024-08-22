part of 'quantity_page_bloc.dart';

@immutable
sealed class QuantityPageState {}

final class QuantityPageInitial extends QuantityPageState {}

final class QuantityPageStateQuantity extends QuantityPageState {
  final double quantity;

  QuantityPageStateQuantity(this.quantity);
}

final class QuantityPageStateSize extends QuantityPageState {
  final double size;

  QuantityPageStateSize(this.size);
}
