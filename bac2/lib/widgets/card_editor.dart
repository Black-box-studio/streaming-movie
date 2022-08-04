import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class CardSimpleMovies extends StatefulWidget {
  final image;
  final String name;
  final bool isSelected;

  final Function onDelete;
  final Function onPick;

  CardSimpleMovies({
    this.onDelete,
    this.onPick,
    @required this.image,
    @required this.name,
    this.isSelected = false,
  });

  @override
  _CardSimpleMoviesState createState() => _CardSimpleMoviesState();
}

class _CardSimpleMoviesState extends State<CardSimpleMovies> {
  bool _mouseHover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('click');
      },
      onHover: (mouseHover) {
        setState(() {
          _mouseHover = mouseHover;
        });
      },
      child: Container(
        width: 150.0,
        height: 200.0,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7.0),
                    child: Image(
                      image: NetworkImage(widget.image),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        text: TextSpan(
                          text: '${widget.name}',
                          style: TextStyle(color: kColorBlack03),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: AnimatedContainer(
                width: double.infinity,
                height: _mouseHover ? 60.0 : 0.0,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOutSine,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: kColorPrimary.withOpacity(0.8),
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      widget.isSelected
                          ? FontAwesomeIcons.trashAlt
                          : FontAwesomeIcons.plusCircle,
                      color: Colors.white,
                    ),
                    onPressed:
                        widget.isSelected ? widget.onDelete : widget.onPick,
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
