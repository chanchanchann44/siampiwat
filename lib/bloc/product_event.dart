part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductListEvent extends ProductEvent {}

class GetCartListEvent extends ProductEvent {}

class SavedProductEvent extends ProductEvent {
  final int id;

  const SavedProductEvent(this.id);

  @override
  List<Object> get props => [id];
}

class UnSaveProductEvent extends ProductEvent {
  final int id;

  const UnSaveProductEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AddToCartEvent extends ProductEvent {
  final ProductItem productItem;

  const AddToCartEvent(this.productItem);

  @override
  List<Object> get props => [productItem];
}

class RemoveFromCartEvent extends ProductEvent {
  final ProductItem productItem;
  final int index;

  const RemoveFromCartEvent(this.productItem, this.index);

  @override
  List<Object> get props => [productItem];
}

class AddQuantityProductEvent extends ProductEvent {
  final int index;

  const AddQuantityProductEvent(this.index);

  @override
  List<Object> get props => [index];
}

class RemoveQuantityProductEvent extends ProductEvent {
  final int index;

  const RemoveQuantityProductEvent(this.index);

  @override
  List<Object> get props => [index];
}

class CheckTotalPrice extends ProductEvent {
  final int num;

  const CheckTotalPrice(this.num);

  @override
  List<Object> get props => [num];
}
