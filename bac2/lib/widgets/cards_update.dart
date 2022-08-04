import 'package:flutter/material.dart';
import '../constants.dart';

class InputTile extends StatelessWidget {
  final hint;
  final controle;
  final maxLine;

  InputTile({
    this.controle,
    this.hint,
    this.maxLine = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      width: double.infinity,
      child: TextFormField(
        maxLines: maxLine,
        controller: controle,
        decoration: InputDecoration(
          hintText: '$hint',
          labelText: '$hint',
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: kColorPrimary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.grey[300],
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}

class CardRowTile extends StatelessWidget {
  final label;
  final text;
  final onTap;

  CardRowTile({this.label, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label'),
          SizedBox(width: 30.0),
          Expanded(
            child: InkWell(
              onTap: onTap,
              child: Text(
                '$text',
                maxLines: null,
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: kColorBlack02,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
