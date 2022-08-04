import 'package:azul_movies/constants.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CardVisible extends StatelessWidget {
  final isVisible;
  final child;

  CardVisible({@required this.isVisible, @required this.child});

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.bounceInOut,
            child: child,
          )
        : SizedBox();
  }
}

showTopSnackBare(
    {context, message, isError = false, isSuccess = false, isInfo = false}) {
  if (isSuccess) {
    showTopSnackBar(
      context,
      CustomSnackBar.success(
        message: "$message",
        backgroundColor: Colors.green,
      ),
    );
  }
  if (isError) {
    showTopSnackBar(
      context,
      CustomSnackBar.error(
        message: "$message",
        backgroundColor: Colors.redAccent,
      ),
    );
  }
  if (isInfo) {
    showTopSnackBar(
      context,
      CustomSnackBar.info(
        message: "$message",
        backgroundColor: kColorOrange01,
      ),
    );
  }
}
