import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_siampiwat/models/productModel.dart';
import 'package:test_siampiwat/repository/product.dart';

part 'product_event.dart';
part 'product_state.dart';

List<int> savedList = [-1]; // if savedList = [] then we check value contain, its gonna crash, store product id that saved to Save
List<int> cartListId = [-1]; // if cartListId = [] then we check value contain, its gonna crash, store product id that add to Cart
double totalPrice = 0; // sum(qunatity*price)
Product? cartList = Product(productItems: [], totalPrice: 0); // for store product that added to cart

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<GetProductListEvent>((event, emit) async {
      try {
        emit(ProductLoadingState());
        final productList = await ProductRepo().getProductList();
        // await Future.delayed(Duration(milliseconds: 500));
        emit(ProductLoadedState(productList, savedList));
      } on NetworkError {
        emit(const ProductErrorState("failed to fectch data."));
      }
    });

    on<GetCartListEvent>((event, emit) async {
      emit(CartLoadingState());
      // await Future.delayed(Duration(milliseconds: 500));
      emit(CartLoadedState(cartList));
    });
    on<SavedProductEvent>((event, emit) {
      if (!savedList.contains(event.id)) {
        savedList.add(event.id);
      }
    });
    on<UnSaveProductEvent>((event, emit) {
      if (savedList.contains(event.id)) {
        savedList.remove(event.id);
      }
    });
    on<AddToCartEvent>((event, emit) {
      if (!cartListId.contains(event.productItem.id)) {
        totalPrice += event.productItem.price;
        cartListId.add(event.productItem.id);
        cartList!.productItems!.add(event.productItem);
        cartList!.totalPrice = totalPrice;
        emit(CartLoadedState(cartList));
      }
    });
    on<RemoveFromCartEvent>((event, emit) {
      if (cartList!.productItems!.contains(event.productItem)) {
        totalPrice -= (event.productItem.price *
            cartList!.productItems![event.index].quantity);
        cartListId.remove(event.productItem.id);
        cartList!.productItems!.remove(event.productItem);
        cartList!.totalPrice = totalPrice;
        emit(CartLoadedState(cartList));
      }
    });
    on<AddQuantityProductEvent>(
      (event, emit) {
        totalPrice += cartList!.productItems![event.index].price;
        cartList!.productItems![event.index].quantity++;
        cartList!.totalPrice = totalPrice;
        emit(CartLoadedState(cartList));
      },
    );
    on<RemoveQuantityProductEvent>((event, emit) {
      if (cartList!.productItems![event.index].quantity > 1) {
        totalPrice -= cartList!.productItems![event.index].price;
        cartList!.productItems![event.index].quantity--;
        cartList!.totalPrice = totalPrice;
        emit(CartLoadedState(cartList));
      }
    });
  }
}
