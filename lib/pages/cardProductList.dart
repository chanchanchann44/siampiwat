import 'package:flutter/material.dart';
import 'package:test_siampiwat/bloc/product_bloc.dart';
import 'package:test_siampiwat/pages/widgets/alert.dart';
import '../configs/AppTheme.dart';
import '../configs/FontTheme.dart';
import '../models/productModel.dart';
import 'productDetail.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardProductList extends StatefulWidget {
  const CardProductList(
      {Key? key,
      required this.product,
      required this.savedProductList,
      required this.isSavedProductPage})
      : super(key: key);
  final Product product;
  final List<int> savedProductList;
  final bool isSavedProductPage;

  @override
  State<CardProductList> createState() => _CardProductListState();
}

class _CardProductListState extends State<CardProductList> {
  @override
  Widget build(BuildContext context) {
    final ProductBloc productBloc = ProductBloc();
    final product = widget.product.productItems;
    final savedProductList = widget.savedProductList;
    final isSavedProductPage = widget.isSavedProductPage;
    final List<ProductItem>? savedProduct = [];
    final List<ProductItem>? listProduct;
    final FaIcon faIcon;
    final String faIconText;
    if (isSavedProductPage) {
      for (int i = 0; i < product!.length; i++) {
        if (savedProductList.contains(product[i].id)) {
          savedProduct!.add(product[i]);
        }
      }
      listProduct = savedProduct;
      faIcon = const FaIcon(FontAwesomeIcons.heart,size: 100,color: AppTheme.grey,);
      faIconText = "Have no Saved Product.";
    } else {
      listProduct = product;
      faIcon = const FaIcon(FontAwesomeIcons.house,size: 100,color: AppTheme.grey,);
      faIconText = "Have no Product.";
    }
    return (listProduct!.isEmpty)
        ? Center(
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                faIcon,
                const SizedBox(height: 16,),
                Text(faIconText,style: FontTheme.font20.copyWith(color: AppTheme.grey),)
              ],
            ),
          )
        : GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            children: List.generate(listProduct.length, (index) {
              return InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(
                        item: listProduct![index],
                        savedProductList: savedProductList,
                      ),
                    ),
                  );
                  setState(() {});
                },
                child: Card(
                  margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: [
                          Image.network(listProduct![index].imageUrl,
                              height: 150, fit: BoxFit.cover),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: InkWell(
                              onTap: () {
                                if (savedProductList
                                    .contains(listProduct![index].id)) {
                                  conformationAlert(
                                    titleText: "Remove from Saved",
                                    text: "Are you sure you want to remove?",
                                    scaffoldText:
                                        "Product is removed from your Saved.",
                                    function: () {
                                      productBloc.add(UnSaveProductEvent(
                                          listProduct![index].id));
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    context: context,
                                  );
                                } else {
                                  productBloc.add(
                                      SavedProductEvent(listProduct[index].id));
                                  scaffoldMessage(
                                      context: context,
                                      text: "Product is saved to your Saved.");
                                }
                                setState(() {});
                              },
                              child: Icon(
                                Icons.favorite_border,
                                color: (savedProductList
                                        .contains(listProduct[index].id)
                                    ? AppTheme.red
                                    : AppTheme.grey),
                                size: 24.0,
                              ),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                listProduct[index].name,
                                style: FontTheme.font17,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                              Text(
                                "\$${listProduct[index].price}",
                                style: FontTheme.font17,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
  }
}
