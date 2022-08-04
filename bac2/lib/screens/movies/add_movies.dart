import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panel_back_end/constants.dart';
import 'package:panel_back_end/models/databse.dart';
import 'package:panel_back_end/models/ui/ui.dart';
import 'package:panel_back_end/models/upload.dart';
import 'package:panel_back_end/widgets/cards_movies.dart';
import 'package:panel_back_end/widgets/inputs_main.dart';

class AddMovies extends StatefulWidget {
  @override
  _AddMoviesState createState() => _AddMoviesState();
}

class _AddMoviesState extends State<AddMovies> {
  var _name = TextEditingController();
  var _summary = TextEditingController();
  var _date = TextEditingController();
  var _firstAired = TextEditingController();
  var _status = TextEditingController();
  var _minutes = TextEditingController();
  //var _season = TextEditingController();
  var _format = TextEditingController();
  var _source = TextEditingController();
  var _linkMovie = TextEditingController();
  var _keyYoutube = TextEditingController();
  var _imageCover = '';
  var _imageCharacter = '';

  var _characterName = TextEditingController();

  bool _progressCharacter = false;
  bool _progressCover = false;

  List<Categories> _listCategories = [];
  List<Studios> _listStudio = [];
  List<Character> _listCharacter = [];
  List<String> _listTrailers = [];

  List<TextEditingController> _listServers;
  List<InputText> mListInputText;

  Future<void> getCategories() async {
    final _catie = await Database.getListCategories();
    for (var caty in _catie) {
      // print(caty.data()['title']);
      setState(() {
        _listCategories.add(
          Categories(
              image: caty.data()['image'],
              title: caty.data()['title'],
              selected: false),
        );
      });
    }
  }

  Future<void> getStudios() async {
    final _studio = await Database.getListStudios();
    for (var caty in _studio) {
      setState(() {
        _listStudio.add(
          Studios(title: caty.data()['title'].toString(), selected: false),
        );
      });
    }
  }

