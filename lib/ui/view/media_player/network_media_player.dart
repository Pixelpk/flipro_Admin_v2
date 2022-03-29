
import 'dart:io';
import 'package:video_player/video_player.dart';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages


class NetworkMediaPlayer extends StatefulWidget {
  final String videoURL ;
  const NetworkMediaPlayer({
    Key? key,
    required  this.videoURL,
  }) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _NetworkMediaPlayerState();
  }
}

class _NetworkMediaPlayerState extends State<NetworkMediaPlayer> {
  TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController?.dispose();
    super.dispose();
  }



  Future<void> initializePlayer() async {

    _videoPlayerController1 =
        VideoPlayerController.network(widget.videoURL);

    await Future.wait([
      _videoPlayerController1.initialize(),

    ]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,


    );
  }

  int currPlayIndex = 0;

  Future<void> toggleVideo() async {
    await _videoPlayerController1.pause();
    currPlayIndex = currPlayIndex == 0 ? 1 : 0;
    await initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Media Preview"),centerTitle: true,elevation: 0,backgroundColor: Colors.black,),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: _chewieController != null &&
                    _chewieController!
                        .videoPlayerController.value.isInitialized
                    ? Chewie(
                  controller: _chewieController!,
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text('Loading'),
                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}