import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_simple_video_player/flutter_simple_video_player.dart';

class AzulPlayer extends StatefulWidget {
  final title;
  final linkStream;
  AzulPlayer({this.title, this.linkStream});

  @override
  _AzulPlayerState createState() => _AzulPlayerState();
}

class _AzulPlayerState extends State<AzulPlayer> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleViewPlayer(widget.linkStream, isFullScreen: true);
  }
}
