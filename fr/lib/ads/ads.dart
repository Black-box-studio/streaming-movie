import 'package:flutter/material.dart';

class AdsDevice {
  static showInterstitial() async {}

  static showRewardVideo() async {}

  static Widget showBanner() {
    return Container(
      height: 45.0,
      width: double.infinity,
      color: Colors.grey,
      child: Center(),
    );
  }

  static showNative() async {
    return Container(
      height: 200.0,
      width: double.infinity,
      color: Colors.grey,
      child: Center(),
    );
  }

  static showNativeBanner() async {
    return Container(
      height: 150.0,
      width: double.infinity,
      color: Colors.grey,
      child: Center(),
    );
  }
}
