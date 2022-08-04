import 'package:flutter/material.dart';

showSnackBar(context, message) {
  final snackBar = SnackBar(content: Text('$message'));
  // ignore: deprecated_member_use
  Scaffold.of(context).showSnackBar(snackBar);
}

showConfirmeDialog(
    {@required BuildContext context, String message, Function action}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: 'Are u sure you want to delete this Item ',
            style: TextStyle(color: Colors.black54),
          ),
          TextSpan(
            text: message,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ]),
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.orangeAccent,
          textColor: Colors.white,
          child: Text('Cancel'),
        ),
        FlatButton(
          onPressed: () {
            action();
            Navigator.pop(context);
          },
          color: Colors.red,
          textColor: Colors.white,
          child: Text('Yes'),
        ),
      ],
    ),
  );
}
