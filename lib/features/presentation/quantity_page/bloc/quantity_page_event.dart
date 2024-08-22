part of 'quantity_page_bloc.dart';

@immutable
sealed class QuantityPageEvent {}

final class QuantityPageEventChangeQuantity extends QuantityPageEvent {
  final double quantity;

  QuantityPageEventChangeQuantity(this.quantity);
}

final class QuantityPageEventChangeSize extends QuantityPageEvent {
  final double size;

  QuantityPageEventChangeSize(this.size);
}
