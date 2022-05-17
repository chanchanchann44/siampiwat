import 'package:flutter/material.dart';
import 'package:test_siampiwat/configs/FontTheme.dart';
import 'package:test_siampiwat/pages/widgets/button.dart';

import '../bloc/product_bloc.dart';
import '../configs/AppTheme.dart';
import '../models/productModel.dart';
import 'widgets/alert.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail(
      {Key? key, required this.item, required this.savedProductList})
      : super(key: key);
  final ProductItem item;
  final List<int> savedProductList;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final ProductBloc productBloc = ProductBloc();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;
    final item = widget.item;
    final savedProductList = widget.savedProductList;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        iconTheme: const IconThemeData(color: AppTheme.black),
        backgroundColor: AppTheme.lightGrey,
        elevation: 0,
      ),
      body: Container(
        color: AppTheme.lightGrey,
        child: SafeArea(
            child: Container(
          color: AppTheme.lightGrey,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: newheight,
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              width: double.infinity,
              child: Image.network(item.imageUrl, fit: BoxFit.cover),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width - 24 - 32 - 32,
                    child: Text(
                      item.name,
                      style: FontTheme.font20,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (savedProductList.contains(item.id)) {
                        conformationAlert(
                          titleText: "Remove from Saved",
                          text: "Are you sure you want to remove?",
                          scaffoldText: "Product is removed from your Saved.",
                          function: () {
                            productBloc.add(UnSaveProductEvent(item.id));
                            Navigator.pop(context);
                            setState(() {});
                          },
                          context: context,
                        );
                      } else {
                        productBloc.add(SavedProductEvent(item.id));
                        scaffoldMessage(
                            context: context,
                            text: "Product is saved to your Saved.");
                      }
                      setState(() {});
                    },
                    child: Icon(
                      Icons.favorite_border,
                      color: (savedProductList.contains(item.id)
                          ? AppTheme.red
                          : AppTheme.grey),
                      size: 24.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                "\$${item.price}",
                style: FontTheme.font20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: OutlinedButtonWidget(
                    function: () {
                      if (cartListId.contains(item.id)) {
                        cartList!.productItems!
                            .asMap()
                            .forEach((index, value) => {
                                  if (value.id == item.id)
                                    {
                                      productBloc.add(RemoveFromCartEvent(
                                          cartList!.productItems![index],
                                          index))
                                    }
                                });

                        scaffoldMessage(
                            context: context,
                            text: "Product is removed from your Cart.");
                      } else {
                        productBloc.add(AddToCartEvent(item));
                        scaffoldMessage(
                            context: context,
                            text: "Product is added to your Cart.");
                      }

                      setState(() {});
                    },
                    text: (cartListId.contains(item.id)
                        ? "Remove from Cart"
                        : "Add to Cart")),
              ),
            ),
          ]),
        )),
      ),
    );
  }
}
