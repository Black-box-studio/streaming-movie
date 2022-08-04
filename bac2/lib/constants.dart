import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const kName = 'AZUL Movies';

const kMapAdmins = [
  {
    'email': 'admin',
    'password': 'admin',
  },
];

const kColorPrimary = Color(0xffe8505b);
const kColorWhite01 = Color(0xffffffff);

const kColorGrey01 = Color(0xfffcfcfc);
const kColorGrey05 = Color(0xffeeeeee);
const kColorGrey03 = Color(0xffb9b9b9);
const kColorGrey02 = Color(0xFF9E9E9E);
const kColorGrey04 = Color(0xff8b8b8b);

const kColorBlack01 = Color(0xff000000);
const kColorBlack02 = Color(0xff222222);
const kColorBlack03 = Color(0xff262626);
const kColorBlack04 = Color(0xff333333);

const kColorGreen01 = Color(0xFF4dcf92);

const double kIsTablet = 1250.0;

String getDateFormat(date) {
  return DateFormat("dd-MM-yyyy").format(date).toString();
}

String capitalize(String s) {
  try {
    return s[0].toUpperCase() + s.substring(1);
  } catch (e) {
    print(e);
    return s;
  }
}

const kShadow01 = [
  BoxShadow(
    color: Color(0x29000000),
    offset: Offset(0, 3),
    blurRadius: 6,
    spreadRadius: 0,
  )
];

const kGradient01 = LinearGradient(
  colors: [Color(0xff74ebd5), Color(0xffacb6e5)],
  stops: [0, 1],
  begin: Alignment(-0.00, -1.00),
  end: Alignment(0.00, 1.00),
  // angle: 180,
  // scale: undefined,
);
const kGradient02 = LinearGradient(
  colors: [Color(0xffeecda3), Color(0xffef629f)],
  stops: [0, 1],
  begin: Alignment(-0.00, -1.00),
  end: Alignment(0.00, 1.00),
  // angle: 180,
  // scale: undefined,
);
const kGradient03 = LinearGradient(
  colors: [Color(0xff74ffa7), Color(0xff0c9b9c)],
  stops: [0, 1],
  begin: Alignment(-0.00, -1.00),
  end: Alignment(0.00, 1.00),
  // angle: 180,
  // scale: undefined,
);
const kGradient04 = LinearGradient(
  colors: [Color(0xfffffbd5), Color(0xffed4264)],
  stops: [0, 1],
  begin: Alignment(-0.00, -1.00),
  end: Alignment(0.00, 1.00),
  // angle: 180,
  // scale: undefined,
);
const kGradient05 = LinearGradient(
  colors: [
    Color(0xffFF416C),
    Color(0xffFF4B2B),
    //Color(0xfff64f59),
  ],
  //stops: [0, 1, 0],
  begin: Alignment(-0.00, -1.00),
  end: Alignment(0.00, 1.00),
  // angle: 180,
  // scale: undefined,
);
const kGradient06 = LinearGradient(
  colors: [Color(0xff5433FF), Color(0xff20BDFF), Color(0xffA5FECB)],
  stops: [0, 1, 0],
  begin: Alignment(-0.00, -1.00),
  end: Alignment(0.00, 1.00),
  // angle: 180,
  // scale: undefined,
);

const kLogo01 =
    'https://cdn-biiinge.konbini.com/images/files/2017/08/onepiece-810x425.jpg';
