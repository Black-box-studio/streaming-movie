import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iqplayer/iqplayer.dart';

import '../../constants.dart';

class SpeedPlayer extends StatefulWidget {
  final title;
  final linkStream;
  SpeedPlayer({this.title, this.linkStream});

  @override
  _SpeedPlayerState createState() => _SpeedPlayerState();
}

class _SpeedPlayerState extends State<SpeedPlayer> {
  bool isFullScreen = true;

  VideoPlayerController _videoPlayerController;

  setFullScreen() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.linkStream)
      ..initialize().then((value) {
        setFullScreen();
      });
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

    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IQScreen(
      title: widget.title ?? kAppName,
      videoPlayerController: _videoPlayerController,
      iqTheme: IQTheme(
        loadingProgress: SpinKitCircle(
          color: kColorRed01,
        ),
        playButtonColor: Colors.transparent,
        videoPlayedColor: kColorRed01,
        backgroundProgressColor: kColorRed01.withOpacity(0.5),
        lockRotation: (context, b, a) {
          return SizedBox();
        },
        playButton: (context, bool isPlay, anim) {
          if (isPlay)
            return Icon(
              FontAwesomeIcons.solidPauseCircle,
              color: Colors.white,
              size: 50,
            );
          return Icon(
            FontAwesomeIcons.solidPlayCircle,
            color: Colors.white,
            size: 50,
          );
        },
      ),
    );
  }
}
