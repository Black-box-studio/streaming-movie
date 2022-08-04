import 'package:flutter/material.dart';

class ProgressCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50.0,
        height: 50.0,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
