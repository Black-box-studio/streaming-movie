import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class CardMovies extends StatelessWidget {
  final image;
  final name;
  final summary;
  final number;
  final onEdit, onDelete, onAdd;
  final categories;

  CardMovies({
    @required this.image,
    @required this.name,
    @required this.summary,
    @required this.number,
    @required this.categories,
    @required this.onEdit,
    @required this.onDelete,
    @required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context).size;
    bool isSmall = mSize.width > kIsTablet;
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: kColorGrey02, width: 0.2))),
      child: Row(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TileTXT(number)),
          Expanded(
            flex: 2,
            child: Image(
              image: NetworkImage(image),
              width: double.infinity,
              height: 120.0,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(flex: 2, child: TileTXT('$name')),
          Container(
              height: 120,
              child: VerticalDivider(
                color: kColorGrey02.withOpacity(0.2),
                width: 0.2,
              )),
          isSmall
              ? Expanded(flex: 2, child: Center(child: TileTXT('$categories')))
              : SizedBox(),
          Container(
              height: 120,
              child: VerticalDivider(
                color: kColorGrey02.withOpacity(0.2),
                width: 0.2,
              )),
          Expanded(flex: 3, child: TileTXT('$summary')),
          Container(
              height: 120,
              child: VerticalDivider(
                color: kColorGrey02.withOpacity(0.2),
                width: 0.2,
              )),
          Expanded(
            flex: 2,
            child: Wrap(
              runSpacing: 10.0,
              spacing: 10.0,
              alignment: WrapAlignment.center,
              children: [
                CardRawEdit(
                  onTap: onAdd,
                  colour: Colors.orange,
                  icon: FontAwesomeIcons.plus,
                ),
                CardRawEdit(
                  onTap: onEdit,
                  colour: Colors.green,
                  icon: FontAwesomeIcons.edit,
                ),
                CardRawEdit(
                  onTap: onDelete,
                  colour: Colors.red,
                  icon: FontAwesomeIcons.trash,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardRawEdit extends StatelessWidget {
  final onTap;
  final colour;
  final icon;
  CardRawEdit({this.onTap, this.colour, this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 15.0,
        ),
      ),
    );
  }
}

class TileTXT extends StatelessWidget {
  final label;

  TileTXT(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: RichText(
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text: '$label',
          style: TextStyle(
            color: Color(0xff262626),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class CardCharacter extends StatefulWidget {
  final image;
  final name;
  final onDelete;

  CardCharacter(
      {@required this.image, @required this.name, @required this.onDelete});

  @override
  _CardCharacterState createState() => _CardCharacterState();
}

class _CardCharacterState extends State<CardCharacter> {
  bool ifHover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: (value) {
        setState(() {
          ifHover = value;
        });
      },
      child: Stack(
        children: [
          Container(
            width: 190.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: [
                Expanded(
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    dashPattern: [6, 3, 2, 3],
                    color: kColorGrey04,
                    child: Container(
                      width: 190,
                      decoration: BoxDecoration(
                        color: kColorGrey05,
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage(widget.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  '${widget.name}',
                  style: TextStyle(fontSize: 15.0, color: kColorBlack03),
                ),
              ],
            ),
          ),
          ifHover
              ? Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: AnimatedContainer(
                    width: 190.0,
                    height: 70.0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: kColorPrimary.withOpacity(0.8),
                      borderRadius: BorderRadius.all(
                        Radius.circular(7.0),
                      ),
                    ),
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(FontAwesomeIcons.trashAlt),
                      onPressed: widget.onDelete,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
