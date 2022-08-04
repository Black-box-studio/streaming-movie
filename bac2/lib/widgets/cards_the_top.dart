import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panel_back_end/models/databse.dart';
import 'package:panel_back_end/widgets/cards_movies.dart';

import '../constants.dart';

class CardListTop extends StatelessWidget {
  final idDocument;
  final String title;
  final Function onDelete;
  final Function onEdite;

  CardListTop({
    this.idDocument,
    this.title,
    this.onDelete,
    this.onEdite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          FutureBuilder(
            future: Database.getSizeListTopPick(document: idDocument),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('wait...');
              }

              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Center(child: TileTXT('${snapshot.data}')));
            },
          ),
          Expanded(flex: 2, child: TileTXT('$title')),
          SizedBox(
            width: 120.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: IconButton(
                    onPressed: onEdite,
                    icon: Icon(
                      FontAwesomeIcons.edit,
                      color: Colors.white,
                      size: 15.0,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                CircleAvatar(
                  backgroundColor: kColorPrimary,
                  child: IconButton(
                    onPressed: onDelete,
                    icon: Icon(
                      FontAwesomeIcons.trashAlt,
                      color: Colors.white,
                      size: 15.0,
                    ),
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

class CardPick extends StatelessWidget {
  final label;
  final onTap;
  final isSelected;

  CardPick({this.label, this.onTap, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60.0,
        margin: EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            Container(
              width: 10.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: isSelected ? kColorPrimary : Colors.transparent,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? kColorPrimary : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    '$label',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSelected ? Colors.white : kColorPrimary,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
