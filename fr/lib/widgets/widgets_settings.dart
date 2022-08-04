import 'package:azul_movies/models/database.dart';
import 'package:azul_movies/models/func.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class CardCheckUpdate extends StatelessWidget {
  final bool isDark;

  CardCheckUpdate({@required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160.0,
      decoration: BoxDecoration(
        color: kColorRed01,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [kBoxShadow01],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            kAppName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          FutureBuilder<String>(
              future: Func.getPackageVersion(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox();
                }
                return Text(
                  '$kAppName ${snapshot.data}v',
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                );
              }),
          Text(
            'by Azul_Mouad',
            style: TextStyle(color: Colors.white, fontSize: 10.0),
          ),
          FlatButton(
            onPressed: () async {
              //Check Update
              Database.checkUpdateApp(context);
            },
            textColor: Theme.of(context).primaryColor,
            color: isDark ? kColorBlack02 : Colors.white,
            child: Text(
              getTranslationText(context, 'check_update'),
              style: TextStyle(
                  color: isDark ? Colors.white : kColorBlack02, fontSize: 15.0),
            ),
          ),
        ],
      ),
    );
  }
}

class CardContainBack extends StatelessWidget {
  final bool isDark;
  final child;

  CardContainBack({@required this.isDark, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: isDark ? kColorBlack03 : kColorBlack03.withOpacity(0.10),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: child,
    );
  }
}

class CardTileAbout extends StatelessWidget {
  final String label;
  final icon;
  final Function onTap;

  CardTileAbout({
    @required this.label,
    this.icon,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            icon == null
                ? Icon(
                    isLayoutRTL(context)
                        ? FontAwesomeIcons.chevronLeft
                        : FontAwesomeIcons.chevronRight,
                    size: 12.0,
                  )
                : Icon(
                    icon,
                    size: 12.0,
                  ),
          ],
        ),
      ),
    );
  }
}

showPageAbout(context) {
  showAboutDialog(
    context: context,
    applicationName: '$kAppName',
    applicationVersion: '$kVersionApp',
    applicationLegalese: 'Copyright © Azul Mouad, {{ 2021 }}',
    children: [
      ListTile(
        title: Text('Developer'),
        leading: Icon(FontAwesomeIcons.solidAddressCard),
        onTap: () async {
          var urlString = 'https://www.linkedin.com/in/mouad-azul-8061a7176/';
          if (await canLaunch(urlString)) {
            await launch(urlString);
          }
        },
      ),
      ListTile(
        title: Text('about this app'),
        leading: Icon(FontAwesomeIcons.mobile),
        onTap: () async {
          await launch('https://codecanyon.net/user/azul_mouad/portfolio');
        },
      ),
      // LicensesPageListTile(
      //   icon: Icon(Icons.favorite),
      // ),
    ],
    applicationIcon: SizedBox(
      width: 90,
      height: 90,
      child: Image.asset(
        'assets/images/icon.png',
      ),
    ),
  );
  /* showAboutPage(
    context: context,
    applicationLegalese: 'Copyright © Azul Mouad, {{ 2021 }}',
    applicationDescription: Text(kAboutDialog),
    children: <Widget>[
      ListTile(
        title: Text('Developer'),
        leading: Icon(FontAwesomeIcons.solidAddressCard),
        onTap: () {},
      ),
      ListTile(
        title: Text('about this app'),
        leading: Icon(FontAwesomeIcons.mobile),
        onTap: () {},
      ),
      LicensesPageListTile(
        icon: Icon(Icons.favorite),
      ),
    ],
    applicationIcon: SizedBox(
      width: 200,
      height: 200,
      child: Image.asset(
        'assets/images/icon.png',
      ),
    ),
  );*/
}
