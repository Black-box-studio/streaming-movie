import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panel_back_end/constants.dart';
import 'package:panel_back_end/models/databse.dart';
import 'package:panel_back_end/models/ui/ui.dart';
import 'package:panel_back_end/models/update.dart';
import 'package:panel_back_end/models/upload.dart';
import 'package:panel_back_end/widgets/cards_movies.dart';
import 'package:panel_back_end/widgets/inputs_main.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class EditMovie extends StatefulWidget {
  final idMovie;
  EditMovie({@required this.idMovie});

  @override
  _EditMovieState createState() => _EditMovieState();
}

class _EditMovieState extends State<EditMovie> {
  var _name = TextEditingController();
  var _summary = TextEditingController();
  var _date = TextEditingController();
  var _firstAired = TextEditingController();
  var _status = TextEditingController();
  var _minutes = TextEditingController();
  var _format = TextEditingController();
  var _source = TextEditingController();
  var _linkMovie = TextEditingController();
  var _keyYoutube = TextEditingController();
  var _imageCover = '';
  var _imageCharacter = '';

  var _characterName = TextEditingController();

  bool _progressCharacter = false;
  bool _progressCover = false;
  bool _progressDataMovie = false;

  List<Categories> _listCategories = [];
  List<Studios> _listStudio = [];
  List<Character> _listCharacter = [];
  List<String> _listTrailers = [];

  Future<void> getCategories({data}) async {
    final _catie = await Database.getListCategories();

    ///get all categories
    for (var i = 0; i < _catie.length; i++) {
      var pickedCaty = _catie[i].data();

      setState(() {
        _listCategories.add(
          Categories(
            image: pickedCaty['image'],
            title: pickedCaty['title'],
            selected: false,
          ),
        );
      });
    }

    //get selected data ListCategories
    for (var s = 0; s < _listCategories.length; s++) {
      //check if stuido has selected
      for (var i = 0; i < data.length; i++) {
        var oldCaty = data[i].toString();

        if (_listCategories[s].title == oldCaty) {
          _listCategories[s] = Categories(
            title: _listCategories[s].title,
            image: _listCategories[s].image,
            selected: true,
          );
        }
      }
    }
  }

  Future<void> getStudios({data}) async {
    final _studio = await Database.getListStudios();

    ///get all Studios
    for (var v = 0; v < _studio.length; v++) {
      var newStudio = _studio[v].data()['title'];

      setState(() {
        _listStudio.add(
          Studios(title: newStudio, selected: false),
        );
      });
    }

    //get selected data ListStudio
    for (var s = 0; s < _listStudio.length; s++) {
      //check if stuido has selected
      for (var i = 0; i < data.length; i++) {
        var oldStudio = data[i].toString();

        if (_listStudio[s].title == oldStudio) {
          _listStudio[s] = Studios(title: _listStudio[s].title, selected: true);
        }
      }
    }
  }

  Future<void> getTrailerList({data}) async {
    for (var trialer in data) {
      setState(() {
        _listTrailers.add(trialer['link']);
      });
    }
  }

  Future<void> getCharacterList({data}) async {
    for (var trialer in data) {
      setState(() {
        _listCharacter
            .add(Character(image: trialer['image'], name: trialer['name']));
      });
    }
  }

  Future<void> getDataMovie() async {
    final _movie = await Database.getMovieData(idMovie: widget.idMovie);

    setState(() {
      _name.text = _movie['name'];
      _summary.text = _movie['summary'];
      _date.text = _movie['date'];
      _firstAired.text = _movie['firstAired'];
      _status.text = _movie['status'];
      _minutes.text = _movie['time'];
      _format.text = _movie['format'];
      _source.text = _movie['source'];
      _imageCover = _movie['image'];
    });

    getStudios(data: _movie['studio']);
    getCategories(data: _movie['categories']);
    getTrailerList(data: _movie['trailers']);
    getCharacterList(data: _movie['characters']);
  }

  @override
  void initState() {
    getDataMovie();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Edit Movie'),
      ),
      body: Container(
        width: mSize.width,
        height: mSize.height,
        child: Center(
          child: Container(
            width: mSize.width / 2.0,
            height: mSize.height,
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20.0),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Edit this Movie: ",
                          style: TextStyle(
                            color: kColorBlack03,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: "${_name.text}",
                          style: TextStyle(
                            color: kColorBlack03,
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
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

                  SizedBox(height: 30.0),
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
                        : Center(
                            child: Text('try Enter first some Categories...')),
                  ),
                  SizedBox(height: 30.0),
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
                        : Center(
                            child: Text('try Enter first some Studios...')),
                  ),
                  SizedBox(height: 30.0),
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
                  SizedBox(height: 30.0),
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
                  SizedBox(height: 30.0),

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
                                  image: _imageCharacter,
                                  name: _characterName.text),
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
                  SizedBox(height: 100.0),
                  Text(
                    "UPDATE DATA MOVIE",
                    style: TextStyle(
                      color: kColorGrey04,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          _progressDataMovie = true;
                        });
                        final mUplaod = await Update.updateMovie(
                          idMovie: widget.idMovie,
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
                          listTrailers: _listTrailers,
                        );

                        if (mUplaod) {
                          print('Data Uploaded.');
                          Navigator.pop(context);
                          // ignore: deprecated_member_use
                          _scaffoldKey.currentState.showSnackBar(new SnackBar(
                              content: new Text('Data Updated succescfuly')));
                        } else {
                          // ignore: deprecated_member_use
                          _scaffoldKey.currentState.showSnackBar(new SnackBar(
                              content:
                                  new Text('Error while Updating Data!!')));
                          setState(() {
                            _progressDataMovie = false;
                          });
                        }
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
                            'Update Data',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 100.0),
                  _progressDataMovie ? LinearProgressIndicator() : SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
