import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panel_back_end/models/databse.dart';

import 'card_circle_white.dart';

class CardDashboardSize extends StatelessWidget {
  final IconData icon;
  final String label, body;
  final gradient;

  CardDashboardSize({
    @required this.icon,
    @required this.label,
    @required this.body,
    @required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 295,
      height: 276,
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: gradient,
        boxShadow: [
          BoxShadow(
              color: Color(0x29000000),
              offset: Offset(0, 3),
              blurRadius: 6,
              spreadRadius: 0)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(flex: 2, child: CardCircle(icon)),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  body,
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 29,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardDashboardEditorSize extends StatefulWidget {
  final gradient;

  CardDashboardEditorSize({
    @required this.gradient,
  });

  @override
  _CardDashboardEditorSizeState createState() =>
      _CardDashboardEditorSizeState();
}

class _CardDashboardEditorSizeState extends State<CardDashboardEditorSize> {
  bool _isEditor = true;

  Future<void> getData() async {
    final isEditor = await Database.checkEditorIsShoos();
    print(isEditor);
    setState(() {
      _isEditor = isEditor;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 295,
      height: 276,
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: widget.gradient,
        boxShadow: [
          BoxShadow(
              color: Color(0x29000000),
              offset: Offset(0, 3),
              blurRadius: 6,
              spreadRadius: 0)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              flex: 1,
              child: CardCircle(_isEditor
                  ? FontAwesomeIcons.userEdit
                  : FontAwesomeIcons.boxes)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Show',
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Editor Shooses',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Switch(
                    value: _isEditor,
                    onChanged: (val) async {
                      await Database.setEditorIsShoos(
                          value: _isEditor == true ? 'false' : 'true');
                      getData();
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommended',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Switch(
                    value: !_isEditor,
                    onChanged: (val) async {
                      await Database.setEditorIsShoos(
                          value: _isEditor == true ? 'false' : 'true');
                      getData();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
