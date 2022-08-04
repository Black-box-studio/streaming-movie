import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';

class InputSearchMovies extends StatelessWidget {
  final mSize;
  final Function value;

  final onSearch;

  InputSearchMovies({
    this.mSize,
    this.value,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
        ),
        child: Container(
          width: mSize.width,
          height: 50.0,
          decoration: BoxDecoration(
            color: Color(0xffeeeeee),
            boxShadow: kShadow01,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: value,
                  decoration: InputDecoration(
                    hintText: 'Search Name...',
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                  ),
                ),
              ),
              InkWell(
                onTap: onSearch,
                child: Container(
                  width: 55.0,
                  height: double.infinity,
                  color: kColorGreen01,
                  child: Center(
                    child: Icon(
                      FontAwesomeIcons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputText extends StatelessWidget {
  final hint;
  final controller;
  final maxLine;

  InputText({
    this.hint,
    this.controller,
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: kColorGrey03, width: 0.5),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLine,
        decoration: InputDecoration(
          hintText: '$hint',
          enabledBorder: InputBorder.none,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class CardCheckBox extends StatelessWidget {
  final String label;
  final bool selected;
  final Function onChange;

  CardCheckBox({
    @required this.label,
    @required this.selected,
    @required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        '$label',
        style: TextStyle(fontSize: 15.0),
      ),
      value: selected,
      contentPadding: EdgeInsets.symmetric(vertical: 0.0),
      checkColor: Colors.white,
      activeColor: kColorPrimary,
      onChanged: onChange,
    );
  }
}

class CardUploadImage extends StatelessWidget {
  final onTap;
  final String image;
  final bool progress;

  CardUploadImage({
    this.onTap,
    this.image,
    @required this.progress,
  });

  //if image == null show background gry

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      dashPattern: [6, 3, 2, 3],
      color: kColorGrey04,
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: kColorGrey05,
          borderRadius: BorderRadius.circular(5),
          image: image != ''
              ? DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: Center(
          child: progress
              ? CircularProgressIndicator()
              : InkWell(
                  onTap: onTap,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Color(0xffe8505b),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Upload',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class InputCharacter extends StatelessWidget {
  final onSelectImage;
  final onAdd;
  final image;
  final controllerName;
  final bool progress;

  InputCharacter({
    @required this.onAdd,
    @required this.onSelectImage,
    @required this.image,
    @required this.controllerName,
    @required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DottedBorder(
          borderType: BorderType.RRect,
          dashPattern: [6, 3, 2, 3],
          //   color: kColorGrey04,
          child: Container(
            width: 190,
            height: 150,
            decoration: BoxDecoration(
                color: kColorGrey05,
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                )),
            child: Center(
              child: progress
                  ? CircularProgressIndicator()
                  : IconButton(
                      icon: Icon(
                        FontAwesomeIcons.upload,
                        color: kColorPrimary,
                      ),
                      onPressed: onSelectImage,
                    ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        SizedBox(
          width: 190.0,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 28,
                  padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: kColorGrey02,
                      width: 0.2,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      bottomLeft: Radius.circular(5.0),
                    ),
                  ),
                  child: TextField(
                    controller: controllerName,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 12.0),
                    ),
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ),
              InkWell(
                onTap: onAdd,
                child: Container(
                  height: 28,
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: kColorPrimary,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Upload',
                      style: TextStyle(fontSize: 8.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InputTrailer extends StatelessWidget {
  final onAdd;

  final controllerName;

  InputTrailer({
    @required this.onAdd,
    @required this.controllerName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 195.0,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 28,
                  padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: kColorGrey02,
                      width: 0.2,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      bottomLeft: Radius.circular(5.0),
                    ),
                  ),
                  child: TextField(
                    controller: controllerName,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Key Youtube',
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 12.0),
                    ),
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ),
              InkWell(
                onTap: onAdd,
                child: Container(
                  height: 28,
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: kColorPrimary,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Upload',
                      style: TextStyle(fontSize: 8.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InputAddCategory extends StatelessWidget {
  final mSize;
  final onAdd;
  final onUploadImage;
  final image;
  final controller;
  final bool isLoading;
  final bool isCategory;

  InputAddCategory({
    this.mSize,
    this.controller,
    this.onAdd,
    this.onUploadImage,
    this.image,
    this.isLoading,
    this.isCategory = true,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
        ),
        child: Container(
          width: mSize.width,
          height: 60.0,
          decoration: BoxDecoration(
            color: Color(0xffeeeeee),
            boxShadow: kShadow01,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'Name...',
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15.0),
                        ),
                      ),
                    ),
                    isCategory
                        ? InkWell(
                            onTap: onUploadImage,
                            child: Container(
                              width: 100.0,
                              height: double.infinity,
                              color: Colors.orange,
                              child: image != ''
                                  ? Image(
                                      image: NetworkImage(image),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    )
                                  : Center(
                                      child: Icon(
                                        FontAwesomeIcons.image,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          )
                        : SizedBox(),
                    InkWell(
                      onTap: onAdd,
                      child: Container(
                        width: 55.0,
                        height: double.infinity,
                        color: kColorGreen01,
                        child: Center(
                          child: Icon(
                            FontAwesomeIcons.plus,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              isLoading ? LinearProgressIndicator() : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class InputSearchMoviesAndSeries extends StatefulWidget {
  final mSize;
  final Function selectType;

  InputSearchMoviesAndSeries({
    this.mSize,
    this.selectType,
  });

  @override
  _InputSearchMoviesAndSeriesState createState() =>
      _InputSearchMoviesAndSeriesState();
}

class _InputSearchMoviesAndSeriesState
    extends State<InputSearchMoviesAndSeries> {
  int indexType;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
      child: Container(
        width: widget.mSize.width,
        height: 50.0,
        decoration: BoxDecoration(
          color: Color(0xffeeeeee),
          boxShadow: kShadow01,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Name...',
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                ),
              ),
            ),
            CardRawType(
              onTap: () {
                setState(() {
                  indexType == 0 ? indexType = null : indexType = 0;
                  widget.selectType(indexType);
                });
              },
              icon: FontAwesomeIcons.tv,
              isSelected: indexType == 0,
            ),
            CardRawType(
              onTap: () {
                setState(() {
                  indexType == 1 ? indexType = null : indexType = 1;
                  widget.selectType(indexType);
                });
              },
              icon: FontAwesomeIcons.film,
              isSelected: indexType == 1,
            ),
            CardRawType(
              onTap: () {
                setState(() {
                  indexType == 2 ? indexType = null : indexType = 2;
                  widget.selectType(indexType);
                });
              },
              icon: FontAwesomeIcons.magic,
              isSelected: indexType == 2,
            ),
            InkWell(
              onTap: () {
                // search
              },
              child: Container(
                width: 55.0,
                height: double.infinity,
                color: kColorGreen01,
                child: Center(
                  child: Icon(
                    FontAwesomeIcons.search,
                    color: Colors.white,
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

class CardRawType extends StatelessWidget {
  final bool isSelected;
  final Function onTap;
  final IconData icon;

  CardRawType(
      {@required this.isSelected, @required this.onTap, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 55.0,
        height: double.infinity,
        color: isSelected ? kColorPrimary : Colors.grey,
        child: Center(
          child: SizedBox(
            width: 40.0,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

RichText trailerText() {
  return RichText(
    text: TextSpan(children: [
      TextSpan(
        text: "UPLOAD TRAILERS \n",
        style: TextStyle(
          color: kColorGrey04,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
      TextSpan(
        text: "upload only the last key from the Trailer link youtube\n",
        style: TextStyle(
          color: Colors.black54,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
      TextSpan(
        text: "Ex:// https://www.youtube.com/watch?v=",
        style: TextStyle(
          color: Colors.black45,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
      TextSpan(
        text: "zqxJt8M0QRE",
        style: TextStyle(
          color: kColorPrimary,
          fontSize: 15,
          fontWeight: FontWeight.w900,
        ),
      ),
    ]),
  );
}
