import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:test_siampiwat/configs/FontTheme.dart';

import '../configs/AppTheme.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({Key? key, required this.price}) : super(key: key);
  final double price;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;

    return Scaffold(
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
        title: Text(
          "Checkout",
          style: FontTheme.font26,
        ),
        centerTitle: false,
      ),
      body: Container(
        color: AppTheme.lightGrey,
        child: SafeArea(
            child: Container(
          color: AppTheme.lightGrey,
          height: newheight,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTheme.black,
                    width: 8,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: QrImage(
                  data: "https://payment.spw.challenge/checkout?price=$price",
                  version: QrVersions.auto,
                  size: 250.0,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                child: Text(
                  "Scan & Pay",
                  style: FontTheme.font32,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                child: Text(
                  "\$$price",
                  style: FontTheme.font26,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
