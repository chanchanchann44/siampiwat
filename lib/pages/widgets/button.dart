import 'package:flutter/material.dart';
import '../../configs/FontTheme.dart';

class OutlinedButtonWidget extends StatelessWidget {
  const OutlinedButtonWidget({Key? key,required this.function,required this.text}) : super(key: key);
  final Function() function;
  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: function,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
      ),
      child: Text(
        text,
        style: FontTheme.font17,
      ),
    );
  }
}
