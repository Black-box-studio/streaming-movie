import 'package:flutter/material.dart';

class InitialProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Please wait...'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class InitialError extends StatelessWidget {
  final error;
  InitialError(this.error);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
              'Oops it\'s look like you have some trouble with Firebase...'),
        ),
        body: Center(
          child: Text('$error'),
        ),
      ),
    );
  }
}
