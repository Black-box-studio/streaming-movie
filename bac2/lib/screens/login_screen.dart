import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  var _controllEmail = TextEditingController();
  var _controllPassword = TextEditingController();

  logInUser() {
    var _email = _controllEmail.text;
    var _password = _controllPassword.text;

    for (var admin in kMapAdmins) {
      if (admin['email'] == _email && admin['password'] == _password) {
        print("User is LogIn.");
        Navigator.pushReplacementNamed(context, '/welcome');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: Container(
        width: (mSize.width / 2) - 200,
        height: mSize.height / 2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5.0)],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Azul Movie Panel',
                textAlign: TextAlign.center,
                style: GoogleFonts.audiowide(
                  textStyle: TextStyle(
                      color: kColorPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0),
                ),
              ),
              Column(
                children: [
                  InputUser(
                    controller: _controllEmail,
                    hint: 'Admin email',
                    label: 'email',
                    prefixI: Icons.email,
                  ),
                  SizedBox(height: 20.0),
                  InputUser(
                    controller: _controllPassword,
                    hint: 'Admin password',
                    label: 'password',
                    prefixI: Icons.email,
                    isPass: true,
                  ),
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      child: Text('LogIn'),
                      color: kColorPrimary,
                      textColor: Colors.white,
                      onPressed: () {
                        logInUser();
                      },
                    ),
                  ),
                ],
              ),

              //  Spacer(),
            ],
          ),
        ),
      ),
    ));
  }
}

class InputUser extends StatelessWidget {
  final hint, label;
  final controller;
  final prefixI;
  final isPass;

  InputUser({
    this.hint,
    this.label,
    this.controller,
    this.prefixI,
    this.isPass = false,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: kColorPrimary,
      ),
      child: SizedBox(
        height: 45.0,
        child: TextField(
          maxLines: 1,
          obscureText: isPass,
          controller: controller,
          cursorColor: kColorPrimary,
          textAlign: TextAlign.start,
          //keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefixIcon: Icon(prefixI),
            alignLabelWithHint: true,
            contentPadding:
                EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: kColorPrimary)),
            hintText: '$hint',
            labelText: '$label',
          ),
        ),
      ),
    );
  }
}
