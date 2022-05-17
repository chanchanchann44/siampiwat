import 'package:flutter/material.dart';
import 'package:test_siampiwat/configs/FontTheme.dart';
import 'package:test_siampiwat/pages/productList.dart';

import '../configs/AppTheme.dart';
import 'cartPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.indexPage}) : super(key: key);
  final int indexPage;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool isSortedPrice = false;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.indexPage;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: AppTheme.lightGrey,
      bottomNavigationBar: SizedBox(
        height: 100,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded),
              label: 'Cart',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppTheme.blue,
          onTap: _onItemTapped,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 8),
              alignment: Alignment.centerLeft,
              height: 60,
              child: Row(
                children: [
                  Text(
                    (_selectedIndex == 0)
                        ? 'For You'
                        : (_selectedIndex == 1)
                            ? "Saved"
                            : "Cart",
                    style: FontTheme.font26,
                  ),
                  // TextButton(
                  //   style: ButtonStyle(
                  //     foregroundColor:
                  //         MaterialStateProperty.all<Color>(Colors.blue),
                  //   ),
                  //   onPressed: () {
                  //     print("onPress");
                  //     setState(() {
                  //       isSortedPrice = true;
                  //     });
                  //   },
                  //   child: const Text('Filter by price'),
                  // )
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 400,
                maxHeight: newheight - 60 - 100,
              ),
              child: (_selectedIndex == 0)
                  ? ProductListWidget(
                      isSavedProductPage: false,
                      isSortedPrice: isSortedPrice,
                    )
                  : (_selectedIndex == 1)
                      ?  ProductListWidget(
                          isSavedProductPage: true,
                          isSortedPrice: isSortedPrice,
                        )
                      : CartPage(height: newheight - 60 - 100),
            ),
          ],
        ),
      ),
    );
  }
}
