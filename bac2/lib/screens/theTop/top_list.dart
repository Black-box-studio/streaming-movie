import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:panel_back_end/models/databse.dart';
import 'package:panel_back_end/models/delete.dart';
import 'package:panel_back_end/models/upload.dart';
import 'package:panel_back_end/widgets/cards_movies.dart';
import 'package:panel_back_end/widgets/cards_snackBar.dart';
import 'package:panel_back_end/widgets/cards_the_top.dart';
import 'package:panel_back_end/widgets/inputs_main.dart';

class TopList extends StatefulWidget {
  @override
  _TopListState createState() => _TopListState();
}

class _TopListState extends State<TopList> {
  var _controllerName = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: Database.getListTheTop(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return LinearProgressIndicator();
              }

              final mData = snapshot.data.docs;

              if (mData.isEmpty) {
                return Container(
                    width: mSize.width,
                    height: mSize.height,
                    child: Text('Empty...'));
              }

              List<Widget> mListCardListTop = [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Center(child: TileTXT('Size'))),
                      Expanded(flex: 2, child: TileTXT('Name')),
                      SizedBox(
                          width: 150.0,
                          child: Center(child: TileTXT('Actions'))),
                    ],
                  ),
                ),
              ];

              for (var list in mData) {
                mListCardListTop.add(
                  CardListTop(
                    title: list.data()['title'],
                    idDocument: list.id,
                    onDelete: () async {
                      showConfirmeDialog(
                          context: context,
                          message: list.data()['name'],
                          action: () async {
                            await Deletes.removeListTheTop(
                                document: list.id, context: context);
                          });
                    },
                    onEdite: () {},
                  ),
                );
              }

              return Container(
                width: mSize.width,
                height: mSize.height,
                child: Column(
                  children: mListCardListTop,
                ),
              );
            }),
        InputAddCategory(
          controller: _controllerName,
          isCategory: false,
          isLoading: isLoading,
          mSize: mSize,
          onAdd: () async {
            setState(() {
              isLoading = true;
            });
            final _upload =
                await Upload.uploadListTheTop(title: _controllerName.text);

            setState(() {
              if (_upload) {
                _controllerName.clear();
                isLoading = false;
              } else {
                isLoading = false;
              }
            });
          },
        ),
      ],
    );
  }
}
