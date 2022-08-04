import 'package:flutter/material.dart';
import 'package:panel_back_end/models/databse.dart';
import 'package:panel_back_end/models/upload.dart';
import 'package:panel_back_end/widgets/cards_update.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class UploadUpdate extends StatefulWidget {
  @override
  _UploadUpdateState createState() => _UploadUpdateState();
}

class _UploadUpdateState extends State<UploadUpdate> {
  bool _progress = false;
  var _title = 'wait...';
  var _message = 'wait...';
  var _version = 'wait...';
  var _lastUpdate = 'wait...';
  var _link = 'wait...';

  var _titleControl = TextEditingController();
  var _messageControl = TextEditingController();
  var _versionControl = TextEditingController();
  var _versionLink = TextEditingController();

  Future<void> getUpdateData() async {
    var _update = await Database.getUpdateInfo();

    setState(() {
      _title = _update['title'] ?? '';
      _message = _update['message'] ?? '';
      _version = _update['version'] ?? '';
      _lastUpdate = _update['lastUpdate'] ?? '';
      _link = _update['link'] ?? 'No link available.';
    });
  }

  @override
  void initState() {
    getUpdateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mSize = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: mSize.width / 2,
        height: (mSize.height / 2) + 300,
        padding: EdgeInsets.all(25.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: kShadow01,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _progress ? LinearProgressIndicator() : SizedBox(),
            CardRowTile(
              label: 'Title',
              text: '$_title',
            ),
            CardRowTile(
              label: 'Message',
              text: '$_message',
            ),
            CardRowTile(
              label: 'Version',
              text: '$_version',
            ),
            CardRowTile(
              label: 'Link',
              text: '$_link',
              onTap: () async {
                if (await canLaunch(_link)) {
                  await launch(_link);
                }
              },
            ),
            CardRowTile(
              label: 'Last Update',
              text: '$_lastUpdate',
            ),
            SizedBox(height: 30.0),
            InputTile(
              hint: 'Title',
              controle: _titleControl,
            ),
            InputTile(
              hint: 'Message',
              maxLine: null,
              controle: _messageControl,
            ),
            InputTile(
              hint: 'Version',
              controle: _versionControl,
            ),
            InputTile(
              hint: 'Link download app',
              controle: _versionLink,
            ),
            SizedBox(height: 30.0),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () async {
                  setState(() {
                    _progress = true;
                  });

                  final _upload = await Upload.uploadUpdate(
                    mMap: {
                      'title': _titleControl.text,
                      'message': _messageControl.text,
                      'version': _versionControl.text,
                      'link': _versionLink.text,
                      'lastUpdate': getDateFormat(DateTime.now()),
                    },
                  );

                  setState(() {
                    if (_upload) {
                      _progress = false;
                      _titleControl.clear();
                      _messageControl.clear();
                      _versionControl.clear();
                      _versionLink.clear();

                      getUpdateData();
                    } else {
                      _progress = false;
                    }
                  });
                },
                color: kColorPrimary,
                textColor: Colors.white,
                child: Text('Send'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
