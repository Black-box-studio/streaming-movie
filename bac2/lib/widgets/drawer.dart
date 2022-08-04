import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panel_back_end/constants.dart';

class DrawerMain extends StatelessWidget {
  final Function indexPage;
  final int index;

  DrawerMain({
    @required this.indexPage,
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context).size;
    bool isTablet = mSize.width < kIsTablet;

    return AnimatedContainer(
      width: isTablet ? 100.0 : 250.0,
      height: mSize.height,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x29000000),
            offset: Offset(0, 3),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ListView(
        children: [
          SizedBox(height: 10.0),
          CardTile(
            isSelected: index == 0,
            label: 'Dashboard',
            icon: FontAwesomeIcons.tachometerAlt,
            onTap: () => indexPage(0),
          ),
          CardTile(
            isSelected: index == 1,
            icon: FontAwesomeIcons.tv,
            label: 'Upload Movies',
            onTap: () => indexPage(1),
          ),
          CardTile(
            isSelected: index == 2,
            icon: FontAwesomeIcons.film,
            label: 'Upload Series',
            onTap: () => indexPage(2),
          ),
          CardTile(
            isSelected: index == 3,
            icon: FontAwesomeIcons.magic,
            label: 'Upload Shows',
            onTap: () => indexPage(3),
          ),
          CardTile(
            isSelected: index == 4,
            icon: FontAwesomeIcons.upload,
            label: 'Editor Shoosen',
            onTap: () => indexPage(4),
          ),
          /* CardTile(
            isSelected: index == 5,
            icon: FontAwesomeIcons.upload,
            label: 'Recommended',
            onTap: () {
              indexPage(5);
            },
          ),*/
          CardTile(
            isSelected: index == 5,
            icon: FontAwesomeIcons.upload,
            label: 'Upload The Top',
            onTap: () => indexPage(5),
          ),
          CardTile(
            isSelected: index == 6,
            icon: FontAwesomeIcons.upload,
            label: 'Upload Categories',
            onTap: () => indexPage(6),
          ),
          CardTile(
            isSelected: index == 7,
            icon: FontAwesomeIcons.upload,
            label: 'Upload Studios',
            onTap: () => indexPage(7),
          ),
          CardTile(
            isSelected: index == 8,
            icon: FontAwesomeIcons.edit,
            label: 'Update',
            onTap: () => indexPage(8),
          ),
          CardTile(
            isSelected: index == 9,
            icon: FontAwesomeIcons.addressBook,
            label: 'About us',
            onTap: () => indexPage(9),
          ),
        ],
      ),
    );
  }
}

class CardTile extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final String label;
  final Function onTap;

  CardTile({
    @required this.isSelected,
    @required this.icon,
    @required this.label,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context).size;
    bool isTablet = mSize.width < kIsTablet;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: Stack(
        children: [
          Row(
            children: [
              AnimatedContainer(
                width: 10.0,
                height: 50.0,
                duration: Duration(milliseconds: 400),
                curve: Curves.bounceInOut,
                decoration: BoxDecoration(
                  color: isSelected ? kColorPrimary : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                  boxShadow: isSelected ? kShadow01 : [],
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.bounceInOut,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: isSelected ? kColorPrimary : Colors.transparent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      topLeft: Radius.circular(10.0),
                    ),
                    boxShadow: isSelected ? kShadow01 : [],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 20.0,
            right: 0.0,
            child: ListTile(
              onTap: onTap,
              leading: SizedBox(
                width: 40.0,
                child: Icon(
                  icon,
                  color: isSelected ? Colors.white : kColorPrimary,
                ),
              ),
              title: AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOutSine,
                style: TextStyle(
                  color: isSelected ? Colors.white : kColorPrimary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: isTablet ? 0.0 : 16.0,
                ),
                child: Text(
                  label,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
