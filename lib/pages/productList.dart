import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../models/productModel.dart';
import 'cardProductList.dart';

class ProductListWidget extends StatefulWidget {
  const ProductListWidget({Key? key, required this.isSavedProductPage, required this.isSortedPrice})
      : super(key: key);
  final bool isSavedProductPage;
  final bool isSortedPrice;

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  final ProductBloc productBloc = ProductBloc();

  @override
  void initState() {
    productBloc.add(GetProductListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isSortedPrice = widget.isSortedPrice;

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
            } else if (state is ProductLoadingState) {
              return _buildLoading();
            } else if (state is ProductLoadedState) {
              // List<double> priceList = [];
              // if(isSortedPrice){
              //   for(int i=0;i<state.productModel.productItems!.length;i++){
                  
              //   }
              // }
              return CardProductList(
                  product: state.productModel,
                  savedProductList: state.savedProductList,
                  isSavedProductPage: widget.isSavedProductPage);
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
