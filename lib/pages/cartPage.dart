import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_siampiwat/pages/cartList.dart';
import '/bloc/product_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key, required this.height}) : super(key: key);
  final double height;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final ProductBloc productBloc = ProductBloc();

  @override
  void initState() {
    productBloc.add(GetCartListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => productBloc,
      child: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductInitial) {
              return _buildLoading();
            } else if (state is CartLoadingState) {
              return _buildLoading();
            } else if (state is CartLoadedState) {
              return CartList(
                height: widget.height,
                cartList: state.cartList,
              );
            } else if (state is ProductErrorState) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
