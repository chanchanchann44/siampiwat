part of 'product_bloc.dart';

// remove Equatable if you want the same state back-to-back to trigger multiple transitions
abstract class ProductState extends Equatable {
// abstract class ProductState {
  const ProductState();

  @override
  List<Product?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoadingState extends ProductState {}

class CartLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final Product productModel;
  final List<int> savedProductList;
  const ProductLoadedState(this.productModel, this.savedProductList);
}

class ProductErrorState extends ProductState {
  final String message;
  const ProductErrorState(this.message);
}

class CartLoadedState extends ProductState {
  final Product? cartList;
  const CartLoadedState(this.cartList);

  @override
  List<Product?> get props => [cartList];
}
