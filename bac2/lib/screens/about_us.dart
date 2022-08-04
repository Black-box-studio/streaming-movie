import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: mSize.width / 2,
        height: (mSize.height / 2) + 300,
        padding: EdgeInsets.all(25.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: kShadow01,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              maxRadius: 105.0,
              backgroundColor: kColorPrimary,
              child: CircleAvatar(
                maxRadius: 100.0,
                backgroundColor: kColorPrimary,
                backgroundImage: AssetImage('assets/images/avatar.jpg'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Azul Mouad',
                style: TextStyle(
                    fontSize: 18.0,
                    color: kColorBlack02,
                    fontWeight: FontWeight.bold),
              ),
            ),
            CardTileInfo(
              label: 'moad.developer@gmail.com',
              icon: FontAwesomeIcons.at,
              onTap: () async {
                await launch('mailto:moad.developer@gmail.com');
              },
            ),
            CardTileInfo(
              label: 'LinkedIn',
              icon: FontAwesomeIcons.linkedinIn,
              onTap: () async {
                await launch(
                    'https://www.linkedin.com/in/mouad-azul-8061a7176/');
              },
            ),
            CardTileInfo(
              label: 'Instagram',
              icon: FontAwesomeIcons.instagram,
              onTap: () async {
                await launch('https://www.instagram.com/azul_mouad');
              },
            ),
            CardTileInfo(
              label: 'Web',
              icon: FontAwesomeIcons.weebly,
              onTap: () async {
                await launch(
                    'https://codecanyon.net/user/azul_mouad/portfolio');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CardTileInfo extends StatelessWidget {
  final label;
  final icon;
  final onTap;

  CardTileInfo({this.onTap, this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.0,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: kColorPrimary,
        ),
        title: Text(
          '$label',
          style: TextStyle(color: kColorBlack02, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
