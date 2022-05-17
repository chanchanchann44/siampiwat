import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_siampiwat/models/productModel.dart';
import 'package:test_siampiwat/pages/widgets/alert.dart';
import 'package:test_siampiwat/pages/widgets/button.dart';

import '../bloc/product_bloc.dart';
import '../configs/AppTheme.dart';
import '../configs/FontTheme.dart';
import 'checkoutPage.dart';

class CartList extends StatefulWidget {
  const CartList({
    Key? key,
    required this.height,
    required this.cartList,
  }) : super(key: key);
  final double height;
  final Product? cartList;

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  final ProductBloc productBloc = ProductBloc();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = widget.height;
    final productList = widget.cartList;
    final cartList = widget.cartList!.productItems;

    return (cartList!.isEmpty)
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FaIcon(
                  FontAwesomeIcons.cartShopping,
                  size: 100,
                  color: AppTheme.grey,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Have no Product in Cart.",
                  style: FontTheme.font20.copyWith(color: AppTheme.grey),
                )
              ],
            ),
          )
        : Column(
            children: [
              SizedBox(
                height: height - 80,
                child: ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: SwipeActionCell(
                          key: ObjectKey(cartList[index]),
                          trailingActions: <SwipeAction>[
                            SwipeAction(
                                title: "delete",
                                onTap: (CompletionHandler handler) async {
                                  conformationAlert(
                                    titleText: "Remove from Cart",
                                    text: "Are you sure you want to remove?",
                                    scaffoldText:
                                        "Product is removed from your Cart.",
                                    function: () {
                                      productBloc.add(RemoveFromCartEvent(
                                          cartList[index], index));
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    context: context,
                                  );
                                },
                                color: AppTheme.red),
                          ],
                          child: Container(
                              height: 140,
                              width: width,
                              padding: const EdgeInsets.only(left: 8),
                              child: Row(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    height: 140,
                                    width: width / 3,
                                    child: Image.network(
                                        cartList[index].imageUrl,
                                        fit: BoxFit.cover),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              width: width - 170,
                                              child: Text(
                                                cartList[index].name,
                                                style: FontTheme.font17,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              width: width - 170,
                                              child: Text(
                                                "\$${cartList[index].price}",
                                                style: FontTheme.font17,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: AppTheme.blue,
                                                  spreadRadius: 1),
                                            ],
                                          ),
                                          height: 35,
                                          width: 140,
                                          child: Row(children: [
                                            Container(
                                              alignment: Alignment.center,
                                              width: 40,
                                              height: 35,
                                              child: InkWell(
                                                onTap: () {
                                                  productBloc.add(
                                                      RemoveQuantityProductEvent(
                                                          index));
                                                  setState(() {});
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: AppTheme.blue,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: 60,
                                              height: 35,
                                              child: Text(
                                                cartList[index]
                                                    .quantity
                                                    .toString(),
                                                style: FontTheme.font17,
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: 40,
                                              height: 35,
                                              child: InkWell(
                                                onTap: () {
                                                  productBloc.add(
                                                      AddQuantityProductEvent(
                                                          index));
                                                  // context.read<ProductBloc>().add(
                                                  //     AddQuantityProductEvent(index));
                                                  setState(() {});
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  color: AppTheme.blue,
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ),
                      );
                    }),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Toal : \$${productList!.totalPrice}",
                      style: FontTheme.font20,
                    ),
                    OutlinedButtonWidget(
                        function: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckOutPage(
                                  price: productList.totalPrice!,
                                ),
                              ),
                            ),
                        text: "Checkout"),
                  ],
                ),
              ),
            ],
          );
  }
}
