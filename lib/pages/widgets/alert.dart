import 'package:flutter/material.dart';

conformationAlert(
    {required titleText, required text,required scaffoldText, required function, required context}) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(titleText),
      content: Text(text),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            function();
            scaffoldMessage(context: context, text: scaffoldText);
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

scaffoldMessage({required text, required context}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
      // action: SnackBarAction(
      // label: 'Hide',
      // onPressed: () {
      //     ScaffoldMessenger.of(context).hideCurrentSnackBar;
      // },
    // ),
    ),
  );
}
