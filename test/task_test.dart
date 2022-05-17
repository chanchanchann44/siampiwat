import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test_siampiwat/bloc/product_bloc.dart';
import 'package:test_siampiwat/bloc/test/mock_task_repository.dart';
import 'package:test_siampiwat/models/productModel.dart';

void main() async {
  final mockTasksProductItem = MockTasks();
  group('ProductBloc test', () {
    blocTest<ProductBloc, ProductState>(
      'emit loading state after added product to cart',
      build: () => ProductBloc(),
      act: (bloc) {
        bloc.add(AddToCartEvent(mockTasksProductItem.mockTasksProductItem1));
        bloc.add(AddToCartEvent(mockTasksProductItem.mockTasksProductItem2));
        bloc.add(AddToCartEvent(mockTasksProductItem.mockTasksProductItem3));
      },
      expect: () => [CartLoadedState(cartList)],
    );

    blocTest<ProductBloc, ProductState>(
      'emit loading state from cart',
      build: () => ProductBloc(),
      act: (bloc) => bloc.add(GetCartListEvent()),
      expect: () => [
        CartLoadingState(),
        CartLoadedState(Product(productItems: [
          ProductItem(
              id: 1, imageUrl: 'url1', name: 'name1', price: 30.0, quantity: 1),
          ProductItem(
              id: 2, imageUrl: 'url2', name: 'name2', price: 40.0, quantity: 1),
          ProductItem(
              id: 3, imageUrl: 'url3', name: 'name3', price: 50.0, quantity: 1),
        ], totalPrice: 120)),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emit product state after removed product from cart',
      build: () => ProductBloc(),
      act: (bloc) => bloc.add(
          RemoveFromCartEvent(mockTasksProductItem.mockTasksProductItem1, 0)), // remove product from cart index at [0]
      expect: () => [
        CartLoadedState(Product(productItems: [
          ProductItem(
              id: 2, imageUrl: 'url2', name: 'name2', price: 40.0, quantity: 1),
          ProductItem(
              id: 3, imageUrl: 'url3', name: 'name3', price: 50.0, quantity: 1),
        ], totalPrice: 90))
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emit product state after add quantity, total should return 140 [sum(price*quantity)]',
      build: () => ProductBloc(),
      act: (bloc) => bloc.add(const AddQuantityProductEvent(1)), // product quantity index at [1], +1
      expect: () => [
        CartLoadedState(Product(productItems: [
          ProductItem(
              id: 2, imageUrl: 'url2', name: 'name2', price: 40.0, quantity: 1),
          ProductItem(
              id: 3, imageUrl: 'url3', name: 'name3', price: 50.0, quantity: 2),
        ], totalPrice: 140))
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emit product state after minus quantity, total should return 90 [sum(price*quantity)]',
      build: () => ProductBloc(),
      act: (bloc) => bloc.add(const RemoveQuantityProductEvent(1)), // product quantity index at [1], -1
      expect: () => [
        CartLoadedState(Product(productItems: [
          ProductItem(
              id: 2, imageUrl: 'url2', name: 'name2', price: 40.0, quantity: 1),
          ProductItem(
              id: 3, imageUrl: 'url3', name: 'name3', price: 50.0, quantity: 1),
        ], totalPrice: 90))
      ],
    );
  });
}