  @override
  void initState() {
    getCategories();
    getStudios();
    super.initState();

    _listServers = [TextEditingController()];
    mListInputText = [
      InputText(
        hint: 'Movie Link (flv, mp4 and etc.)',
        maxLine: 1,
        controller: _listServers[0],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context).size;

    return Container(
      width: mSize.width / 2.5,
      height: mSize.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.0),
            Text(
              "Add Movie",
              style: TextStyle(
                color: kColorBlack03,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              "Please fill out important fields !",
              style: TextStyle(
                color: kColorPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 15.0),
            InputText(
              hint: 'Name',
              maxLine: 1,
              controller: _name,
            ),
            InputText(
              hint: 'Summary',
              maxLine: null,
              controller: _summary,
            ),
            Row(
              children: [
                Expanded(
                  child: InputText(
                    hint: 'Date',
                    maxLine: 1,
                    controller: _date,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: InputText(
                    hint: 'First Aired',
                    maxLine: 1,
                    controller: _firstAired,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: InputText(
                    hint: 'Status',
                    maxLine: 1,
                    controller: _status,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: InputText(
                    hint: 'Minutes',
                    maxLine: 1,
                    controller: _minutes,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: InputText(
                    hint: 'Format',
                    maxLine: 1,
                    controller: _format,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: InputText(
                    hint: 'Source',
                    maxLine: 1,
                    controller: _source,
                  ),
                ),
              ],
            ),

            SizedBox(height: 15.0),
            Text(
              "Choose Movies Category",
              style: TextStyle(
                color: kColorGrey04,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 15.0),
            // LIST Categories
            Container(
              width: double.infinity,
              height: 250.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: kColorGrey05,
                borderRadius: BorderRadius.circular(5),
              ),
              child: _listCategories.isNotEmpty
                  ? ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: _listCategories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CardCheckBox(
                          onChange: (bool val) {
                            setState(() {
                              _listCategories[index].selected = val;
                            });
                          },
                          selected: _listCategories[index].selected,
                          label: _listCategories[index].title,
                        );
                      },
                    )
                  : Center(child: Text('try Enter first some Categories...')),
            ),
            SizedBox(height: 15.0),
            Text(
              "Choose Studio",
              style: TextStyle(
                color: kColorGrey04,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 15.0),
            // LIST Studios
            Container(
              width: double.infinity,
              height: 250.0,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: kColorGrey05,
                borderRadius: BorderRadius.circular(5),
              ),
              child: _listStudio.isNotEmpty
                  ? ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: _listStudio.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CardCheckBox(
                          onChange: (bool val) {
                            setState(() {
                              _listStudio[index].selected = val;
                            });
                          },
                          selected: _listStudio[index].selected,
                          label: _listStudio[index].title,
                        );
                      },
                    )
                  : Center(child: Text('try Enter first some Studios...')),
            ),
            SizedBox(height: 15.0),
            Text(
              "UPLOAD MOVIE COVER",
              style: TextStyle(
                color: kColorGrey04,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 15.0),
            CardUploadImage(
              progress: _progressCover,
              image: _imageCover,
              onTap: () async {
                setState(() {
                  _progressCover = true;
                });

                final _fileImage = await Upload.selectImage();
                setState(() {
                  _imageCover = _fileImage;
                  _progressCover = false;
                });
              },
            ),
            SizedBox(height: 15.0),
            trailerText(),
            SizedBox(height: 15.0),
            // TRAILERS
            SizedBox(
              width: double.infinity,
              height: 180.0,
              child: Row(
                children: [
                  InputTrailer(
                    controllerName: _keyYoutube,
                    onAdd: () {
                      _listTrailers.add(
                        _keyYoutube.text,
                      );
                      setState(() {
                        _keyYoutube.clear();
                      });
                    },
                  ),
                  Flexible(
                    child: ListView.builder(
                      itemCount: _listTrailers.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CardCharacter(
                          image:
                              'https://i.ytimg.com/vi/${_listTrailers[index]}/maxresdefault.jpg',
                          name: _listTrailers[index],
                          onDelete: () {
                            setState(() {
                              _listTrailers.removeAt(index);
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.0),

            Text(
              "UPLOAD CHARACTER",
              style: TextStyle(
                color: kColorGrey04,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 15.0),
            // CHARACTERS
            SizedBox(
              width: double.infinity,
              height: 200.0,
              child: Row(
                children: [
                  InputCharacter(
                    progress: _progressCharacter,
                    image: _imageCharacter,
                    controllerName: _characterName,
                    onSelectImage: () async {
                      setState(() {
                        _progressCharacter = true;
                      });
                      final _image = await Upload.selectImage();

                      setState(() {
                        _imageCharacter = _image;
                        _progressCharacter = false;
                      });
                    },
                    onAdd: () {
                      _listCharacter.add(
                        Character(
                            image: _imageCharacter, name: _characterName.text),
                      );

                      setState(() {
                        _imageCharacter = '';
                        _characterName.clear();
                      });
                    },
                  ),
                  Flexible(
                    child: ListView.builder(
                      itemCount: _listCharacter.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CardCharacter(
                          image: _listCharacter[index].image,
                          name: _listCharacter[index].name,
                          onDelete: () {
                            setState(() {
                              _listCharacter.removeAt(index);
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              "UPLOAD SERVERS MOVIE",
              style: TextStyle(
                color: kColorGrey04,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            /*  SizedBox(height: 15.0),
            Column(children: mListInputText),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                mListInputText.length > 1
                    ? FlatButton(
                        onPressed: () {
                          if (mListInputText.length != 1) {
                            setState(() {
                              mListInputText.removeLast();
                              _listServers.removeLast();
                            });
                          }
                        },
                        textColor: Colors.white,
                        child: Text('remove'),
                        color: Colors.red,
                      )
                    : SizedBox(),
                SizedBox(width: 10.0),
                FlatButton(
                  onPressed: () {
                    var sizeList = mListInputText.length;
                    setState(() {
                      _listServers.add(TextEditingController());
                      mListInputText.add(
                        InputText(
                          hint: 'Movie Link (flv, mp4 and etc.)',
                          maxLine: 1,
                          controller: _listServers[sizeList],
                        ),
                      );
                    });
                  },
                  textColor: Colors.white,
                  child: Text('Add More'),
                  color: Colors.green,
                ),
              ],
            ),
           */
            SizedBox(height: 40.0),
            Center(
              child: InkWell(
                onTap: () async {
                  final mUplaod = await Upload.uploadMovie(
                    date: _date.text.toString(),
                    name: _name.text.toString(),
                    firstAired: _firstAired.text.toString(),
                    format: _format.text.toString(),
                    imageCover: _imageCover.toString(),
                    linkMovie: _linkMovie.text.toString(),
                    minutes: _minutes.text.toString(),
                    summary: _summary.text.toString(),
                    status: _status.text.toString(),
                    source: _source.text.toString(),
                    listCategories: _listCategories,
                    listStudios: _listStudio,
                    listCharacters: _listCharacter,
                    //listServers: _listServers,
                    listTrailers: _listTrailers,
                  );

                  if (mUplaod) {
                    print('Data Uploaded.');

                    setState(() {
                      _date.clear();
                      _name.clear();
                      _firstAired.clear();
                      _format.clear();
                      _minutes.clear();
                      _summary.clear();
                      _status.clear();
                      _source.clear();

                      _linkMovie.clear();
                      _listCharacter.clear();
                      _listTrailers.clear();

                      for (var clean in _listServers) {
                        clean.clear();
                        if (_listServers.length != 1) {
                          mListInputText.removeLast();
                          _listServers.removeLast();
                        }
                      }

                      _imageCover = '';
                    });
                  } else {}
                },
                child: Container(
                  width: 264,
                  height: 30,
                  decoration: BoxDecoration(
                    color: kColorPrimary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'Upload',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 100.0),
          ],
        ),
      ),
    );
  }
}
