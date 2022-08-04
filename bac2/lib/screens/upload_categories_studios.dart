import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panel_back_end/constants.dart';
import 'package:panel_back_end/models/databse.dart';
import 'package:panel_back_end/models/delete.dart';
import 'package:panel_back_end/models/upload.dart';
import 'package:panel_back_end/widgets/cards_movies.dart';
import 'package:panel_back_end/widgets/cards_snackBar.dart';
import 'package:panel_back_end/widgets/inputs_main.dart';

class UploadCategoriesAndStudios extends StatefulWidget {
  final isCategory;
  UploadCategoriesAndStudios({this.isCategory = true});

  @override
  _UploadCategoriesAndStudiosState createState() =>
      _UploadCategoriesAndStudiosState();
}

class _UploadCategoriesAndStudiosState
    extends State<UploadCategoriesAndStudios> {
  var _controllerName = TextEditingController();
  var _image = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Center(child: TileTXT('#'))),
                  widget.isCategory
                      ? SizedBox(
                          width: 150.0, child: Center(child: TileTXT('image')))
                      : SizedBox(),
                  Expanded(flex: 2, child: TileTXT('Name')),
                  SizedBox(
                      width: 200.0, child: Center(child: TileTXT('Actions'))),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: Database.getCategoriesAndStudio(
                    type: widget.isCategory ? 'Categories' : 'Studios'),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final mCaty = snapshot.data.docs;
                  if (mCaty.isEmpty) {
                    return Center(child: Text('Empty!! try to upload some...'));
                  }

                  List<CardCategory> mListCardCategory = [];

                  for (var i = 0; i < mCaty.length; i++) {
                    mListCardCategory.add(
                      CardCategory(
                        isCategory: widget.isCategory,
                        title: mCaty[i].data()['title'],
                        image: mCaty[i].data()['image'] ?? kLogo01,
                        number: i + 1,
                        onDelete: () async {
                          showConfirmeDialog(
                              context: context,
                              message: mCaty[i].data()['name'],
                              action: () async {
                                Deletes.removeCategory(
                                    document: mCaty[i].id, context: context);
                              });
                        },
                      ),
                    );
                  }

                  return Flexible(
                    child: ListView(
                      children: mListCardCategory,
                    ),
                  );
                }),
          ],
        ),
        InputAddCategory(
          mSize: mSize,
          image: _image,
          isLoading: isLoading,
          isCategory: widget.isCategory,
          onAdd: () async {
            setState(() {
              isLoading = true;
            });

            final bool uploadCaty = await Upload.uploadCategoriesAndStudio(
              title: capitalize(_controllerName.text),
              image: _image,
              type: widget.isCategory ? 'Categories' : 'Studios',
            );

            if (uploadCaty) {
              setState(() {
                _controllerName.clear();
                _image = '';
                isLoading = false;
              });
            }
          },
          controller: _controllerName,
          onUploadImage: widget.isCategory
              ? () async {
                  setState(() {
                    isLoading = true;
                  });
                  var img = await Upload.selectImage();
                  setState(() {
                    _image = img ?? '';
                    isLoading = false;
                  });
                }
              : null,
        ),
      ],
    );
  }
}

class CardCategory extends StatelessWidget {
  final number;
  final String title;
  final Function onDelete;
  final image;
  final bool isCategory;

  CardCategory({
    this.number,
    this.title,
    this.onDelete,
    this.image,
    this.isCategory = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(child: TileTXT('$number'))),
          isCategory
              ? Image(
                  image: NetworkImage(image),
                  width: 150.0,
                  height: 80.0,
                  fit: BoxFit.cover,
                )
              : SizedBox(),
          Expanded(flex: 2, child: TileTXT('$title')),
          SizedBox(
            width: 200.0,
            child: Center(
              child: CircleAvatar(
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
            ),
          ),
        ],
      ),
    );
  }
}
